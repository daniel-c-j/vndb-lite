import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:vndb_lite/src/common_widgets/generic_background.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/common_widgets/generic_snackbar.dart';
import 'package:vndb_lite/src/core/app/navigation.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_appbar_tabs.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_screen.dart';
import 'package:vndb_lite/src/features/version_check/domain/version_check.dart';
import 'package:vndb_lite/src/features/version_check/presentation/version_check_controller.dart';
import 'package:vndb_lite/src/features/version_check/presentation/version_update_dialog.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/vn_item_grid_controller.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/util/breaking_changes.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/_base/presentation/other_parts/main_inner_layout.dart';
import 'package:vndb_lite/src/features/_base/presentation/other_parts/navigation_rail_menu.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/multiselection/record_selected_controller.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_data_state.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/features/_base/presentation/lower_parts/tabs_bottom_navbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/theme_data_provider.dart';

class MainOuterLayout extends StatelessWidget {
  const MainOuterLayout({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _checkVersionUpdate() async {
    if (App.updateIsChecked) return;
    App.updateIsChecked = true; // Flagging.

    if (!ref_.read(settingsDataStateProvider).autoUpdate) return;

    final controller = ref_.read(versionCheckControllerProvider.notifier);
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
  }

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

  void _goToNextBranch(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  void _resetAlmostLongPressIndicator() {
    ref_.read(vnItemGridAlmostLongPressedStateProvider.notifier).vnId = "";
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      // * BreakingChanges feature.
      BreakingChangesCounterMeasure.show(context);

      // * Checks version at startup once everything loads.
      _checkVersionUpdate();

      // * To prevent conflict changing between screens.
      _resetAlmostLongPressIndicator();
    });

    return SafeArea(
      child: Stack(
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
          // ! Initialization must be happened inside of the widget tree.
          if (!CollectionScreen.tabInitialized)
            Builder(
              builder: (_) {
                SchedulerBinding.instance.addPostFrameCallback(
                  (_) => CollectionScreen.tabInitialized = true,
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
                if (isLandscape)
                  TabsSideNavbar(
                    onTap: _goToNextBranch,
                    selectedIndex: navigationShell.currentIndex,
                  ),
                Expanded(child: MainInnerLayout(navigationShell: navigationShell)),
              ],
            ),
            //
            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            // Exclusive portrait mode only
            bottomNavigationBar: Consumer(
              builder: (context, ref, child) {
                // Disappear when in multiselection mode.
                if (App.isInCollectionScreen) {
                  final isInMultiSelection = ref.watch(recordSelectedControllerProvider).isNotEmpty;
                  if (isInMultiSelection) return const SizedBox.shrink();
                }

                return TabsBottomNavbar(
                  onTap: _goToNextBranch,
                  onlyProgressIndicator: isLandscape,
                  selectedIndex: navigationShell.currentIndex,
                );
              },
            ),
          ),
          //
          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //
        ],
      ),
    );
  }
}
