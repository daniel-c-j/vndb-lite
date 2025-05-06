import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vndb_lite/src/common_widgets/generic_image_error.dart';
import 'package:vndb_lite/src/features/home/presentation/components/section_content.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/custom_cache_manager.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/util/text_extensions.dart';

final random = Random();

class HomeBigPreview extends ConsumerStatefulWidget {
  const HomeBigPreview({super.key});

  @override
  ConsumerState<HomeBigPreview> createState() => _HomeBigPreviewState();
}

class _HomeBigPreviewState extends ConsumerState<HomeBigPreview> {
  static final height = responsiveUI.own(0.8);

  late final Timer _vnUpdateTimer;

  @override
  void initState() {
    super.initState();
    _vnUpdateTimer = Timer.periodic(const Duration(seconds: 16), (_) {
      final val = ref.read(homeRatingPreviewsProvider).reversed.toList();
      ref.read(homeRatingPreviewsProvider.notifier).state = val;
    });
  }

  @override
  void dispose() {
    _vnUpdateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p1Data = ref.watch(homeRatingPreviewsProvider);
    if (p1Data.isEmpty) return SizedBox(height: height);

    final randomVn = p1Data[random.nextInt(p1Data.length)];

    return ClipRect(
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: randomVn.image!.url!,
              width: MediaQuery.sizeOf(context).width,
              height: height,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const GenericErrorImage(),
              errorListener: null,
              placeholder: (context, str) => Center(child: CircularProgressIndicator()),
              cacheManager: CustomCacheManager(),
              cacheKey: "PREVIEW-${randomVn.id}",
              filterQuality: FilterQuality.low,
              maxHeightDiskCache: 500,
              maxWidthDiskCache: 500,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 10,
                    blurRadius: 15,
                    color: kColor(context).primary.withAlpha(150),
                  ),
                ],
              ),
              child: SizedBox(
                width: responsiveUI.own(0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
                      child: Text(randomVn.title).sizeOf(responsiveUI.own(0.045)).bold,
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 4, bottom: 12.0, left: 12, right: 12),
                        child: Text(randomVn.description ?? '--').sizeOf(responsiveUI.own(0.04)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
