import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/features/search/presentation/search_screen.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/search/presentation/search_result_controller.dart';
import 'package:vndb_lite/src/features/search/presentation/search_screen_controller.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../_base/presentation/other_parts/main_inner_layout.dart';

/// A class to display pure search result (No error, no loading).
/// The heart of this class is searchResultControllerProvider that provides this class's content.
class SearchResult extends ConsumerWidget {
  const SearchResult({super.key});

  /// Widget Key
  static const wKey = ValueKey("SearchResult");

  /// This supports search screen lazy loading when user hit the bottom screen,
  /// the result continues.
  static void detectLazyLoad() {
    if (App.isInSearchScreen) {
      final controller = ref_.read(innerSearchControllerProvider)!;
      final maxScrollExtent = controller.position.maxScrollExtent;

      // ? Avoid confusion with appbar's sliver scroll
      ref_
          .read(searchResultControllerProvider.notifier)
          .handleNextResult(controller.position.pixels, maxScrollExtent);
    }
  }

  void _forceUpdateUI() {
    SchedulerBinding.instance.addPersistentFrameCallback((_) {
      if (!App.isInSearchScreen) return;
      ref_.read(searchResultNotifierProvider.notifier).ring();
      ref_.read(searchResultNotifierProvider.notifier).end();
    });
  }

  static bool _innerControllerInitialized = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!_innerControllerInitialized) {
      _innerControllerInitialized = true;

      SchedulerBinding.instance.addPostFrameCallback((_) {
        final controller = PrimaryScrollController.of(context);
        ref.read(innerSearchControllerProvider.notifier).state = controller;
        ref.read(innerSearchControllerProvider)!.addListener(detectLazyLoad);
      });
    }

    final settings = ref.watch(settingsGeneralStateProvider);
    final outerSearchResult = ref.watch(searchScreenControllerProvider);
    final innerSearchResult = ref.watch(searchResultControllerProvider);

    // ? To forcefully update the widget
    final searchNotify = ref.watch(searchResultNotifierProvider);
    if (searchNotify && context.mounted) _forceUpdateUI();

    return ScrollableWrapper(
      withScrollBar: true,
      child: CustomScrollView(
        // physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        // controller: (App.isInSearchScreen) ? controller : null,
        // controller: controller,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(
              top: responsiveUI.own(0.04),
              left: responsiveUI.own(0.025),
              right: responsiveUI.own(0.025),
            ),
            sliver: SliverMasonryGrid(
              mainAxisSpacing: responsiveUI.own(0.03),
              crossAxisSpacing: responsiveUI.own(0.005),
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    (MediaQuery.of(context).orientation == Orientation.portrait)
                        ? settings.maxItemPerRowPortrait
                        : settings.maxItemPerRowLandscape,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, index) => innerSearchResult[index],
                childCount: innerSearchResult.length,
              ),
            ),
          ),
          if (outerSearchResult.length > 1) ...[
            for (Widget result in outerSearchResult.sublist(1, outerSearchResult.length))
              SliverToBoxAdapter(child: result),
          ],
          SliverToBoxAdapter(child: SizedBox(height: MainInnerLayout.bottomPadding)),
        ],
      ),
    );
  }
}
