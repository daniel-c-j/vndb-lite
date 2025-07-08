import 'package:flutter/material.dart';
import 'package:vndb_lite/src/common_widgets/custom_label.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/sort_filter/data/platform_data.dart';
import 'package:vndb_lite/src/features/vn/domain/p2.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

class VnDetailReleasesPlatform extends StatelessWidget {
  const VnDetailReleasesPlatform({super.key, required this.p2});

  final VnDataPhase02 p2;

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Widget get _platformWidgets {
    final List<Widget> platforms = [];
    bool hasOthers = false;

    for (String platformCode in (p2.platforms ?? [])) {
      final String platformName = PlatfData.DEFINED_CODES[platformCode] ?? 'oth';
      final String imagePath = "assets/images/os/$platformCode.png";

      if (platformName.contains('oth')) {
        hasOthers = true;
        continue;
      }

      platforms.add(
        Container(
          margin: EdgeInsets.only(right: responsiveUI.own(0.025), bottom: responsiveUI.own(0.025)),
          child: CustomLabel(
            useBorder: false,
            padding: EdgeInsets.only(
              right: responsiveUI.own(0.035),
              left: responsiveUI.own(0.025),
              bottom: responsiveUI.own(0.01),
              top: responsiveUI.own(0.01),
            ),
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: responsiveUI.own(0.015),
                  bottom: responsiveUI.own(0.005),
                  top: responsiveUI.own(0.005),
                ),
                child: Image.asset(
                  imagePath,
                  color: (PlatfData.isIconPlain(platformCode)) ? kColor().tertiary : null,
                  height: responsiveUI.own(0.05),
                  width: responsiveUI.own(0.05),
                ),
              ),
              ShadowText(platformName),
            ],
          ),
        ),
      );
    }

    return _getFinalPlatformWidget(platforms, hasOthers);
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Widget _getFinalPlatformWidget(List<Widget> platforms, bool hasOthers) {
    if (platforms.isEmpty) {
      platforms.add(ShadowText('--'));
    }

    if (hasOthers) {
      // Adds at the end of the list.
      platforms.add(
        Container(
          margin: EdgeInsets.only(right: responsiveUI.own(0.025), bottom: responsiveUI.own(0.025)),
          child: CustomLabel(useBorder: false, children: [ShadowText('Others...')]),
        ),
      );
    }

    return Wrap(children: platforms);
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadowText('Platforms', fontSize: responsiveUI.own(0.045), fontWeight: FontWeight.bold),
        SizedBox(height: responsiveUI.own(0.01)),
        _platformWidgets,
      ],
    );
  }
}
