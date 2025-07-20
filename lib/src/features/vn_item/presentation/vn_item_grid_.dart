// ignore_for_file: non_constant_uniqueIdentifier_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:vndb_lite/src/common_widgets/generic_image_error.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/dialogs/base_dialog.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/dialogs/dialog_dismissed_state.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/multiselection/record_selected_controller.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/vn_item_grid_controller.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/detail_non_summary/vn_item_grid_details_.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/detail_summary/vn_item_grid_details_summary.dart';
import 'package:vndb_lite/src/routing/app_router.dart';
import 'package:vndb_lite/src/util/custom_cache_manager.dart';

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
    _vnCoverUrl = p1.image?.thumbnail;
    _vnHasCover = p1.image != null && _vnCoverUrl != null;
  }

  final VnDataPhase01 p1;
  final String labelCode;
  final bool isGridView;
  final bool withLabel;

  static const double placeHolderSize = 135;
  static const double minWidthSize = 100;

  // static final debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  static final Map<String, double> vnSizeContainers = {};

  static final colorPlaceHolder = kColor().secondary.withAlpha(40);
  static final nonGridViewHeight = responsiveUI.own(0.55);

  late final String _vnId;
  late final String? _vnCoverUrl;
  late final bool _vnHasCover;

  bool _showVnDetailSummary = false;

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  void _configVnCoverVisibility(WidgetRef ref) {
    // Checks whether vnData cover should be censored or not.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      bool coverNeedCensor = false;
      final settings = ref.read(settingsGeneralStateProvider);
      if (settings.showCoverCensor && _vnMatchCensorRequirement) {
        coverNeedCensor = true;
      }

      ref.read(vnItemGridCoverCensorStateProvider(_vnId).notifier).censor = coverNeedCensor;
    });
  }

  bool get _vnMatchCensorRequirement {
    return (p1.image!.sexual ?? 0) >= 1 || (p1.image!.violence ?? 0) >= 1;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Widget _vnCover({required bool isCensor}) {
    double placeholderSize = VnItemGrid.placeHolderSize;
    if (isGridView) {
      placeholderSize = VnItemGrid.vnSizeContainers[p1.id] ?? VnItemGrid.placeHolderSize;
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: VnItemGrid.placeHolderSize,
        minWidth: VnItemGrid.minWidthSize,
      ),
      child: CachedNetworkImage(
        imageUrl: (_vnHasCover) ? (_vnCoverUrl ?? '') : '',
        width: (isGridView) ? double.infinity : null,
        height: (isGridView) ? null : nonGridViewHeight,
        placeholder: (_, __) => SizedBox(width: placeholderSize, height: placeholderSize),
        fit: BoxFit.cover,
        errorWidget: (_, url, error) => const GenericErrorImage(),
        errorListener: null,
        cacheManager: (!App.isInSearchScreen) ? CustomCacheManager() : null,
        cacheKey: (isCensor) ? "CENSORED-PREVIEW-$_vnId" : "PREVIEW-$_vnId",
        maxHeightDiskCache: (isCensor) ? 15 : null,
        maxWidthDiskCache: (isCensor) ? 15 : null,
      ),
    );
  }

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
    if (_showVnDetailSummary) return;

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
    if (_showVnDetailSummary || !isGridView) return;

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

  Future<void> _onHighlightChanged(WidgetRef ref, bool value) async {
    if (_showVnDetailSummary || !isGridView) return;
    ref.read(vnItemGridAlmostLongPressedStateProvider.notifier).vnId = _vnId;

    await Future.delayed(const Duration(milliseconds: 600), () {
      // Need to use ref_ to prevent the current ref disposed.
      ref_.invalidate(vnItemGridAlmostLongPressedStateProvider);
    });
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _onDoubleTap(WidgetRef ref) async {
    if (_showVnDetailSummary) return;

    // If  in multiselection just do nothing.
    final recordSelected = ref.read(recordSelectedControllerProvider);
    if (recordSelected.isNotEmpty) return;

    // Switch cover censor
    final coverCensor = ref.read(vnItemGridCoverCensorStateProvider(_vnId));
    ref.read(vnItemGridCoverCensorStateProvider(_vnId).notifier).censor = !coverCensor;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Checks vn cover content.
    if (_vnHasCover) _configVnCoverVisibility(ref);

    final vnWidget = Padding(
      padding: (isGridView) ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        onTap: () => _vnOnTap(ref, context),
        onDoubleTap: () => _onDoubleTap(ref),
        onLongPress: () => _vnOnLongPress(ref),
        onHighlightChanged: (val) => _onHighlightChanged(ref, val),
        overlayColor: WidgetStateColor.transparent,
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              //
              // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              // Vn cover image
              Consumer(
                builder: (context, ref, child) {
                  final coverCensor = ref.watch(vnItemGridCoverCensorStateProvider(_vnId));
                  return _vnCover(isCensor: coverCensor);
                },
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
      ),
    );

    // * Exists only to fetch the size for the placeholder image to prevent
    // * stuttering in a gridview.
    if (_vnHasCover &&
        isGridView &&
        VnItemGrid.placeHolderSize ==
            (VnItemGrid.vnSizeContainers[p1.id] ?? VnItemGrid.placeHolderSize)) {
      return VisibilityDetector(
        key: Key(p1.id),
        onVisibilityChanged: (VisibilityInfo info) {
          debugPrint(p1.title);
          VnItemGrid.vnSizeContainers[p1.id] = info.size.height;
        },
        child: vnWidget,
      );
    }

    return vnWidget;
  }
}
