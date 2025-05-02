// // ignore_for_file: non_constant_identifier_names
// import 'package:flutter/material.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'font_sizes.g.dart';

// @riverpod
// class FontSizes extends _$FontSizes {
//   @override
//   double build() {
//     // TODO optimized by user to zoom the text 1.0 scale, 0.9, 1.2, etc...
//     return 1.0;
//   }

//   double get titleLarge {
//     return switch (SCREEN_WIDTH) {
//       > Breakpoint.TABLET => 28 * state,
//       > Breakpoint.MOBILE => 28 * state,
//       _ => 28 * state,
//     };
//   }

//   double get titleMedium {
//     return switch (SCREEN_WIDTH) {
//       > Breakpoint.TABLET => 22.5 * state,
//       > Breakpoint.MOBILE => 22.5 * state,
//       _ => 18.5 * state,
//     };
//   }

//   double get titleSmall {
//     return switch (SCREEN_WIDTH) {
//       > Breakpoint.TABLET => 18.5 * state,
//       > Breakpoint.MOBILE => 18.5 * state,
//       _ => 18.5 * state,
//     };
//   }

//   double get bodyLarge {
//     return switch (SCREEN_WIDTH) {
//       > Breakpoint.TABLET => 16.5 * state,
//       > Breakpoint.MOBILE => 16.5 * state,
//       _ => 16.5 * state,
//     };
//   }

//   double get bodyMedium {
//     return switch (SCREEN_WIDTH) {
//       > Breakpoint.TABLET => 15 * state,
//       > Breakpoint.MOBILE => 14 * state,
//       _ => 13.5 * state,
//     };
//   }

//   double get bodySmall {
//     return switch (SCREEN_WIDTH) {
//       > Breakpoint.TABLET => 11 * state,
//       > Breakpoint.MOBILE => 10.5 * state,
//       _ => 10 * state,
//     };
//   }
// }
