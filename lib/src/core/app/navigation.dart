import 'package:flutter/material.dart';

/// Service class to provide global buildcontext.
class NavigationService {
  // In order to accessing a global context, a navigator key is made.
  // Useful in a function that isn't attached in any build method yet require to use context.
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Using ! assertion since the navigatorKey tied with goRouterState which is using riverpod keepAlive.
  static BuildContext get currentContext => navigatorKey.currentContext!;
  static NavigatorState get currentState => navigatorKey.currentState!;
  static Widget get currentWidget => navigatorKey.currentWidget!;
}
