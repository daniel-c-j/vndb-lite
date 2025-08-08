import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/collection/data/collection_status_data.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/multiselection/record_selected_controller.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/detail_non_summary/vn_record_state.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

class VnItemDetailStatusIndicator extends ConsumerWidget {
  const VnItemDetailStatusIndicator({
    super.key,
    required this.id,
    required this.toggleVnDetailSummary,
    this.forceStatus,
  });

  final String id;
  final VoidCallback toggleVnDetailSummary;
  final String? forceStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (App.isInCollectionScreen) {
      final recordSelected = ref.watch(recordSelectedControllerProvider);
      if (recordSelected.isNotEmpty) return const SizedBox.shrink();
    }

    return Positioned(
      right: -1,
      top: -1,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // Go to [VnItemDetailSummary].
          toggleVnDetailSummary();
        },
        child: Container(
          // color: Colors.red,
          // width: responsiveUI.own(0.15),
          // height: responsiveUI.own(0.15),
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: kColor(context).primary.withOpacity(0.8),
              ),
              child: Consumer(
                builder: (context, ref, child) {
                  final vnRecord = ref.watch(vnRecordStateProvider(id));

                  return Icon(
                    Icons.info_outline,
                    color:
                        (vnRecord != null)
                            ? COLLECTION_STATUS_DATA[forceStatus ?? vnRecord.status]!.color
                            : Colors.white,
                    size: responsiveUI.own(0.0575),
                    shadows: const [
                      Shadow(color: Colors.black, blurRadius: 5, offset: Offset(3, 3)),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
