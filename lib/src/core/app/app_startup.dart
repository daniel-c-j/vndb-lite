import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';

// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:vndb_lite/src/features/local_notification/application/local_notification_service.dart';
import 'package:vndb_lite/src/util/text_extensions.dart';
import '../../app.dart';
import '../../constants/_constants.dart';
import '../_core.dart';
import '../exceptions/_exceptions.dart';

/// Helper class to initialize services and configure the error handlers.
class AppStartup {
  const AppStartup();

  /// Create the root widget that should be passed to [runApp].
  ///
  /// [minimumTest] exists to control the initialization logic when integration testing.
  Future<Widget> createRootWidget({
    required ProviderContainer container,
    bool minimumTest = false,
  }) async {
    // * Initialization and register error handlers for non testing environment.
    if (!minimumTest) {
      final errorLogger = container.read(errorLoggerProvider);
      _registerErrorHandlers(errorLogger);

      // * Initialize the core parts.
      await _initializeApp();

      // * Initialize services/providers specifically for riverpod.
      await _initializeProviders(container);
    }

    return UncontrolledProviderScope(container: container, child: const App());
  }

  /// Core app initializations.
  Future<void> _initializeApp() async {
    // Setting and getting general informations and configurations.
    await AppInfo.init(const PackageInfoWrapper());

    // TODO Hive localDB
    // if (!kIsWeb) Hive.init((await getApplicationDocumentsDirectory()).path);
    // Hive.registerAdapters();
    // await Hive.initBoxes();

    /// Set default transition values for all `GoTransition`.
    GoTransition.defaultCurve = Curves.easeInOut;
    GoTransition.defaultDuration = const Duration(milliseconds: 600);

    // Necessary to prevent http error for some devices.
    HttpOverrides.global = MyHttpOverrides();

    // Removing the # sign, and follow the real configured route in the URL for the web.
    if (kIsWeb) {
      usePathUrlStrategy();
      GoRouter.optionURLReflectsImperativeAPIs = true;
    }

    // Release mode configurations.
    if (kReleaseMode) {
      debugPrint = (String? message, {int? wrapWidth}) {};
    }
  }

  /// Provider and/or service listener initializations. Not to confuse with ProviderContainer
  /// initialization.
  Future<void> _initializeProviders(ProviderContainer container) async {
    await container.read(localNotifServiceProvider).init();
    await container.read(localNotifServiceProvider).askPermissions();
  }

  /// Register Flutter error handlers.
  void _registerErrorHandlers(ErrorLogger errorLogger) {
    // * Show some error UI if any uncaught exception happens
    FlutterError.onError = (FlutterErrorDetails details) {
      errorLogger.log(details.exception, details.stack);
      FlutterError.presentError(details);
    };

    // * Handle errors from the underlying platform/OS
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      errorLogger.log(error, stack);
      return true;
    };

    // * Show some error UI when any widget in the app fails to build
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child:
            (kReleaseMode)
                ? const Center(child: Text("(＃°Д°) s-something went wrong..."))
                : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.red,
                    title: const Text('An error occurred'),
                  ),
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.all(8),
                    child: Center(child: Text(details.toString()).wColor(Colors.black)),
                  ),
                ),
      );
    };
  }

  @visibleForTesting
  void registerErrorHandlers(ErrorLogger errorLogger) => _registerErrorHandlers(errorLogger);
}
