// coverage:ignore-file
import 'package:flutter/material.dart';

import '../core/_core.dart';

// ! [WARNING]
// ! Everything here must only be used one widget below Material widget.

// * [INFO]
// * This is intentionally not an extension of [BuildContext] itself, since this is
// * meant to be as flexible as possible, even outside widget class itself despite how
// * not a good practice it actually is.

/// An alternative way to get BuildContext that is assigned globally to GoRouter.
BuildContext get altContext => NavigationService.currentContext;

/// Easily get screen width.
double kScreenWidth([BuildContext? ctx]) {
  try {
    return (ctx == null) ? MediaQuery.sizeOf(altContext).width : MediaQuery.sizeOf(ctx).width;
  } catch (e) {
    // Expecting the screen width to be mobile.
    return 360;
  }
}

/// Easily get screen height.
double kScreenHeight([BuildContext? ctx]) {
  try {
    return (ctx == null) ? MediaQuery.sizeOf(altContext).height : MediaQuery.sizeOf(ctx).height;
  } catch (e) {
    // Expecting the screen height to be mobile.
    return 720;
  }
}

/// Easily get theme [ColorScheme].
ColorScheme kColor([BuildContext? ctx]) {
  try {
    return (ctx == null) ? Theme.of(altContext).colorScheme : Theme.of(ctx).colorScheme;
  } catch (e) {
    // Will go by default.
    return ColorScheme.fromSeed(seedColor: Colors.blueAccent);
  }
}

/// Easily get theme [Textstyle].
TextTheme kTxtStyle(BuildContext context) => Theme.of(context).textTheme;

/// Easily communicate with [ScaffoldMessenger]. Intended as a shortcut for
/// ```dart
/// ScaffoldMessenger.of(context).showSnackBar();
/// ```
ScaffoldMessengerState kSnackBar(BuildContext context) => ScaffoldMessenger.of(context);
