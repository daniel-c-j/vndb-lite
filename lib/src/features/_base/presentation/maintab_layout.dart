import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:vndb_lite/src/common_widgets/generic_background.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/common_widgets/generic_snackbar.dart';
import 'package:vndb_lite/src/core/app/navigation.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_appbar_tabs.dart';
import 'package:vndb_lite/src/features/version_check/domain/version_check.dart';
import 'package:vndb_lite/src/features/version_check/presentation/version_check_controller.dart';
import 'package:vndb_lite/src/features/version_check/presentation/version_update_dialog.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/util/breaking_changes.dart';
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

import '../../theme/theme_data_provider.dart';

// * Intentionally made global to be easily accessing the value throughout the entire
// * widget tree for specific and crucial use cases.
final textControllerCollection = TextEditingController();
final textControllerSearch = TextEditingController();
final focusNodeSearch = FocusNode();
final mainScrollController = ScrollController();

// * Once-check flags
bool _updateIsChecked = false;
bool _collectionTabInitialized = false;

// * To maintain consistency in screen that has lots of items.
double scrollOffsetInSearch = 0;

class MainTabLayout extends StatelessWidget {
  const MainTabLayout({super.key, required this.navigationShell});

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

  bool _handleScrollNotification(ScrollNotification notif) {
    // debugPrint('Current pixel : ${notif.metrics.pixels}'); // Or
    // debugPrint('Current pixel : ${innerScrollController.position.pixels}');
    // debugPrint('Max scroll in pixel : ${notif.metrics.maxScrollExtent}');

    // * This supports search screen lazy loading when user hit the bottom screen,
    // * the result continues.
    if (App.isInSearchScreen) {
      // * Do nothing if the ScrollNotification is currently talking about the NestedScrollview's
      // * scrollExtent.
      if (notif.metrics.maxScrollExtent < TabAppBar.height) return false;

      scrollOffsetInSearch = ref_.read(innerScrollControllerProvider)!.position.pixels;
      ref_.read(searchResultControllerProvider.notifier).handleNextResult(notif);
      return false;
    }

    return false;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _checkVersionUpdate() async {
    if (!ref_.read(settingsDataStateProvider).autoUpdate) return;
    _updateIsChecked = true; // Flagging.

    final controller = ref_.read(versionCheckControllerProvider.notifier);
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await controller.checkData(
        onSuccess: (VersionCheck ver) async {
          if (!ver.canUpdate) {
            _showVersionCheckSnackbar(success: true);
            return;
          }

          return await VersionUpdateDialog.show(NavigationService.currentContext, ver);
        },
        onError: (e, st) async {
          _showVersionCheckSnackbar(success: false);
        },
      );
    });
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  void _maintainSearchScrollOffset(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Ignore if keyboard opens.
      if (!App.isInSearchScreen || MediaQuery.of(context).viewInsets.bottom > 0) return;
      ref_.read(innerScrollControllerProvider)?.jumpTo(scrollOffsetInSearch);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    // * BreakingChanges feature.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      BreakingChangesCounterMeasure.show(context);
    });

    // * Checks version at startup after everything loads.
    if (!_updateIsChecked) _checkVersionUpdate();

    // * Maintain search scroll offset.
    if (App.isInSearchScreen) _maintainSearchScrollOffset(context);

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
          backgroundColor: Colors.black.withOpacity(0.3),
          body: Row(
            children: [
              // * Exclusive landscape mode only
              if (isLandscape)
                TabsSideNavbar(selectedIndex: navigationShell.currentIndex, onTap: _goToBranch),
              Expanded(
                child: NotificationListener(
                  onNotification: _handleScrollNotification,
                  child: NestedScrollView(
                    floatHeaderSlivers: true,
                    controller: mainScrollController,
                    // ! Do not set to constant.
                    headerSliverBuilder: (ctx, _) => [TabAppBar()],
                    body: Builder(
                      builder: (context) {
                        // ! Crucial, if not exists, screen will not be able to remember their latest
                        // ! position in pixel.
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          final controller = PrimaryScrollController.of(context);
                          ref_.read(innerScrollControllerProvider.notifier).state = controller;
                        });

                        return MainScaffoldBody(navigationShell: navigationShell);
                      },
                    ),
                  ),
                ),
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
