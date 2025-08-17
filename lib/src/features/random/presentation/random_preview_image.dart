import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:vndb_lite/src/common_widgets/generic_image_error.dart';
import 'package:vndb_lite/src/features/random/presentation/random_preview.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/detail_non_summary/vn_item_detail_title.dart';

class RandomPreviewImage extends ConsumerWidget {
  const RandomPreviewImage({super.key, required this.p1});

  final VnDataPhase01 p1;

  bool isCensor(WidgetRef ref) {
    final settings = ref.read(settingsGeneralStateProvider);
    if (settings.showCoverCensor && (p1.image?.sexual ?? 0) >= 1 ||
        (p1.image?.violence ?? 0) >= 1) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl: p1.image?.thumbnail ?? "",
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            alignment: const Alignment(0, -0.45),
            errorListener: null,
            errorWidget: (_, _, error) {
              debugPrint(error.toString());
              return const GenericErrorImage();
            },
            placeholder: (_, _) => const Center(child: CircularProgressIndicator()),
            maxHeightDiskCache: (isCensor(ref)) ? 15 : null,
            maxWidthDiskCache: (isCensor(ref)) ? 15 : null,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: VnItemDetailTitlePlus(
            title: p1.title,
            desc: p1.description ?? "No description",
            additionalWidget: RandomPreviewButtons(p1: p1),
          ),
        ),
      ],
    );
  }
}
