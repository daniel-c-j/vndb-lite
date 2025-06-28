import 'package:flutter/material.dart';
import 'package:vndb_lite/src/common_widgets/custom_button.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/util/responsive.dart';

import '../util/context_shortcut.dart';

class CustomDialogButton extends StatelessWidget {
  const CustomDialogButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.textColor,
    this.textShadow,
    this.padding,
    this.leading,
    this.additionalWidget,
    this.forceShadow,
    this.expand = false,
  });

  final String text;
  final Color color;
  final Color? textColor;
  final List<Shadow>? textShadow;
  final Widget? leading;
  final void Function() onPressed;
  final EdgeInsetsGeometry? padding;
  final Widget? additionalWidget;
  final bool? forceShadow;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      margin: EdgeInsets.all(responsiveUI.own(0.01)),
      padding:
          padding ??
          EdgeInsets.symmetric(
            vertical: responsiveUI.own(0.025),
            horizontal: responsiveUI.own(0.04),
          ),
      borderRadius: BorderRadius.circular(16),
      buttonColor: color,
      onTap: onPressed,
      child: Row(
        mainAxisSize: (expand) ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leading ?? const SizedBox.shrink(),
          additionalWidget ??
              ShadowText(
                text,
                color: textColor,
                fontSize: responsiveUI.normalSize,
                shadows: (textColor == Colors.white || textColor == null) ? textShadow : [],
                forceShadow: textColor == kColor(context).tertiary,
              ),
        ],
      ),
    );
  }
}
