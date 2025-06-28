// ignore_for_file: non_constant_uniqueIdentifier_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:vndb_lite/src/common_widgets/generic_image_error.dart';
import 'package:vndb_lite/src/util/debouncer.dart';
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
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/custom_cache_manager.dart';

class VnItemGrid extends ConsumerStatefulWidget {
  const VnItemGrid({
    super.key,
    required this.p1,
    this.labelCode = 'title',
    this.isGridView = false,
    this.withLabel = true,
  });

  final VnDataPhase01 p1;
  final String labelCode;
  final bool isGridView;
  final bool withLabel;

  static final debouncer = Debouncer(delay: const Duration(milliseconds: 300));

  static final Map<String, double> vnSizeContainers = {};

  @override
  ConsumerState<VnItemGrid> createState() => _VnItemGridState();
}

class _VnItemGridState extends ConsumerState<VnItemGrid> {
  late final String _vnId;
  late final String? _vnCoverUrl;
  late final bool _vnHasCover;

  final nonGridViewHeight = responsiveUI.own(0.55);
  final minHeight = responsiveUI.own(0.27);
  final minWidth = responsiveUI.own(0.3);

  double _placeHolderSize = responsiveUI.own(0.35);
  bool _showVnDetailSummary = false;

  @override
  void initState() {
    super.initState();
    _vnId = widget.p1.id;
    _vnCoverUrl = widget.p1.image?.thumbnail;
    _vnHasCover = widget.p1.image != null && _vnCoverUrl != null;

    // Checks vn cover content.
    if (_vnHasCover) {
      _configVnCoverVisibility();
    }
  }

  @override
  void dispose() {
    if (_vnHasCover) _clearCache(_vnCoverUrl!);
    super.dispose();
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  void _configVnCoverVisibility() {
    // Checks whether vnData cover should be censored or not.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(vnItemGridCoverCensorStateProvider(_vnId).notifier).censor = _coverNeedCensor;
    });
  }

  bool get _coverNeedCensor {
    final settings = ref.read(settingsGeneralStateProvider);

    if (settings.showCoverCensor) {
      if (_vnMatchCensorRequirement) return true;
    }

    return false;
  }

  bool get _vnMatchCensorRequirement {
    return (widget.p1.image!.sexual ?? 0) >= 1 || (widget.p1.image!.violence ?? 0) >= 1;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  void _clearCache(String url) async {
    final imageCache = PaintingBinding.instance.imageCache;
    imageCache.clearLiveImages();
    imageCache.clear();

    await CachedNetworkImage.evictFromCache(url);
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Widget _vnCover({required bool isCensor}) {
	late final double placeholderSize;
	if (!widget.isGridView) {
		placeholderSize = _placeHolderSize;
	}else{
		placeholderSize  = VnItemGrid.vnSizeContainers[widget.p1.id] ?? _placeHolderSize;
	}
 
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: minHeight,
        // Don't let item too thin. Actually meant for preview items only, but (widget.isGridView) ?
        // somehow is not working...
        minWidth: minWidth,
      ),
      child: CachedNetworkImage(
        imageUrl: (_vnHasCover) ? (_vnCoverUrl ?? '') : '',
        fit: BoxFit.cover,
        width: (widget.isGridView) ? double.infinity : null,
        height:
            (widget.isGridView)
                ? null // dynamic, but with bare minimum of 0.27
                : nonGridViewHeight,
        errorWidget: (context, url, error) => const GenericErrorImage(),
        errorListener: null,
        placeholder: (context, str) => SizedBox(width: placeholderSize, height: placeholderSize),
        cacheManager: (!App.isInSearchScreen) ? CustomCacheManager() : null,
        cacheKey: "PREVIEW-$_vnId",
        maxHeightDiskCache: (isCensor) ? 15 : null,
        maxWidthDiskCache: (isCensor) ? 15 : null,
      ),
    );
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _enterVnDetailScreen() async {
    if (!App.isInVnDetailScreen) {
      App.currentRootRoute = App.currentRoute;
    }

    await context.pushNamed(
      AppRoute.vnDetail.name,
      pathParameters: {"vnId": _vnId, "parent": App.currentRootRoute},
      extra: widget.p1,
    );
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _vnOnTap() async {
    if (_showVnDetailSummary) return;

    final recordSelected = ref.read(recordSelectedControllerProvider);

    // Checks whether multiselection mode is off or not.
    if (recordSelected.isEmpty) {
      return await _enterVnDetailScreen();
    }

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

  Future<void> _vnOnLongPress() async {
    final recordSelected = ref.read(recordSelectedControllerProvider);

    // If already in multiselection just do nothing.
    if (recordSelected.isNotEmpty) return;

    if (widget.isGridView && !_showVnDetailSummary) {
      await showVnSelectionDialog(p1: [widget.p1], isGridView: true);

      // Turning off multiselection mode
      if (mounted && ref.read(dialogDismissedStateProvider)) {
        ref.invalidate(recordSelectedControllerProvider);
      }
    }
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  @override
  Widget build(BuildContext context) {
    final vnWidget = Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      color: kColor(context).secondary.withOpacity(0.5),
      margin: EdgeInsets.symmetric(horizontal: responsiveUI.own(0.017)),
      child: InkWell(
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        onTap: _vnOnTap,
        onLongPress: _vnOnLongPress,
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        onHighlightChanged: (value) async {
          // if (_widgetIsInvisible && widget.isGridView) return;

          // Preferably not in the homescreen
          if (!App.isInHomeScreen) {
            ref.read(vnItemGridAlmostLongPressedStateProvider.notifier).vnId = _vnId;

            await Future.delayed(const Duration(milliseconds: 600), () {
              if (mounted) ref.invalidate(vnItemGridAlmostLongPressedStateProvider);
            });
          }
        },
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        onDoubleTap: () {
          // If  in multiselection just do nothing.
          final recordSelected = ref.read(recordSelectedControllerProvider);
          if (recordSelected.isNotEmpty) return;

          // Switch cover censor
          final coverCensor = ref.read(vnItemGridCoverCensorStateProvider(_vnId));
          ref.read(vnItemGridCoverCensorStateProvider(_vnId).notifier).censor = !coverCensor;
        },
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // Vn cover image
        child: Stack(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final coverCensor = ref.watch(vnItemGridCoverCensorStateProvider(_vnId));
                return _vnCover(isCensor: coverCensor);
              },
            ),
            //
            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            // Vn informations widget
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child:
                  (_showVnDetailSummary)
                      ? VnItemGridDetailsSummary(
                        p1: widget.p1,
                        labelCode: widget.labelCode,
                        toggleVnDetailSummary:
                            () => setState(() => _showVnDetailSummary = !_showVnDetailSummary),
                      )
                      : VnItemGridDetails(
                        p1: widget.p1,
                        labelCode: widget.labelCode,
                        withLabel: widget.withLabel,
                        toggleVnDetailSummary:
                            () => setState(() => _showVnDetailSummary = !_showVnDetailSummary),
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
    if (VnItemGrid.vnSizeContainers[widget.p1.id] == null && widget.isGridView) {
      return VisibilityDetector(
        key: Key(widget.p1.id),
        onVisibilityChanged: (VisibilityInfo info) {
          if (_vnHasCover) {
            VnItemGrid.vnSizeContainers[widget.p1.id] = info.size.height;
          }
        },
        child: vnWidget,
      );
    }

    return vnWidget;
  }
}
