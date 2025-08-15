import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/collection/data/collection_status_data.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/detail_non_summary/vn_record_state.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

class VnItemDetailSummaryXButton extends ConsumerWidget {
  const VnItemDetailSummaryXButton({
    super.key,
    required this.vnId,
    required this.toggleVnDetailSummary,
    required this.animationController,
  });

  final String vnId;
  final VoidCallback toggleVnDetailSummary;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {
          if (animationController.status == AnimationStatus.completed) {
            animationController.reverse();
            //
          } else if (animationController.status == AnimationStatus.dismissed) {
            animationController.forward();
          }

          // Delay for the animation take place in the UI.
          await Future.delayed(const Duration(milliseconds: 600), () {
            toggleVnDetailSummary();
          });
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: responsiveUI.own(0.06), left: responsiveUI.own(0.06)),
          child: Consumer(
            builder: (context, ref, child) {
              final vnRecord = ref.watch(vnRecordStateProvider(vnId));

              return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color:
                      (vnRecord != null)
                          ? COLLECTION_STATUS_DATA[vnRecord.status]!.color
                          : kColor(context).primary.withOpacity(0.4),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(150, 0, 0, 0),
                      offset: Offset(3, 3),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(responsiveUI.own(0.005)),
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: responsiveUI.own(0.05),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
