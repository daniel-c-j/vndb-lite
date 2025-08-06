import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/common_widgets/generic_image_error.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/multiselection/record_selected_controller.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';
import 'package:vndb_lite/src/features/vn/domain/others.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/util/custom_cache_manager.dart';
import 'package:vndb_lite/src/util/responsive.dart';

class VnItemGridCover extends StatefulWidget {
  const VnItemGridCover({
    super.key,
    required this.isGridView,
    required this.vnId,
    required this.image,
  });

  final bool isGridView;
  final String vnId;
  final VnImage? image;

  static const double placeHolderSize = 135;
  static const double minWidthSize = 100;

  static final Map<String, double> sizeContainers = {};

  static final nonGridViewHeight = responsiveUI.own(0.55);

  @override
  State<VnItemGridCover> createState() => _VnItemGridCoverState();
}

class _VnItemGridCoverState extends State<VnItemGridCover> {
  static final Map<String, bool> _coverBlur = {};

  late final String? _coverUrl;
  late final bool _hasCover;
  late final bool _coverNeedCensor;

  @override
  void initState() {
    super.initState();
    _coverUrl = widget.image?.thumbnail;
    _hasCover = widget.image != null && _coverUrl != null;

    if (_hasCover) {
      final settings = ref_.read(settingsGeneralStateProvider);
      if (settings.showCoverCensor && _vnMatchCensorRequirement) {
        _coverNeedCensor = true;
        return;
      }
    }

    _coverNeedCensor = false;
  }

  bool get _vnMatchCensorRequirement {
    return (widget.image?.sexual ?? 0) >= 1 || (widget.image?.violence ?? 0) >= 1;
  }

  @override
  Widget build(BuildContext context) {
    double placeholderSize = VnItemGridCover.placeHolderSize;
    if (widget.isGridView) {
      placeholderSize = VnItemGridCover.sizeContainers[widget.vnId] ?? placeholderSize;
    }

    final isCensor = _coverBlur[widget.vnId] ?? _coverNeedCensor;
    return GestureDetector(
      onDoubleTap: () {
        final recordSelected = ref_.read(recordSelectedControllerProvider);
        if (recordSelected.isNotEmpty) return;

        setState(() {
          _coverBlur[widget.vnId] = !isCensor;
        });
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: VnItemGridCover.placeHolderSize,
          minWidth: VnItemGridCover.minWidthSize,
        ),
        child: CachedNetworkImage(
          imageUrl: _hasCover ? (_coverUrl ?? '') : '',
          width: (widget.isGridView) ? double.infinity : null,
          height: (widget.isGridView) ? null : VnItemGridCover.nonGridViewHeight,
          placeholder: (_, _) => SizedBox.square(dimension: placeholderSize),
          fit: BoxFit.cover,
          errorWidget: (_, url, error) => const GenericErrorImage(),
          errorListener: null,
          cacheManager: (!App.isInSearchScreen) ? CustomCacheManager() : null,
          cacheKey: (isCensor) ? "CENSORED-PREVIEW-${widget.vnId}" : "PREVIEW-${widget.vnId}",
          maxHeightDiskCache: (isCensor) ? 15 : null,
          maxWidthDiskCache: (isCensor) ? 15 : null,
        ),
      ),
    );
  }
}
