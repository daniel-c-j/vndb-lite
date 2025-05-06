import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/common_widgets/custom_button.dart';
import 'package:vndb_lite/src/common_widgets/generic_image_error.dart';
import 'package:vndb_lite/src/constants/app_sizes.dart';
import 'package:vndb_lite/src/core/_core.dart';
import 'package:vndb_lite/src/features/home/presentation/components/section_content.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/routing/app_router.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/custom_cache_manager.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/util/text_extensions.dart';

final currentHomeBigPreviewProvider = StateProvider<VnDataPhase01?>((ref) {
  return;
});

class HomeBigPreview extends ConsumerWidget {
  const HomeBigPreview({super.key});

  static final height = responsiveUI.own(0.8);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p1Data = ref.watch(homeRatingPreviewsProvider);
    if (p1Data.isEmpty) return SizedBox(height: height);

    return ClipRect(
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            Swiper(
              scrollDirection: Axis.horizontal,
              itemCount: p1Data.length,
              autoplay: true,
              autoplayDelay: 10000,
              axisDirection: AxisDirection.right,
              itemBuilder: (BuildContext context, int index) {
                final vn = p1Data[index];

                SchedulerBinding.instance.addPostFrameCallback((_) {
                  ref.read(currentHomeBigPreviewProvider.notifier).state = vn;
                });

                return CachedNetworkImage(
                  imageUrl: vn.image!.url!,
                  width: MediaQuery.sizeOf(context).width,
                  height: height,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const GenericErrorImage(),
                  errorListener: null,
                  placeholder: (context, str) => Center(child: CircularProgressIndicator()),
                  cacheManager: CustomCacheManager(),
                  cacheKey: "PREVIEW-${vn.id}",
                  filterQuality: FilterQuality.low,
                  maxHeightDiskCache: 500,
                  maxWidthDiskCache: 500,
                );
              },
            ),

            const Positioned(bottom: 0, right: 0, child: HomeBigPreviewDetailButton()),
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
              child: SizedBox(width: responsiveUI.own(0.5), child: const HomeBigPreviewText()),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeBigPreviewText extends ConsumerWidget {
  const HomeBigPreviewText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vn = ref.watch(currentHomeBigPreviewProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
          child: Text(vn?.title ?? "").sizeOf(responsiveUI.own(0.045)).bold,
        ),
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 4, bottom: 12.0, left: 12, right: 12),
            child: Text(vn?.description ?? "").sizeOf(responsiveUI.own(0.04)),
          ),
        ),
      ],
    );
  }
}

class HomeBigPreviewDetailButton extends ConsumerWidget {
  const HomeBigPreviewDetailButton({super.key});

  Future<void> _enterVnDetailScreen(VnDataPhase01 p1) async {
    if (!App.isInVnDetailScreen) {
      App.currentRootRoute = App.currentRoute;
    }

    await NavigationService.currentContext.pushNamed(
      AppRoute.vnDetail.name,
      pathParameters: {"vnId": p1.id, "parent": App.currentRootRoute},
      extra: p1,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
      onTap: () async {
        final vn = ref.read(currentHomeBigPreviewProvider);
        if (vn == null) return;
        await _enterVnDetailScreen(vn);
      },
      gradientColor: [kColor(context).secondary.withAlpha(180), kColor(context).primary],
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 28),
      elevation: 2,
      child: Row(
        children: [
          Icon(
            Icons.arrow_forward_ios,
            color: kColor(context).tertiary,
            size: responsiveUI.normalSize,
          ),
          GAP_W8,
          Text("Check").sizeOf(responsiveUI.own(0.038)),
        ],
      ),
    );
  }
}
