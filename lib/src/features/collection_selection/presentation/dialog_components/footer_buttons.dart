import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/common_widgets/custom_dialog_button.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/common_widgets/generic_snackbar.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_content_controller.dart';
import 'package:vndb_lite/src/features/collection_selection/application/collection_selection_service.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/dialogs/dialog_dismissed_state.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/multiselection/record_selected_controller.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/collection_selection_controller.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/dialog_components/footer_button_state.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/dialogs/remove_dialog.dart';
import 'package:vndb_lite/src/features/home/application/home_preview_service.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/detail_non_summary/vn_record_controller.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/common_widgets/custom_button.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

class VnSelectionDialogFooter extends ConsumerWidget {
  const VnSelectionDialogFooter({super.key, required this.data});

  final List<VnDataPhase01> data;

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  void _showSnackbar({Color? color, required String text, required IconData icon}) {
    GenericSnackBar(
      content: [
        Icon(icon, size: responsiveUI.snackbarIcon, color: color ?? kColor().tertiary),
        SizedBox(width: responsiveUI.own(0.015)),
        Flexible(child: ShadowText(text, fontSize: responsiveUI.snackbarTxt)),
      ],
      duration: const Duration(seconds: 4),
    ).show();
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _notifyCollectionPreview() async {
    ref_.invalidate(homePreviewServiceProvider);

    // Need to invalidate twice and a delay somehow...
    ref_.invalidate(homePreviewServiceProvider);

    // Prevent changing collection refreshing the items which made the items disappear and force user to
    // go up from where the user scroll.
    if (!App.isInCollectionScreen) {
      await ref_.read(collectionContentControllerProvider.notifier).separateVNsByStatus();
    }
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.read(vnSelectionControllerProvider.notifier);

    // Watch states, to update UI.
    final selectionState = ref.watch(vnSelectionControllerProvider);
    final buttonState = ref.watch(vnButtonStateProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // Cancel button
        CustomDialogButton(
          text: 'Cancel',
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(
            vertical: responsiveUI.own(0.025),
            horizontal: responsiveUI.own(0.035),
          ),
          onPressed: () async {
            // Turning off multiselection mode
            ref.invalidate(recordSelectedControllerProvider);

            // Dialog is not dimissed (cancelled).
            ref.read(dialogDismissedStateProvider.notifier).dismissed = false;

            Navigator.of(context).pop();
          },
        ),

        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // Remove button
        if (!selection.isVnNew && buttonState == ButtonState.active)
          CustomDialogButton(
            text: 'Remove',
            padding: EdgeInsets.symmetric(
              vertical: responsiveUI.own(0.025),
              horizontal: responsiveUI.own(0.035),
            ),
            color: const Color.fromARGB(180, 255, 20, 0),
            onPressed: () async {
              if (buttonState == ButtonState.loading) return;

              await confirmVnRemovalDialog(() async {
                await selection.remove(
                  whenSuccess: () async {
                    // Turning off multiselection mode
                    ref.invalidate(recordSelectedControllerProvider);

                    // Dialog is not dimissed (cancelled).
                    ref.read(dialogDismissedStateProvider.notifier).dismissed = false;

                    // Notify collection preview
                    await _notifyCollectionPreview();

                    // Closing dialogs
                    Navigator.of(context).pop(); // Pop removal confirmation
                    Navigator.of(context).pop(); // Pop selection dialog

                    _showSnackbar(
                      color: Colors.red,
                      text: 'Record removed.',
                      icon: Icons.delete_forever,
                    );
                  },
                  removeRefresh: (String id) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      ref.invalidate(vnRecordControllerProvider(id));
                      ref.read(vnRecordControllerProvider(id).notifier).importRecord(null);
                    });
                  },
                );
              });
            },
          ),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // Confirm button
        Opacity(
          opacity: (buttonState == ButtonState.active) ? 1 : 0.6,
          child: CustomDialogButton(
            text: 'Confirm',
            color: kColor(context).tertiary,
            textColor: kColor(context).primary,
            textShadow: const [Shadow(color: Color.fromARGB(120, 0, 0, 0), blurRadius: 1)],
            onPressed: () async {
              if (buttonState == ButtonState.loading) return;

              final changeButton = ref.read(vnButtonStateProvider.notifier);
              changeButton.state = ButtonState.loading;

              // Ugly... yet working.
              // TODO rearrange this, make it more elegant?

              // Used only once in a function, and this is an autodispose provider, so lint could be
              // ignored.
              ref.read(
                confirmSelectionProvider(
                  p1List: data,
                  selection: selectionState,
                  vnRecords: selection.vnRecords,
                  // ignore: provider_parameters
                  saveRefresh: (String id) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Future.delayed(const Duration(milliseconds: 800));
                      ref.invalidate(vnRecordControllerProvider(id));
                    });
                  },
                  // ignore: provider_parameters
                  whenSuccess: () async {
                    changeButton.state = ButtonState.active;

                    // Turning off multiselection mode
                    ref.invalidate(recordSelectedControllerProvider);

                    // Dialog is not dimissed (cancelled).
                    ref.read(dialogDismissedStateProvider.notifier).dismissed = false;

                    // Notify collection preview.
                    await _notifyCollectionPreview();

                    // Closing the dialog.
                    Navigator.of(context).pop();

                    if (selection.isMultiselection || !selection.isVnNew) {
                      return _showSnackbar(text: 'Updated.', icon: Icons.update);
                    }

                    _showSnackbar(text: 'Added to library.', icon: Icons.library_add_check);
                  },
                  // ignore: provider_parameters
                  whenErr: (err, st) {
                    // debugPrint(err);
                    // debugPrint(st);
                    //TODO better error handl message
                    changeButton.state = ButtonState.active;
                    _showSnackbar(
                      color: Colors.red,
                      text: 'An error occurred... Please try again later.',
                      icon: Icons.error_outline,
                    );
                  },
                ),
              );
            },
            additionalWidget:
                (buttonState == ButtonState.loading)
                    ? SizedBox(
                      width: responsiveUI.own(0.05),
                      height: responsiveUI.own(0.05),
                      child: const Center(child: CircularProgressIndicator()),
                    )
                    : null,
          ),
        ),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
      ],
    );
  }
}
