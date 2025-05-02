import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '_exceptions.dart';

part 'error_logger.g.dart';

class ErrorLogger {
  final _log = Logger();

  /// This method will separate the error object to be processed by certain mechanism based
  /// on the error's type.
  void log(Object error, StackTrace? stackTrace) =>
      (error is AppException) ? _logAppException(error) : _logError(error, stackTrace);

  void _logError(Object error, StackTrace? stackTrace) {
    // * Optional to be replaced with a crash reporting tool. (Sentry, Crashlytics, etc.)
    if (kReleaseMode) {
      // TODO Watchout
    }

    // Fatal level since it isn't recognized as a defined AppException.
    _log.f('ERROR', error: error, stackTrace: stackTrace);
  }

  void _logAppException(AppException exception) {
    // * Optional to be replaced with a crash reporting tool. (Sentry, Crashlytics, etc.)
    if (kReleaseMode) {
      // TODO Watchout
    }

    // Warning level since it is recognized as a pre-defined Exception.
    _log.w('', error: exception);
  }
}

/// Basic usage would be:
/// ```
/// try {}
/// catch (e, st) {
///    ref.read(errorLoggerProvider).logError(e, st);
/// }
/// ```

@riverpod
ErrorLogger errorLogger(Ref ref) {
  return ErrorLogger();
}
