import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:vndb_lite/src/common_widgets/custom_button.dart';
import 'package:vndb_lite/src/util/responsive.dart';

import '../util/context_shortcut.dart';

class CustomLabel extends ConsumerWidget {
  const CustomLabel({
    super.key,
    this.onTap,
    required this.useBorder,
    required this.children,
    this.padding,
    this.borderColor,
    this.highlightColor,
    this.borderRadius = 8,
    this.bgColor,
    this.shadowColor,
    this.isSelected = true,
  });

  final bool useBorder;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? highlightColor;
  final Color? borderColor;
  final Color? bgColor;
  final List<BoxShadow>? shadowColor;
  final List<Widget> children;
  final void Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(borderRadius),
      buttonColor: (isSelected) ? (bgColor ?? kColor(context).primary) : Colors.transparent,
      padding:
          padding ??
          EdgeInsets.symmetric(
            vertical: responsiveUI.own(0.0125),
            horizontal: responsiveUI.own(0.03),
          ),
      isOutlined: useBorder,
      borderWidth: (useBorder) ? 2 : 0,
      highlightColor: highlightColor,
      borderColor:
          (useBorder)
              ? (isSelected)
                  ? borderColor ?? kColor(context).secondary.withOpacity(0.6)
                  : borderColor ?? kColor(context).primary
              : null,
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: children,
      ),
    );
  }
}
