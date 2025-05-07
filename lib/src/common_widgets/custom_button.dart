import 'package:flutter/material.dart';

/// Custom button widget that supports [InkWell] splash behaviour, but more enhanced.
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.child,
    this.msg,
    this.buttonColor,
    this.margin,
    this.borderRadius,
    this.padding,
    this.highlightColor,
    this.isOutlined = false,
    this.borderColor,
    this.gradientColor,
    this.gradientStart,
    this.gradientEnd,
    this.borderWidth,
    this.elevation,
    this.clipBehavior = Clip.antiAlias,
  });

  final VoidCallback onTap;

  /// Tooltip message.
  final String? msg;
  final Widget child;
  final Color? buttonColor;

  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final List<Color>? gradientColor;
  final AlignmentGeometry? gradientStart;
  final AlignmentGeometry? gradientEnd;
  final Color? highlightColor;
  final double? elevation;

  final bool isOutlined;
  final Color? borderColor;
  final double? borderWidth;
  final Clip clipBehavior;

  static final BorderRadius _radius = BorderRadius.circular(10);
  static const EdgeInsets _padding = EdgeInsets.symmetric(horizontal: 20, vertical: 10);

  @override
  Widget build(BuildContext context) {
    final buttonWidget = Padding(
      // ? Despite how it's actually padding, it acts as a margin, since it's controlling the area
      // ? outisde the child widget. This is also more lightweight than utilizing Container widget
      padding: margin ?? EdgeInsets.zero,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: buttonColor,
          gradient:
              (gradientColor != null)
                  ? LinearGradient(
                    begin: gradientStart ?? Alignment.topRight,
                    end: gradientEnd ?? Alignment.bottomLeft,
                    colors: gradientColor!,
                  )
                  : null,
          border:
              (isOutlined)
                  ? Border.all(color: borderColor ?? Colors.white, width: borderWidth ?? 1.5)
                  : Border.all(width: 0, color: Colors.transparent),
          borderRadius: borderRadius ?? _radius,
          boxShadow: (elevation != null) ? [BoxShadow(blurRadius: elevation!)] : null,
        ),
        child: ClipRRect(
          borderRadius: borderRadius ?? _radius,
          clipBehavior: clipBehavior,
          child: Material(
            color: Colors.transparent,
            borderRadius: borderRadius ?? _radius,
            elevation: 0,
            child: InkWell(
              splashColor: highlightColor,
              highlightColor: highlightColor,
              borderRadius: borderRadius ?? _radius,
              onTap: onTap,
              child: Padding(padding: padding ?? _padding, child: child),
            ),
          ),
        ),
      ),
    );

    // Null tooltip message will throw an error.
    return (msg != null) ? Tooltip(message: msg, child: buttonWidget) : buttonWidget;
  }
}
