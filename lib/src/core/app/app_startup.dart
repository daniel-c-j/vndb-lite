import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hive_ce/hive.dart';
import 'package:vndb_lite/src/util/local_notification.dart';
import 'package:vndb_lite/src/util/text_extensions.dart';
import '../../app.dart';
import '../../constants/_constants.dart';
import '../../util/context_shortcut.dart';
import '../_core.dart';
import '../exceptions/_exceptions.dart';

/// Helper class to initialize services and configure the error handlers.
class AppStartup {
  const AppStartup();

  /// Create the root widget that should be passed to [runApp].
  Future<Widget> createRootWidget({
    required ProviderContainer container,
    bool minimumTest = false,
  }) async {
    // * Initalize app.
    if (!minimumTest) await _initializeApp();

    // * Initialize services/providers.
    await _initializeProviders(container);

    // * Register error handlers.
    if (!minimumTest) {
      final errorLogger = container.read(errorLoggerProvider);
      _registerErrorHandlers(errorLogger);
    }

    return UncontrolledProviderScope(container: container, child: const App());
  }

  /// Core app initializations.
  Future<void> _initializeApp() async {
    // Setting and getting general informations and configurations.
    NetConsts.init();
    await AppInfo.init(const PackageInfoWrapper());

    // TODO Hive localDB
    // if (!kIsWeb) Hive.init((await getApplicationDocumentsDirectory()).path);
    // Hive.registerAdapters();
    // await Hive.initBoxes();

    // Initializing local notification.
    // TODO use ref and replace in initialize providers instead here.
    await localNotification.init();
    await localNotification.askPermissions();

    // Removing the # sign, and follow the real configured route in the URL for the web.
    if (kIsWeb) {
      usePathUrlStrategy();
      GoRouter.optionURLReflectsImperativeAPIs = true;
    }

    /// Set default transition values for all `GoTransition`.
    GoTransition.defaultCurve = Curves.easeInOut;
    GoTransition.defaultDuration = const Duration(milliseconds: 600);

    // Necessary to prevent http error for some devices.
    HttpOverrides.global = MyHttpOverrides();

    // Prevent google font to access internet to download the already downloaded font.
    GoogleFonts.config.allowRuntimeFetching = false;

    // Release mode configurations.
    if (kReleaseMode) {
      debugPrint = (String? message, {int? wrapWidth}) {};
    }
  }

  /// Provider and/or service listener initializations. Not to confuse with ProviderContainer
  /// initialization.
  Future<void> _initializeProviders(ProviderContainer container) async {
    // TODO
    // await container.read(platformBrightnessProvider.notifier).init();
  }

  /// Register Flutter error handlers.
  void _registerErrorHandlers(ErrorLogger errorLogger) {
    // * Show some error UI if any uncaught exception happens
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      errorLogger.log(details.exception, details.stack);
    };

    // * Handle errors from the underlying platform/OS
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      errorLogger.log(error, stack);
      return true;
    };

    // * Show some error UI when any widget in the app fails to build
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return SizedBox(
        height: kScreenHeight(),
        width: kScreenWidth(),
        child: Scaffold(
          appBar: AppBar(backgroundColor: Colors.red, title: const Text('An error occurred')),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Center(child: Text(details.toString()).withColor(Colors.black)),
          ),
        ),
      );
    };
  }

  @visibleForTesting
  void registerErrorHandlers(ErrorLogger errorLogger) => _registerErrorHandlers(errorLogger);
}
