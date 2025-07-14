import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vndb_lite/src/common_widgets/generic_local_empty_content.dart';
import 'package:vndb_lite/src/features/_base/presentation/other_parts/main_inner_layout.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_content_controller.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';

class CollectionContent extends ConsumerWidget {
  const CollectionContent({super.key, required this.statusName});

  final String statusName;

  static final boundary = kScreenHeight();

  void _forceUpdateUI() {
    ref_.read(collectionContentNotifierProvider.notifier).end();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsGeneralStateProvider);

    final content = ref.watch(collectionContentControllerProvider)[statusName] ?? [];
    final notifyCollection = ref.watch(collectionContentNotifierProvider);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (notifyCollection) _forceUpdateUI();
    });

    return ScrollableWrapper(
      withScrollBar: true,
      child: CustomScrollView(
        // controller: controller,
        // controller: (App.isInCollectionScreen) ? controller : null,
        // shrinkWrap: false,
        // physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          (content.isEmpty)
              ? const SliverToBoxAdapter(
                child: Center(
                  child: Padding(padding: EdgeInsets.all(36), child: GenericLocalEmptyWidget()),
                ),
              )
              : SliverPadding(
                padding: EdgeInsets.only(
                  left: responsiveUI.own(0.025),
                  right: responsiveUI.own(0.025),
                  top: responsiveUI.own(0.04),
                ),
                sliver: SliverMasonryGrid(
                  mainAxisSpacing: responsiveUI.own(0.03),
                  crossAxisSpacing: responsiveUI.own(0.03),
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        (MediaQuery.of(context).orientation == Orientation.portrait)
                            ? settings.maxItemPerRowPortrait
                            : settings.maxItemPerRowLandscape,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (_, index) => content[index],
                    childCount: content.length,
                  ),
                ),
              ),
          SliverToBoxAdapter(child: SizedBox(height: MainInnerLayout.bottomPadding)),
        ],
      ),
    );
  }
}
