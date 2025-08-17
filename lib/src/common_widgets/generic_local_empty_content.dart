import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:flutter/material.dart';

class GenericLocalEmptyWidget extends StatelessWidget {
  const GenericLocalEmptyWidget({super.key, this.customMessage, this.align});

  final String? customMessage;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) {
    final alignment = align ?? TextAlign.center;

    final text = ShadowText(
      customMessage ?? "Oops, nothing's here yet! \nTry adding something... :)",
      fontSize: responsiveUI.normalSize,
      align: alignment,
      color: kColor(context).surface.withAlpha(230),
    );

    return (alignment == TextAlign.center) ? Center(child: text) : text;
  }
}
