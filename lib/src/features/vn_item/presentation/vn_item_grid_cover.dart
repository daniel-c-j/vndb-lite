import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/common_widgets/generic_image_error.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';
import 'package:vndb_lite/src/features/vn/domain/others.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/vn_item_grid_cover_censor_notifier.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/util/custom_cache_manager.dart';
import 'package:vndb_lite/src/util/responsive.dart';

class VnItemGridCover extends StatefulWidget {
  const VnItemGridCover({
    super.key,
    required this.vnId,
    required this.image,
    required this.isGridView,
    required this.labelCode,
    this.title,
  });

  final String vnId;
  final VnImage? image;
  final bool isGridView;
  final String labelCode;

  /// Debugging purpose only.
  final String? title;

  // ! Careful when changing these values.
  static const double placeHolderSize = 140;
  static const double minHeightSize = 120;
  static const double minWidthSize = 100;

  // * This eliminates the need of notifierProvider family.
  static final Map<String, double> sizes = {};
  static final Map<String, bool> coverBlur = {};
  static final Map<String, VoidCallback> coverBlurToggle = {};

  static final nonGridViewHeight = responsiveUI.own(0.55);

  @override
  State<VnItemGridCover> createState() => _VnItemGridCoverState();
}

class _VnItemGridCoverState extends State<VnItemGridCover> {
  late final String? _coverUrl;
  late final bool _hasCover;
  late final String _blurId;

  bool _isSystematicallyCensored = false;

  @override
  void initState() {
    super.initState();
    _coverUrl = widget.image?.thumbnail;
    _hasCover = widget.image != null && _coverUrl != null;
    _blurId = widget.vnId + widget.labelCode + App.currentRoute;

    if (_hasCover) {
      final settings = ref_.read(settingsGeneralStateProvider);
      if (settings.showCoverCensor && _vnMatchCensorRequirement) {
        _isSystematicallyCensored = true;
      }
    }

    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref_
          .read(vnItemGridCoverCensorNotifierProvider(_blurId).notifier)
          .set(_isSystematicallyCensored);
    });
  }

  @override
  void dispose() {
    DefaultCacheManager().emptyCache();
    super.dispose();
  }

  bool get _vnMatchCensorRequirement {
    return (widget.image?.sexual ?? 0) >= 1 || (widget.image?.violence ?? 0) >= 1;
  }

  @override
  Widget build(BuildContext context) {
    final cover = Consumer(
      builder: (context, ref, child) {
        final isCensor =
            ref.watch(vnItemGridCoverCensorNotifierProvider(_blurId)) ?? _isSystematicallyCensored;

        // return FutureBuilder(
        //   future: CustomCacheManager().getSingleFile(widget.image!.thumbnail!),
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return CircularProgressIndicator();
        //     }
        //     return Image.file(snapshot.data, fit: BoxFit.cover);
        //   },
        // );

        return CachedNetworkImage(
          imageUrl: (_hasCover) ? (_coverUrl ?? '') : '',
          width: (widget.isGridView) ? double.infinity : null,
          height: (widget.isGridView) ? null : VnItemGridCover.nonGridViewHeight,
          placeholder:
              (_, _) => SizedBox.square(
                dimension: VnItemGridCover.sizes[widget.vnId] ?? VnItemGridCover.placeHolderSize,
              ),
          fit: BoxFit.cover,
          errorWidget: (_, url, error) => const GenericErrorImage(),
          errorListener: null,
          cacheManager: (!App.isInSearchScreen) ? CustomCacheManager() : null,
          cacheKey:
              (!App.isInSearchScreen)
                  ? (isCensor)
                      ? "CENSORED-PREVIEW-${widget.vnId}"
                      : "PREVIEW-${widget.vnId}"
                  : null,
          maxHeightDiskCache: (isCensor) ? 15 : null,
          maxWidthDiskCache: (isCensor) ? 15 : null,
        );
      },
    );

    // * Exists only to fetch the size for the placeholder image to prevent
    // * stuttering in a gridview.
    if (widget.isGridView &&
        VnItemGridCover.placeHolderSize ==
            (VnItemGridCover.sizes[widget.vnId] ?? VnItemGridCover.placeHolderSize)) {
      return VisibilityDetector(
        key: Key(widget.vnId),
        onVisibilityChanged: (VisibilityInfo info) {
          // debugPrint('${widget.title} ${VnItemGridCover.sizes[widget.vnId]}');
          VnItemGridCover.sizes[widget.vnId] = info.size.height;
        },
        child: cover,
      );
    }

    return cover;
  }
}
