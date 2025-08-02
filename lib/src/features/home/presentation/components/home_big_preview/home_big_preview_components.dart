import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/common_widgets/custom_button.dart';
import 'package:vndb_lite/src/common_widgets/generic_image_error.dart';
import 'package:vndb_lite/src/core/app/navigation.dart';
import 'package:vndb_lite/src/features/home/presentation/components/home_big_preview/home_big_preview.dart';
import 'package:vndb_lite/src/features/home/presentation/components/home_big_preview/home_big_preview_state.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/routing/app_router.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/custom_cache_manager.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/util/text_extensions.dart';

class HomeBigPreviewImages extends ConsumerWidget {
  const HomeBigPreviewImages({super.key});

  static bool _initPreview = false;

  /// This exists to ensure that text does not change while just not fully swiped
  /// to different index.
  void _synchronizeVn(WidgetRef ref, VnDataPhase01 vn) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(currentHomeBigPreviewItemProvider.notifier).item = vn;
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p1Data = ref.watch(homeBigPreviewItemsProvider).toList(); // Copying
    p1Data.shuffle();

    // ! Do not set to watch, since this only synchronizes once.
    final currentVn = ref.read(currentHomeBigPreviewItemProvider);
    return Swiper(
      scrollDirection: Axis.vertical,
      itemCount: p1Data.length,
      autoplay: true,
      autoplayDelay: 10000,
      axisDirection: AxisDirection.right,
      physics: const AlwaysScrollableScrollPhysics(),
      // * This exists to persistantly sync the image with the text after
      // * visiblity reaches zero.
      index: (currentVn != null) ? p1Data.indexOf(currentVn) : null,
      onIndexChanged: (int index) => _synchronizeVn(ref, p1Data[index]),
      pagination: SwiperPagination(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(bottom: responsiveUI.own(0.085), right: responsiveUI.own(0.03)),
        builder: DotSwiperPaginationBuilder(
          color: kColor(context).primary,
          activeColor: kColor(context).secondary,
          space: 2.75,
          size: 4,
        ),
      ),
      itemBuilder: (BuildContext context, int index) {
        final vn = p1Data[index];

        // * This exists to initialize the preview text first.
        if (!_initPreview) {
          _initPreview = true;
          _synchronizeVn(ref, vn);
        }

        return CachedNetworkImage(
          imageUrl: vn.image!.url!,
          width: MediaQuery.sizeOf(context).width,
          height: HomeBigPreview.height,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => const GenericErrorImage(),
          errorListener: null,
          placeholder: (context, str) => const Center(child: CircularProgressIndicator()),
          cacheManager: CustomCacheManager(),
          cacheKey: "HOMEBIG-PREVIEW-${vn.id}",
          filterQuality: FilterQuality.low,
          maxHeightDiskCache: 500,
          maxWidthDiskCache: 500,
        );
      },
    );
  }
}

class HomeBigPreviewText extends ConsumerWidget {
  const HomeBigPreviewText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vn = ref.watch(currentHomeBigPreviewItemProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(vn?.title ?? "").wSize(responsiveUI.own(0.0425)).bold,
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 4, bottom: 12.0, left: 12, right: 12),
              child: Text(vn?.description ?? "").wSize(responsiveUI.own(0.038)),
            ),
          ),
        ],
      ),
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
        final vn = ref.read(currentHomeBigPreviewItemProvider);
        if (vn == null) return;
        await _enterVnDetailScreen(vn);
      },
      buttonColor: Color.alphaBlend(
        kColor(context).secondary.withAlpha(180),
        kColor(context).primary,
      ),
      // gradientColor: [kColor(context).secondary.withAlpha(180), kColor(context).primary],
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 32),
      elevation: 1,
      child: Text("Details").wSize(responsiveUI.own(0.038)),
    );
  }
}
