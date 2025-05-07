import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:vndb_lite/src/features/home/presentation/components/home_big_preview_components.dart';
import 'package:vndb_lite/src/features/home/presentation/components/section_content.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/responsive.dart';

// TODO kill home arrangement settings.

final currentHomeBigPreviewProvider = StateProvider<VnDataPhase01?>((ref) {
  return;
});

class HomeBigPreview extends ConsumerWidget {
  const HomeBigPreview({super.key});

  static final height = responsiveUI.own(0.7);
  static const double radius = 12;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p1Data = ref.watch(homeRatingPreviewsProvider);
    if (p1Data.isEmpty) return const SizedBox.shrink();

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kColor(context).primary.withAlpha(200), kColor(context).inverseSurface],
        ),
        boxShadow: const [BoxShadow(blurRadius: 1, color: Color.fromARGB(180, 0, 0, 0))],
        borderRadius: BorderRadius.circular(radius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              const HomeBigPreviewImages(),
              const Positioned(bottom: 0, right: 0, child: HomeBigPreviewDetailButton()),
              Align(
                alignment: Alignment.centerLeft,
                child: DecoratedBox(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
