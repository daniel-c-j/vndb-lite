// ignore_for_file: non_constant_uniqueIdentifier_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/vn_item_grid_cover.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/dialogs/base_dialog.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/dialogs/dialog_dismissed_state.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/multiselection/record_selected_controller.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/vn_item_grid_controller.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/detail_non_summary/vn_item_grid_details_.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/detail_summary/vn_item_grid_details_summary.dart';
import 'package:vndb_lite/src/routing/app_router.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

// ignore: must_be_immutable
class VnItemGrid extends ConsumerWidget {
  // ignore: prefer_const_constructors_in_immutables
  VnItemGrid({
    super.key,
    required this.p1,
    this.labelCode = 'title',
    this.isGridView = false,
    this.withLabel = true,
  }) {
    _vnId = p1.id;
  }

  final VnDataPhase01 p1;
  final String labelCode;
  final bool isGridView;
  final bool withLabel;

  late final String _vnId;
  static final colorPlaceHolder = kColor().secondary.withAlpha(60);

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _enterVnDetailScreen(BuildContext context) async {
    if (!App.isInVnDetailScreen) {
      App.currentRootRoute = App.currentRoute;
    }

    await context.pushNamed(
      AppRoute.vnDetail.name,
      pathParameters: {"vnId": _vnId, "parent": App.currentRootRoute},
      extra: p1,
    );
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _vnOnTap(WidgetRef ref, BuildContext context) async {
    // Checks whether multiselection mode is off or not.
    final recordSelected = ref.read(recordSelectedControllerProvider);
    if (recordSelected.isEmpty) return await _enterVnDetailScreen(context);

    // In multiselection.
    if (recordSelected.contains(_vnId)) {
      recordSelected.remove(_vnId);
    } else {
      recordSelected.add(_vnId);
    }

    // In order to refresh appbar
    ref.invalidate(recordSelectedControllerProvider);

    // Turning multiselection mode off if empty
    if (recordSelected.isEmpty) return;
    ref.read(recordSelectedControllerProvider.notifier).record = recordSelected;

    return;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _vnOnLongPress(WidgetRef ref) async {
    if (!isGridView) return;

    // If already in multiselection just do nothing.
    final recordSelected = ref.read(recordSelectedControllerProvider);
    if (recordSelected.isNotEmpty) return;

    await showVnSelectionDialog(p1: [p1], isGridView: true);

    // Turning off multiselection mode
    if (ref.read(dialogDismissedStateProvider)) {
      ref.invalidate(recordSelectedControllerProvider);
    }
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  bool _showVnDetailSummary = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Hello");

    final vnWidget = Padding(
      padding: (isGridView) ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 6),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            //
            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            // Vn cover image
            VnItemGridCover(isGridView: isGridView, vnId: _vnId, image: p1.image),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: colorPlaceHolder,
                  onTap: () => _vnOnTap(ref, context),
                  onLongPress: () => _vnOnLongPress(ref),
                  onDoubleTap: null,
                ),
              ),
            ),
            //
            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            // Vn information widgets
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: StatefulBuilder(
                builder: (BuildContext context, setState) {
                  void toggleDetailSummary() {
                    setState(() => _showVnDetailSummary = !_showVnDetailSummary);
                  }

                  return (_showVnDetailSummary)
                      ? VnItemGridDetailsSummary(
                        p1: p1,
                        labelCode: labelCode,
                        toggleVnDetailSummary: toggleDetailSummary,
                      )
                      : VnItemGridDetails(
                        p1: p1,
                        labelCode: labelCode,
                        withLabel: withLabel,
                        toggleVnDetailSummary: toggleDetailSummary,
                      );
                },
              ),
            ),
            //
            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            //
          ],
        ),
      ),
    );

    // * Exists only to fetch the size for the placeholder image to prevent
    // * stuttering in a gridview.
    if (isGridView &&
        VnItemGridCover.placeHolderSize ==
            (VnItemGridCover.sizeContainers[p1.id] ?? VnItemGridCover.placeHolderSize)) {
      return VisibilityDetector(
        key: Key(p1.id),
        onVisibilityChanged: (VisibilityInfo info) {
          debugPrint(p1.title);
          VnItemGridCover.sizeContainers[p1.id] = info.size.height;
        },
        child: vnWidget,
      );
    }

    return vnWidget;
  }
}
