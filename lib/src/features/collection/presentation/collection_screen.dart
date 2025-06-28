import 'package:flutter/scheduler.dart';
import 'package:vndb_lite/src/features/_base/presentation/upper_parts/tabs_sliver_appbar.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_appbar_tabs.dart';
import 'package:vndb_lite/src/routing/app_router.dart';
import 'package:vndb_lite/src/features/_base/presentation/lower_parts/bottom_progress_indicator_state.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_content.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_content_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({super.key});

  static bool tabInitialized = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // ? If there is not any ongoing process, then proceeds. Do not ref.watch()

      if (!ref.read(bottomProgressIndicatorProvider)) {
        ref.read(collectionContentControllerProvider.notifier).separateVNsByStatus();
      }
    });

    final settings = ref.watch(settingsGeneralStateProvider);
    final statusArrangement = settings.collectionStatusTabArrangement;

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (_, __) => const [TabAppBar(route: AppRoute.collection)],
      body: TabBarView(
        controller: CollectionAppBarTabs.controller,
        children: [
          for (String statusName in statusArrangement)
            CollectionContent(key: Key(statusName), statusName: statusName),
        ],
      ),
    );
  }
}
