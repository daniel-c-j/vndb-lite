import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:vndb_lite/src/common_widgets/generic_background.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/common_widgets/generic_snackbar.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_appbar_tabs.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/util/debouncer.dart';
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
import 'package:vndb_lite/src/util/scroll_to_hide.dart';
import 'package:vndb_lite/src/util/version_check/version_checker.dart';

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

  static const _scrollAnimDuration = Duration(milliseconds: 250);
  // Slightly optimizing performance.
  static final _debounce = Debouncer(delay: const Duration(milliseconds: 50));

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

  /// This method exists since there are another [ScrollController] inside of [NestedScrollView]
  /// and since [NestedScrollView] animation behaviour went odd because of another controller's
  /// existence, and the animation still crucial, this synthetic method exists to fulfill
  ///  [NestedScrollView]'s sliver behaviour.
  ///
  /// Also to control [BottomNavBar] visibility.
  void _forceAnimateScroll() {
    if (innerScrollController.position.userScrollDirection == ScrollDirection.idle) return;
    final bottomNavBarShown = ref_.read(showBottomNavBarProvider);

    if (innerScrollController.position.userScrollDirection == ScrollDirection.forward) {
      // Only applies in search&collection screen.
      if (App.isInSearchScreen || App.isInCollectionScreen) {
        _debounce.call(() {
          if (mainScrollController.position.pixels == 0) return;
          mainScrollController.animateTo(0, duration: _scrollAnimDuration, curve: Curves.ease);
        });
      }

      if (!bottomNavBarShown) ref_.read(showBottomNavBarProvider.notifier).state = true;
      return;
    }

    // If scrolling in reverse, then:
    if (bottomNavBarShown) ref_.read(showBottomNavBarProvider.notifier).state = false;
    if (App.isInSearchScreen || App.isInCollectionScreen) {
      _debounce.call(() {
        if (mainScrollController.position.pixels > 10) return;
        mainScrollController.animateTo(
          TabAppBar.height,
          duration: _scrollAnimDuration,
          curve: Curves.ease,
        );
      });
    }
  }

  bool _handleScrollNotification(ScrollNotification notif) {
    // debugPrint('Current pixel : ${notification.metrics.pixels}'); // Or
    // debugPrint('Current pixel : ${innerScrollController.position.pixels}');
    // debugPrint('Max scroll in pixel : ${notification.metrics.maxScrollExtent}');
    _forceAnimateScroll();

    // * This supports search screen lazy loading when user hit the bottom screen,
    // * the result continues.
    if (App.isInSearchScreen) {
      // * Do nothing if the ScrollNotification is currently talking about the NestedScrollview's
      // * scrollExtent.
      if (notif.metrics.maxScrollExtent < TabAppBar.height) return false;

      scrollOffsetInSearch = innerScrollController.position.pixels;
      ref_.read(searchResultControllerProvider.notifier).handleNextResult(notif);
      return false;
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

  void _maintainSearchScrollOffset() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!App.isInSearchScreen) return;
      innerScrollController.jumpTo(scrollOffsetInSearch);
    });
  }

  void _showBottomNavBarWhenScreenChanges() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref_.read(showBottomNavBarProvider.notifier).state = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    // * Checks version at startup after everything loads.
    if (!_updateIsChecked) _checkUpdate();

    // * Maintain search scroll offset.
    if (App.isInSearchScreen) _maintainSearchScrollOffset();

    // * In certain scenarios bottom nav bar likes to hide when changing screen,
    // * so this method exists to prevent that behaviour.
    _showBottomNavBarWhenScreenChanges();

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
                child: NotificationListener(
                  onNotification: _handleScrollNotification,
                  child: NestedScrollView(
                    floatHeaderSlivers: true,
                    controller: mainScrollController,
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    // ! Do not set to constant.
                    headerSliverBuilder: (_, _) => <Widget>[TabAppBar()],
                    body: MainScaffoldBody(navigationShell: navigationShell),
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
                scrollController: innerScrollController,
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
