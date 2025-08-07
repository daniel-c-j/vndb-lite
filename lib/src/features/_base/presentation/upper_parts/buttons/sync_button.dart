import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/features/sort_filter/presentation/local/local_sort_filter_controller.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/_base/presentation/lower_parts/bottom_progress_indicator_state.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_content_controller.dart';
import 'package:vndb_lite/src/features/sync/application/sync_service.dart';
import 'package:vndb_lite/src/features/sync/presentation/auth_screen_controller.dart';
import 'package:vndb_lite/src/features/sync/presentation/components/sync_snackbar.dart';
import 'package:vndb_lite/src/features/sync/presentation/dialog/sync_dialog.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/detail_non_summary/vn_record_controller.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';

import '../../../../../util/context_shortcut.dart';

class AppBarSyncButton extends ConsumerWidget {
  const AppBarSyncButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return IconButton(
      tooltip: 'Sync',
      highlightColor: Colors.white.withOpacity(0.25),
      onPressed: () async {
        if (ref.read(bottomProgressIndicatorProvider)) return;

          try {
            // If already synced once, don't show dialog anymore.
            if ( ref.read(authScreenControllerProvider.notifier).isUserSynced()) {
              ref.read(bottomProgressIndicatorProvider.notifier).show = true;

              await ref
                  .read(syncServiceProvider(snackbar: snackBarSyncStatus))
                  .sync(
                    keepVns: true,
                    // Will updates collection periodically.
                    whenDownloadingAndSaving: () async {
                      final filterData = ref.read(localFilterControllerProvider);
                      final sortData = ref.read(localSortControllerProvider);
                      await ref_
                          .read(collectionContentControllerProvider.notifier)
                          .separateVNsByStatus(filterData, sortData);
                    },
                  );

              ref_.invalidate(vnRecordStateProvider);
              ref_.read(bottomProgressIndicatorProvider.notifier).show = false;
              return;
            }

            await showSyncDialog();
            return;
            //
          } catch (e) {
            // TODO catch e
            ref_.read(bottomProgressIndicatorProvider.notifier).show = false;
            // debugPrint(e);
          }
      },
      icon: Icon(Icons.sync, size: responsiveUI.standardIcon, color: kColor(context).tertiary),
    );
  }
}
