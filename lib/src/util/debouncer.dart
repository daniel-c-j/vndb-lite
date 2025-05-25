import 'dart:async';

/// Debouncer class to prevent exhaustive function spam.
///
/// ! Never declare the object as a const variable.
/// Usage:
/// ``` dart
/// final _fastDebouncer = Debouncer(delay: Duration(milliseconds: 100));
/// _fastDebouncer.call(() => expensiveMethod());
///
/// @override
/// void dispose() {
///   _fastDebouncer.dispose();
/// }
/// ```
///
class Debouncer {
  Debouncer({this.delay = const Duration(milliseconds: 300)});

  final Duration delay;
  Timer? _timer;

  void call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
