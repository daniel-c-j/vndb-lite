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

    return UncontrolledProviderScope(
      key: const Key(AppInfo.TITLE),
      container: container,
      child: const App(),
    );
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
    try {
      await container.read(localNotifServiceProvider).init();
      await container.read(localNotifServiceProvider).askPermissions();
    } catch (error) {
      // Local notifications are optional and may be unavailable on a Linux
      // desktop without a compatible notification daemon. Keep startup usable.
      debugPrint('Local notifications unavailable: $error');
    }
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
      // This builder may be invoked before MaterialApp is built. Keep it
      // independent of inherited Material/Directionality widgets so an error
      // can never recurse and leave the native splash screen visible.
      return Directionality(
        textDirection: TextDirection.ltr,
        child: ColoredBox(
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                kReleaseMode
                    ? '(＃°Д°) s-something went wrong...'
                    : details.toString(),
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      );
    };
  }

  @visibleForTesting
  void registerErrorHandlers(ErrorLogger errorLogger) =>
      _registerErrorHandlers(errorLogger);
}
