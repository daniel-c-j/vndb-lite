import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/common_widgets/generic_failure_connection.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/common_widgets/generic_snackbar.dart';
import 'package:vndb_lite/src/features/_base/presentation/upper_parts/tabs_sliver_appbar.dart';
import 'package:vndb_lite/src/routing/app_router.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/chart/presentation/stat_chart.dart';
import 'package:vndb_lite/src/features/search/data/remote/remote_search_repo.dart';
import 'package:vndb_lite/src/features/search/presentation/search_result.dart';
import 'package:vndb_lite/src/features/search/presentation/search_result_controller.dart';
import 'package:vndb_lite/src/features/search/presentation/search_screen_controller.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';
import 'package:vndb_lite/src/features/sort_filter/data/sortable_data.dart';
import 'package:vndb_lite/src/features/sort_filter/presentation/remote/remote_sort_filter_controller.dart';

import '../../../util/alt_provider_reader.dart';

final innerSearchControllerProvider = StateProvider<ScrollController?>((ref) {
  return;
});

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  static const Key onHoldStatusKey = ValueKey("onhold");

  // * To maintain consistency in screen that has lots of items. Convert into stateNotifier?
  static double scrollOffset = 0;

  void _showConnectionErrorSnackbar() {
    final snackbar = GenericSnackBar(
      duration: const Duration(milliseconds: 6000),
      content: [
        Icon(
          Icons.signal_wifi_statusbar_connected_no_internet_4_rounded,
          color: Colors.red,
          size: responsiveUI.snackbarIcon,
        ),
        SizedBox(width: responsiveUI.own(0.018)),
        Flexible(
          child: ShadowText(
            'Connection error, unable to fetch data.\nPlease try again later.',
            fontSize: responsiveUI.snackbarTxt,
          ),
        ),
      ],
    );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      GenericSnackBar.hide();
      snackbar.show();
    });
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  // ! NOT FUNCTIONAL ANYMORE THE MOMENT THE NEW VERSION OF MASONRYGRID IS INTRODUCED WITH SHRINKWRAP
  // These functions exists because of how the searchScreenController state value, is only
  // returning FutureBuilder<dynamic>, not what the FutureBuilder itself returns.
  // Thus placeholders, and something like that need to be synthetically injected to the state.

  void _readyToRefetch() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref_.read(searchResultPageControllerProvider.notifier).decrement();
    });
  }

  void _setNoResultYetSearchIndicator() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref_
          .read(searchScreenControllerProvider.notifier)
          .add(const SizedBox.shrink(key: onHoldStatusKey));
    });
  }

  void _removeErrorOrLoadingWidget({bool once = false}) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final results = ref_.read(searchScreenControllerProvider);

      if (results.isNotEmpty && results.last is SizedBox) {
        // 1. Remove the sizedBox
        ref_.read(searchScreenControllerProvider.notifier).removeLast();
        if (once || results.isEmpty) return;

        // 2. Remove the latest result that caused the sizedBox
        ref_.read(searchScreenControllerProvider.notifier).removeLast();
      }
    });
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Widget _initiateSearch(int pageResult) {
    final sortData = ref_.read(appliedRemoteSortControllerProvider);
    final filterData = ref_.read(appliedRemoteFilterControllerProvider);

    final remoteRepo = ref_.read(remoteSearchRepoProvider);
    final requestData = remoteRepo.formatRemoteSearchRequest(
      pageResult: pageResult,
      sortData: sortData,
      filterData: filterData,
    );

    return FutureBuilder(
      future: remoteRepo.remoteSearchVn(requestData),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          _removeErrorOrLoadingWidget();
          _setNoResultYetSearchIndicator();

          // Show loading widget
          return Padding(
            key: onHoldStatusKey,
            padding: EdgeInsets.only(
              bottom: (pageResult > 1) ? 0 : MediaQuery.sizeOf(context).height * 0.15,
            ),
            child: SizedBox(
              height:
                  (pageResult > 1)
                      // Appending existing result
                      ? MediaQuery.sizeOf(context).height * 0.2
                      : MediaQuery.sizeOf(context).height * 0.65, // First-time result
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (snapshot.hasError) {
          _showConnectionErrorSnackbar();
          _removeErrorOrLoadingWidget();
          _readyToRefetch();

          // Configured in ApiService class for a scenario when no internet connection,
          // the exception type goes with connectionTimeout.
          if ((snapshot.error as DioException).type == DioExceptionType.connectionTimeout &&
              pageResult > 1) {
            return const SizedBox.shrink(key: onHoldStatusKey);
          }

          // For a none no internet connection error, the way to continue searching is blocked,
          // until the user refreshes the search.
          _setNoResultYetSearchIndicator();

          // TODO better network error UI?
          return SingleChildScrollView(
            key: onHoldStatusKey,
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: SizedBox(
              height:
                  (pageResult > 1)
                      ? MediaQuery.sizeOf(context).height *
                          0.2 // Appending existing result
                      : MediaQuery.sizeOf(context).height * 0.75, // First-time result
              child: const GenericFailureConnection(),
            ),
          );
        }

        // Only removing the sizedBox placeholder.
        _removeErrorOrLoadingWidget(once: true);
        final result = snapshot.data?.data['results'];

        if (result.isEmpty || result == null) {
          // Will not be able continue
          _setNoResultYetSearchIndicator();

          return Center(
            key: onHoldStatusKey,
            child: Padding(
              padding: EdgeInsets.all(responsiveUI.own(0.1)),
              child: ShadowText("No further results ;)"),
            ),
          );
        }

        // Communicate with searchResultController that will present the widgets item from
        // formatting the raw response into the classified model then to the widgets.
        final labelCode =
            ((requestData.sort ?? '') == SortableCode.searchrank.name)
                ? SortableCode.title.name
                : (requestData.sort ?? '');
        final p1 = remoteRepo.p1ListFromResponse(result);

        // Append the result to the controller, and should update UI.
        ref_.read(searchResultControllerProvider.notifier).fromP1(p1, labelCode);

        // Only for the first time result, it will show the SearchResult widget, but afterwards the result will
        // just append the already existing searchResult from searchResultProvider.
        if (pageResult == 1) {
          return const SearchResult();
        }

        return const SizedBox.shrink();
      },
    );
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsGeneralStateProvider);
    final searchFilter = ref.watch(appliedRemoteFilterControllerProvider).search;

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (_, __) => const [TabAppBar(route: AppRoute.search)],
      body: Builder(
        builder: (context) {
          // Shows default widget in search screen based on configured settings, and search screen state.
          if (searchFilter.isEmpty) {
            if (settings.showChart) return const VNDBStatsChart();
            return const SizedBox.shrink();
          }

          return Consumer(
            builder: (context, ref, child) {
              final searchNotify = ref.watch(searchResultNotifierProvider);
              final pageResult = ref.watch(searchResultPageControllerProvider);

              if (searchNotify && App.isInSearchScreen) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  ref_.read(searchResultNotifierProvider.notifier).end();
                  ref_
                      .read(searchScreenControllerProvider.notifier)
                      .add(_initiateSearch(pageResult));
                });
              }

              final state = ref.watch(searchScreenControllerProvider);
              if (state.isEmpty) return const SizedBox.shrink();
              return state[0];
            },
          );
        },
      ),
    );
  }
}
