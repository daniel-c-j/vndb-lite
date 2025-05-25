import 'package:flutter/material.dart';

enum ButtonState { active, inactive, loading }

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
  });

  final VoidCallback onTap;
  final Widget child;

  /// Tooltip message. Default: `null`.
  final String? msg;
  final Color? buttonColor;

  /// Default: `Semi-transparent Grey`.
  final Color? highlightColor;

  /// Default: `EdgeInsets.zero`
  final EdgeInsetsGeometry? margin;

  /// Default: `EdgeInsets.symmetric(horizontal: 20, vertical: 10)`.
  final EdgeInsetsGeometry? padding;

  /// Default: `null`.
  final List<Color>? gradientColor;

  /// Default: `Alignment.topRight`.
  final AlignmentGeometry? gradientStart;

  /// Default: `Alignment.bottomLeft`.
  final AlignmentGeometry? gradientEnd;

  /// Default: `BorderRadius.circular(10)`.
  final BorderRadius? borderRadius;

  /// Default: `null`.
  final double? elevation;

  /// Default: `false`.
  final bool isOutlined;

  /// Default (If isOutlined true): `Colors.white`.
  final Color? borderColor;

  /// Default (If isOutlined true): `1.5`.
  final double? borderWidth;

  static final BorderRadius _radius = BorderRadius.circular(10);
  static const EdgeInsets _margin = EdgeInsets.zero;
  static const EdgeInsets _padding = EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static const double _borderWidth = 1.5;
  static const Color _borderColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final buttonWidget = Padding(
      // ? Despite how it's actually padding, it acts as a margin, since it's controlling the area
      // ? outisde the child widget. This is also more lightweight than utilizing Container widget
      padding: margin ?? _margin,
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
                  ? Border.all(
                    color: borderColor ?? _borderColor,
                    width: borderWidth ?? _borderWidth,
                  )
                  : Border.all(width: 0, color: Colors.transparent),
          borderRadius: borderRadius ?? _radius,
          boxShadow:
              (elevation != null)
                  ? [BoxShadow(blurRadius: elevation!, offset: Offset(0, elevation ?? 0))]
                  : null,
        ),
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
    );

    // ? Null tooltip message will throw an error.
    return (msg != null) ? Tooltip(message: msg, child: buttonWidget) : buttonWidget;
  }
}
