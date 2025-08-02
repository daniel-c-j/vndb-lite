import 'package:flutter_riverpod/flutter_riverpod.dart';

import '_exceptions.dart';

/// Error logger class to keep track of all AsyncError states that are set
/// by the controllers in the app.
class AsyncErrorLogger extends ProviderObserver {
  const AsyncErrorLogger();

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    final errorLogger = context.container.read(errorLoggerProvider);
    final error = _findError(value);

    if (error == null) return;
    errorLogger.log(error.error, error.stackTrace);
  }

  AsyncError<dynamic>? _findError(Object? value) {
    if (value is AsyncError) return value;
    return null;
  }
}
