import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

import '../core/_core.dart';

class ShadowText extends ConsumerWidget {
  const ShadowText(
    this.text, {
    super.key,
    this.fontSize,
    this.color,
    this.align,
    this.fontWeight,
    this.shadows,
    this.forceShadow = false,
  });

  final String text;
  final double? fontSize;
  final Color? color;
  final TextAlign? align;
  final FontWeight? fontWeight;
  final List<Shadow>? shadows;
  final bool forceShadow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = kColor(context);

    return Text(
      text,
      softWrap: true,
      overflow: TextOverflow.fade,
      textAlign: align,
      style: styleText(
        color: color ?? themeColor.tertiary,
        fontSize: fontSize ?? responsiveUI.normalSize,
        fontWeight: fontWeight ?? FontWeight.normal,
        shadows: shadows,
        forceShadow: forceShadow,
      ),
    );
  }
}

TextStyle styleText({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  List<Shadow>? shadows,
  bool forceShadow = false,
}) {
  final themeColor = kColor(NavigationService.currentContext);
  List<Shadow>? textShadows = shadows ?? const [Shadow(color: Colors.black, blurRadius: 5)];

  if (themeColor.tertiary != Colors.white && !forceShadow) {
    if (color != Colors.white) textShadows = null;
  }

  return TextStyle(
    color: color ?? themeColor.tertiary,
    fontSize: fontSize ?? responsiveUI.normalSize,
    fontWeight: fontWeight ?? FontWeight.normal,
    overflow: TextOverflow.fade,
    shadows: textShadows,
  );
}
