import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vndb_lite/src/common_widgets/custom_button.dart';
import 'package:vndb_lite/src/common_widgets/generic_failure_connection.dart';
import 'package:vndb_lite/src/constants/app_sizes.dart';
import 'package:vndb_lite/src/core/app/navigation.dart';
import 'package:vndb_lite/src/features/random/data/random_vn_repo.dart';
import 'package:vndb_lite/src/features/random/presentation/random_preview_image.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/debouncer.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/util/text_extensions.dart';

import '../../../app.dart';
import '../../../routing/app_router.dart';

class RandomPreview extends StatelessWidget {
  const RandomPreview({super.key});

  static const widgetKey = Key("randomPreview");

  static final double height = responsiveUI.own(0.95);
  static const double radius = 12;

  Widget get _loading => const Padding(
    padding: EdgeInsets.all(8.0),
    child: Center(child: CircularProgressIndicator()),
  );
  Widget get _error =>
      const Padding(padding: EdgeInsets.all(8.0), child: Center(child: GenericFailureConnection()));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: kColor(context).primary.withAlpha(150),
          boxShadow: const [BoxShadow(blurRadius: 1, color: Color.fromARGB(180, 0, 0, 0))],
          borderRadius: BorderRadius.circular(radius),
        ),
        child: SizedBox(
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Consumer(
              builder: (context, ref, child) {
                final fetchRandomVn = ref.watch(generateRandomVnProvider);
                if (fetchRandomVn.isLoading) return _loading;

                return fetchRandomVn.when(
                  data: (VnDataPhase01 p1) => RandomPreviewImage(p1: p1),
                  loading: () => _loading,
                  error: (err, st) => _error,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class RandomPreviewButtons extends ConsumerWidget {
  RandomPreviewButtons({super.key, required this.p1});

  final VnDataPhase01 p1;
  final _debouncer = Debouncer();

  Future<void> _enterVnDetailScreen() async {
    if (!App.isInVnDetailScreen) App.currentRootRoute = App.currentRoute;

    await NavigationService.currentContext.pushNamed(
      AppRoute.vnDetail.name,
      pathParameters: {"vnId": p1.id, "parent": App.currentRootRoute},
      extra: p1,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              msg: "Get the next random visual novel",
              onTap:
                  () => _debouncer.call(() {
                    RandomVnRepo.tempP1 = null; // To force not to use the cached version of VnP1.
                    ref.invalidate(generateRandomVnProvider);
                  }),
              buttonColor: kColor(context).primary,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 32),
              borderRadius: BorderRadius.circular(8),
              elevation: 1,
              child: Row(
                children: [
                  Icon(
                    Icons.keyboard_double_arrow_right_rounded,
                    size: responsiveUI.own(0.055),
                    color: kColor(context).secondary,
                  ),
                  GAP_W4,
                  Text("Next").wSize(responsiveUI.own(0.042)).wColor(kColor(context).secondary),
                ],
              ),
            ),
          ),
          GAP_W12,
          Expanded(
            child: CustomButton(
              msg: "Check this vn's detail",
              onTap: () => _debouncer.call(() async => await _enterVnDetailScreen()),
              buttonColor: Color.alphaBlend(
                kColor(context).secondary,
                kColor(context).primary,
              ).withAlpha(180),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 32),
              borderRadius: BorderRadius.circular(8),
              elevation: 1,
              child: Row(
                children: [
                  Icon(
                    Icons.info_rounded,
                    size: responsiveUI.own(0.05),
                    color: kColor(context).surface,
                  ),
                  GAP_W4,
                  Text("Details").wSize(responsiveUI.own(0.042)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
