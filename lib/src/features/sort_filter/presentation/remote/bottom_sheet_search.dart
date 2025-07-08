import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/common_widgets/custom_button.dart';
import 'package:vndb_lite/src/constants/defaults.dart';
import 'package:vndb_lite/src/features/_base/presentation/upper_parts/appbar_searchfield.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/search/presentation/search_screen_controller.dart';
import 'package:vndb_lite/src/features/sort_filter/presentation/components/tab_header.dart';
import 'package:contentsize_tabbarview/contentsize_tabbarview.dart';
import 'package:vndb_lite/src/features/sort_filter/presentation/remote/filter_vn_search.dart';
import 'package:vndb_lite/src/features/sort_filter/presentation/remote/remote_sort_filter_controller.dart';
import 'package:vndb_lite/src/features/sort_filter/presentation/remote/sort_vn_search.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

class BottomSheetSearch extends ConsumerStatefulWidget {
  const BottomSheetSearch({super.key});

  @override
  ConsumerState<BottomSheetSearch> createState() {
    return _BottomSheetSearchState();
  }
}

class _BottomSheetSearchState extends ConsumerState<BottomSheetSearch>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _applyFiltersToQuery() async {
    if (AppBarSearchfield.controllerSearch.text.isEmpty) {
      AppBarSearchfield.controllerSearch.text = ' ';
      ref
          .read(tempRemoteFilterControllerProvider.notifier)
          .copyWith(search: AppBarSearchfield.controllerSearch.text);
    }

    // Applying the temp filter to the real post request data.
    final tempFilter = ref.read(tempRemoteFilterControllerProvider);
    final tempSort = ref.read(tempRemoteSortControllerProvider);
    ref.read(appliedRemoteFilterControllerProvider.notifier).importFilterData(tempFilter);
    ref.read(appliedRemoteSortControllerProvider.notifier).importSortData(tempSort);

    // Initiate search.
    await ref.read(searchScreenControllerProvider.notifier).searchWithCurrentConf();
    Navigator.of(context).pop();
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(15),
        topLeft: Radius.circular(15),
      ),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.75,
        width: MediaQuery.sizeOf(context).width,
        // TODO use global if keyboard is opened, keyboard height?
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              kColor(context).primary.withOpacity(0.8),
              kColor(context).primary.withOpacity(0.8),
              (kColor(context).tertiary == Colors.black)
                  ? const Color.fromARGB(180, 240, 230, 230)
                  : const Color.fromARGB(180, 40, 40, 40),
            ],
          ),
        ),
        child: Stack(
          children: [
            //
            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            // Filter & Sort
            SingleChildScrollView(
              child: Column(
                children: [
                  FilterTabHeader(tabController: _tabController),
                  ContentSizeTabBarView(
                    controller: _tabController,
                    children: [
                      //
                      // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                      // Sorts
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height,
                        padding: EdgeInsets.only(bottom: responsiveUI.own(0.1)),
                        child: const SortVnSearch(),
                      ),
                      //
                      // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                      // Filters
                      Padding(
                        padding: EdgeInsets.only(
                          top: responsiveUI.own(0.045),
                          bottom: responsiveUI.own(0.2),
                        ),
                        child: const FilterVnSearch(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //
            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            // Reset configuration
            CustomButton(
              msg: 'Reset',
              onTap: () {
                // Resetting values. But only the visible selected ones (temp), not the real
                // query to the server (applied).
                final tempsearchQuery = ref.read(tempRemoteFilterControllerProvider).search;
                ref
                    .read(tempRemoteFilterControllerProvider.notifier)
                    .importFilterData(Default.REMOTE_FILTER_CONF.copyWith(search: tempsearchQuery));
                ref
                    .read(tempRemoteSortControllerProvider.notifier)
                    .importSortData(Default.REMOTE_SORT_CONF);
              },
              margin: EdgeInsets.only(left: responsiveUI.own(0.035), top: responsiveUI.own(0.025)),
              padding: EdgeInsets.symmetric(
                horizontal: responsiveUI.own(0.015),
                vertical: responsiveUI.own(0.015),
              ),
              buttonColor: kColor(context).primary,
              child: Icon(
                Icons.refresh_outlined,
                size: responsiveUI.own(0.045),
                color: kColor(context).tertiary,
              ),
            ),
            //
            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            // Apply configuration
            Align(
              alignment: Alignment.topRight,
              child: CustomButton(
                msg: 'Apply',
                onTap: _applyFiltersToQuery,
                margin: EdgeInsets.only(
                  top: responsiveUI.own(0.018),
                  right: responsiveUI.own(0.035),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: responsiveUI.own(0.02),
                  vertical: responsiveUI.own(0.02),
                ),
                buttonColor: kColor(context).primary,
                child: Icon(
                  Icons.launch,
                  size: responsiveUI.own(0.05),
                  color: kColor(context).tertiary,
                ),
              ),
            ),

            //
            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            //
          ],
        ),
      ),
    );
  }
}
