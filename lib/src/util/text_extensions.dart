// coverage:ignore-file
import 'package:flutter/material.dart';

/// Extension parts of the [Text] Widget meant to minimalize the configuration needed
extension TextExtension on Text {
  /// Will copy the current [Text] widget configuration.
  ///
  /// [WARNING] This is actually a bad approach since [Text] widget could be updated in anytime
  /// officially, and there might be some deprecated parameters, or parameters that is yet
  /// covered in this method. Better check the official documentation first, and reconfigure
  /// this method as needed.
  Text copyWith(
    String data, {
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    Color? selectionColor,
  }) =>
      Text(
        data,
        style: style ?? this.style,
        strutStyle: strutStyle ?? this.strutStyle,
        textAlign: textAlign ?? this.textAlign,
        textDirection: textDirection ?? this.textDirection,
        locale: locale ?? this.locale,
        softWrap: softWrap ?? this.softWrap,
        overflow: overflow ?? this.overflow,
        textScaler: textScaler ?? this.textScaler,
        maxLines: maxLines ?? this.maxLines,
        semanticsLabel: semanticsLabel ?? this.semanticsLabel,
        textWidthBasis: textWidthBasis ?? this.textWidthBasis,
        selectionColor: selectionColor ?? this.selectionColor,
      );

  Text get bold => copyWith(data!, style: style?.copyWith(fontWeight: FontWeight.bold));
  Text get italic => copyWith(data!, style: style?.copyWith(fontStyle: FontStyle.italic));

  Text withColor(Color color) => copyWith(data!, style: style?.copyWith(color: color));
  Text sizeOf(double size) => copyWith(data!, style: style?.copyWith(fontSize: size));
}
