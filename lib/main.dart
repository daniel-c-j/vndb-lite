// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'src/core/_core.dart';

Future<void> main() async {
  // * Ensuring widgets binding at startup.
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // * Summoning splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // * Creating app startup instance for further initialization.
  const appStartup = AppStartup();
  final container = await appStartup.initializeProviderContainer();
  final root = await appStartup.createRootWidget(container: container);

  // * Entry point
  runApp(root);
}
