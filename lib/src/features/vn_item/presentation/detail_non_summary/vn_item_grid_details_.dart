import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/multiselection/multi_selection_indicator.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/multiselection/record_selected_controller.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/detail_non_summary/vn_item_detail_label.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/detail_non_summary/vn_item_detail_status_indicator.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/detail_non_summary/vn_item_detail_title.dart';
import '../../../../app.dart';

class VnItemGridDetails extends StatelessWidget {
  const VnItemGridDetails({
    super.key,
    required this.p1,
    required this.toggleVnDetailSummary,
    this.labelCode = 'title',
    this.withLabel = true,
  });

  final VnDataPhase01 p1;
  final String labelCode;
  final bool withLabel;
  final VoidCallback toggleVnDetailSummary;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (withLabel) VnItemDetailLabel(p1: p1, labelCode: labelCode),
            const Spacer(),
            VnItemDetailTitle(title: p1.title),
          ],
        ),
        VnItemDetailStatusIndicator(id: p1.id, toggleVnDetailSummary: toggleVnDetailSummary),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // Multi-selection mode.
        // TODO watchout with the conditional flow in here, it's borrowing other property for diff
        // purpose.
        if (withLabel)
          Consumer(
            builder: (context, ref, child) {
              if (App.isInCollectionScreen) {
                final recordSelected = ref.watch(recordSelectedControllerProvider);
                if (recordSelected.contains(p1.id)) return const MultiSelectionIndicator();
              }

              return const SizedBox.shrink();
            },
          ),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
      ],
    );
  }
}
