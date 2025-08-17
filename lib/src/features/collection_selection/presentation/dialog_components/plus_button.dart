import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/multiselection/record_selected_controller.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/collection_selection_controller.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/dialogs/dialog_dismissed_state.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

class VnSelectionDialogPlusButton extends ConsumerWidget {
  const VnSelectionDialogPlusButton({super.key, required this.data});

  final List<VnDataPhase01> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(vnSelectionControllerProvider.notifier);

    return Padding(
      padding: EdgeInsets.only(top: responsiveUI.own(0.01)),
      child: InkWell(
        borderRadius: BorderRadius.circular(36),
        onTap: () {
          // Triggering Multi-selection mode
          final recordSelected = ref.read(recordSelectedControllerProvider);
          selection.setToMultiselection(recordSelected, data);

          SchedulerBinding.instance.addPostFrameCallback((_) {
            ref_.invalidate(recordSelectedControllerProvider);
            ref_.read(recordSelectedControllerProvider.notifier).record = recordSelected;
          });

          // Dialog is not dimissed (cancelled).
          ref.read(dialogDismissedStateProvider.notifier).dismissed = false;
          Navigator.of(context).pop();
        },
        child: Opacity(
          opacity: 0.7,
          child: Container(
            padding: EdgeInsets.all(responsiveUI.own(0.018)),
            decoration: BoxDecoration(
              color: kColor(context).primary,
              borderRadius: BorderRadius.circular(36),
              boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 3)],
            ),
            child: Icon(Icons.add, size: responsiveUI.own(0.06), color: kColor(context).tertiary),
          ),
        ),
      ),
    );
  }
}
