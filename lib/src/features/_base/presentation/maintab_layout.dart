import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:vndb_lite/src/common_widgets/generic_background.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/common_widgets/generic_snackbar.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_appbar_tabs.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/_base/presentation/other_parts/main_scaffold_layout.dart';
import 'package:vndb_lite/src/features/_base/presentation/other_parts/navigation_rail_menu.dart';
import 'package:vndb_lite/src/features/_base/presentation/upper_parts/tabs_sliver_appbar.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/multiselection/record_selected_controller.dart';
import 'package:vndb_lite/src/features/search/presentation/search_result_controller.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_data_state.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/features/_base/presentation/lower_parts/tabs_bottom_navbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/util/version_check/version_checker.dart';

import '../../theme/theme_data_provider.dart';

// * Intentionally made global to be easily accessing the value throughout the entire
// * widget tree for specific and crucial use cases.
final textControllerCollection = TextEditingController();
final textControllerSearch = TextEditingController();
final mainScrollController = ScrollController();

// * Once-check flags
bool _updateIsChecked = false;
bool _collectionTabInitialized = false;

class MainTabLayout extends StatelessWidget {
  MainTabLayout({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  void _showVersionCheckSnackbar({required bool success}) {
    GenericSnackBar(
      duration: const Duration(milliseconds: 3000),
      content: [
        Icon(
          (success) ? Icons.check_circle : Icons.error,
          color: (success) ? Colors.green : Colors.red,
          size: responsiveUI.snackbarIcon,
        ),
        SizedBox(width: responsiveUI.own(0.015)),
        ShadowText(
          (success) ? "App is Up-to-date" : "Failed checking new version",
          fontSize: responsiveUI.snackbarTxt,
        ),
      ],
    ).show();
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  void _goToBranch(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    // debugPrint('Current pixel : ${notification.metrics.pixels}');
    // debugPrint('Max scroll in pixel : ${notification.metrics.maxScrollExtent}');

    // This supports search screen lazy loading when user hit the bottom screen, the result continues.
    if (App.isInSearchScreen) {
      ref_.read(searchResultControllerProvider.notifier).handleNextResult(notification);
    }

    return false;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  void _checkUpdate() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (ref_.read(settingsDataStateProvider).autoUpdate) {
        VersionChecker.check(notify: (value) => _showVersionCheckSnackbar(success: value));
        _updateIsChecked = true;
      }
    });
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final body = NestedScrollView(
      floatHeaderSlivers: true,
      controller: mainScrollController,
      // ! Do not set to constant.
      headerSliverBuilder: (_, __) => <Widget>[TabAppBar()],
      body: MainScaffoldBody(navigationShell: navigationShell),
    );

    // * Checks version at startup after everything loads.
    if (!_updateIsChecked) _checkUpdate();

    return Stack(
      children: [
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        Consumer(
          builder: (context, ref, child) {
            final theme = ref.watch(appThemeStateProvider);
            return GenericBackground(imagePath: theme.backgroundImgPath);
          },
        ),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // ! Initialization must be happened inside of widget tree.
        if (!_collectionTabInitialized)
          Builder(
            builder: (ctx) {
              SchedulerBinding.instance.addPostFrameCallback(
                (_) => _collectionTabInitialized = true,
              );
              return const CollectionTabConf();
            },
          ),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: !App.isInCollectionScreen,
          backgroundColor: Colors.black.withOpacity(0.3),
          body: Row(
            children: [
              // * Exclusive landscape mode only
              if (isLandscape)
                TabsSideNavbar(selectedIndex: navigationShell.currentIndex, onTap: _goToBranch),
              Expanded(
                child:
                    // * Listener only active when it's in search screen.
                    (App.isInSearchScreen)
                        ? NotificationListener(
                          onNotification: _handleScrollNotification,
                          child: body,
                        )
                        : body,
              ),
            ],
          ),
          //
          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          // Exclusive portrait mode only
          bottomNavigationBar: Consumer(
            builder: (context, ref, child) {
              final isInMultiSelection = ref.watch(recordSelectedControllerProvider).isNotEmpty;

              // Disappear when in multiselection mode.
              if (isInMultiSelection) return const SizedBox.shrink();

              return TabsBottomNavbar(
                onlyProgressIndicator: isLandscape,
                selectedIndex: navigationShell.currentIndex,
                scrollController: mainScrollController,
                onTap: _goToBranch,
              );
            },
          ),
        ),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
      ],
    );
  }
}
