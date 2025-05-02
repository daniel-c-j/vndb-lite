// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'colors.dart';

part 'theme_data_provider.g.dart';

@Riverpod(keepAlive: true)
class LightTheme extends _$LightTheme {
  @override
  ThemeData build() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: PRIMARY_COLOR_L1,
        surface: SURFACE_COLOR_L0,
        inverseSurface: SURFACE_COLOR_L1,
        surfaceDim: SURFACE_DIM_COLOR_L,
        brightness: Brightness.light,
      ),
      dividerColor: SURFACE_DIM_COLOR_D.withAlpha(150),
      dividerTheme: DividerThemeData(color: SURFACE_DIM_COLOR_D.withAlpha(150)),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: GoTransitions.fadeUpwards,
          TargetPlatform.iOS: GoTransitions.cupertino,
          TargetPlatform.macOS: GoTransitions.cupertino,
        },
      ),
      textTheme: GoogleFonts.sourceCodeProTextTheme(
              // TextTheme(
              //   // title
              //   titleLarge: TextStyle(fontSize: fontSizes.titleLarge),
              //   titleMedium: TextStyle(fontSize: fontSizes.titleMedium),
              //   titleSmall: TextStyle(fontSize: fontSizes.titleSmall),

              //   // body
              //   bodyLarge: TextStyle(fontSize: fontSizes.bodyLarge),
              //   bodyMedium: TextStyle(fontSize: fontSizes.bodyMedium),
              //   bodySmall: TextStyle(fontSize: fontSizes.bodySmall),
              // ),
              )
          .apply(
        bodyColor: TEXT_COLOR_L,
        displayColor: TEXT_COLOR_L,
      ),
    );
  }
}

@Riverpod(keepAlive: true)
class DarkTheme extends _$DarkTheme {
  @override
  ThemeData build() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: PRIMARY_COLOR_D1,
        surface: SURFACE_COLOR_D0,
        inverseSurface: SURFACE_COLOR_D1,
        surfaceDim: SURFACE_DIM_COLOR_D,
        brightness: Brightness.dark,
      ),
      dividerColor: SURFACE_DIM_COLOR_L.withAlpha(150),
      dividerTheme: DividerThemeData(color: SURFACE_DIM_COLOR_L.withAlpha(150)),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: GoTransitions.fadeUpwards,
          TargetPlatform.iOS: GoTransitions.cupertino,
          TargetPlatform.macOS: GoTransitions.cupertino,
        },
      ),
      textTheme: GoogleFonts.sourceCodeProTextTheme(
              // TextTheme(
              //   // title
              //   titleLarge: TextStyle(fontSize: fontSizes.titleLarge),
              //   titleMedium: TextStyle(fontSize: fontSizes.titleMedium),
              //   titleSmall: TextStyle(fontSize: fontSizes.titleSmall),

              //   // body
              //   bodyLarge: TextStyle(fontSize: fontSizes.bodyLarge),
              //   bodyMedium: TextStyle(fontSize: fontSizes.bodyMedium),
              //   bodySmall: TextStyle(fontSize: fontSizes.bodySmall),
              // ),
              )
          .apply(
        bodyColor: TEXT_COLOR_D,
        displayColor: TEXT_COLOR_D,
      ),
    );
  }
}
