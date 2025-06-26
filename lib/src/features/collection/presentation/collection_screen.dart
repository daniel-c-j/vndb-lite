import 'package:flutter/scheduler.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_appbar_tabs.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/_base/presentation/lower_parts/bottom_progress_indicator_state.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_content.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_content_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contentsize_tabbarview/contentsize_tabbarview.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({super.key});

  static bool tabInitialized = false;

  void _forceUpdateUI() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref_.read(collectionContentNotifierProvider.notifier).end();
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsGeneralStateProvider);
    final statusArrangement = settings.collectionStatusTabArrangement;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      // If there is not any ongoing process, then proceeds.
      // ! Do not ref.watch()
      if (!ref.read(bottomProgressIndicatorProvider)) {
        ref.read(collectionContentControllerProvider.notifier).separateVNsByStatus();
      }
    });

    return Padding(
      padding: EdgeInsets.only(top: responsiveUI.own(0.04)),
      child: ContentSizeTabBarView(
        controller: CollectionAppbarTabs.controller,
        children: [
          for (String statusName in statusArrangement)
            Consumer(
              builder: (context, ref, child) {
                final vnItemGrids = ref.watch(collectionContentControllerProvider);
                final notifyCollection = ref.watch(collectionContentNotifierProvider);

                if (notifyCollection) _forceUpdateUI();
                return CollectionContent(
                  key: ValueKey(statusName),
                  content: vnItemGrids[statusName] ?? const [],
                );
              },
            ),
        ],
      ),
    );
  }
}
