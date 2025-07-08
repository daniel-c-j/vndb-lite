import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/features/vn/domain/p2.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/format_minutes.dart';

class VnDetailsBottomHeader extends ConsumerWidget {
  const VnDetailsBottomHeader({super.key, required this.p1, required this.p2});

  final VnDataPhase01 p1;
  final VnDataPhase02 p2;

  Widget get _separator {
    return Container(
      width: 2,
      height: responsiveUI.own(0.1),
      alignment: Alignment.center,
      color: kColor().tertiary.withOpacity(0.8),
    );
  }

  // Rating value : Number of stars
  static const Map<int, int> _ratingStar = {9: 5, 7: 4, 5: 3, 3: 2, 1: 1};

  Widget _getRatingIcons(double thisVnRating) {
    if (thisVnRating == 0) {
      return Icon(Icons.star_outline, size: responsiveUI.own(0.05), color: kColor().secondary);
    }

    final Widget starIcon = Icon(
      Icons.star,
      size: responsiveUI.own(0.05),
      color: kColor().secondary,
      shadows: [_shadow],
    );

    for (int ratingValue in _ratingStar.keys) {
      if (thisVnRating >= ratingValue) {
        return Wrap(children: [for (int i = 0; i < _ratingStar[ratingValue]!; i++) starIcon]);
      }
    }

    return const SizedBox.shrink();
  }

  Shadow get _shadow {
    // Reversing the color.
    // final base = (kColor(context).tertiary == Colors.white) ? Colors.black : Colors.white;

    return Shadow(
      color: Color.alphaBlend(
        kColor().tertiary.withOpacity(0.8),
        kColor().primary,
      ).withOpacity(0.4),
      blurRadius: 10,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //
          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          // Vote
          Flexible(
            child: Column(
              children: [
                ShadowText('Vote'),
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(
                      Icons.electric_bolt_sharp,
                      size: responsiveUI.own(0.045),
                      color: kColor(context).secondary,
                      shadows: [_shadow],
                    ),
                    Text(
                      " ${p1.votecount}",
                      style: TextStyle(
                        fontSize: responsiveUI.catgTitle,
                        color: kColor(context).secondary,
                        shadows: [_shadow],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _separator,

          //
          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          // Rating
          Flexible(
            child: Column(
              children: [
                ShadowText('Rating'),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    _getRatingIcons(p1.rating!),
                    Padding(
                      padding: EdgeInsets.only(
                        top: responsiveUI.own(0.001),
                        left: responsiveUI.own(0.005),
                      ),
                      child: Text(
                        "(${(p1.rating! / 10).toStringAsFixed(2)})",
                        style: TextStyle(
                          fontSize: responsiveUI.own(0.035),
                          color: kColor(context).secondary,
                          shadows: [_shadow],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _separator,

          //
          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          // Length
          Flexible(
            child: Column(
              children: [
                ShadowText('Play Time'),
                Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: responsiveUI.own(0.007)),
                      child: Icon(
                        Icons.timelapse,
                        size: responsiveUI.own(0.04),
                        color: kColor(context).secondary,
                        shadows: [_shadow],
                      ),
                    ),
                    Text(
                      ' ${getVnLength(p2.length_minutes)}',
                      style: TextStyle(
                        fontSize: responsiveUI.own(0.038),
                        color: kColor(context).secondary,
                        shadows: [_shadow],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //
          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //
        ],
      ),
    );
  }
}
