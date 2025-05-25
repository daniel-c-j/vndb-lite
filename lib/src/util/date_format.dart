import 'package:intl/intl.dart';

/// Extension to format DateTime objects using [intl] package.
extension DateTimeFormatter on DateTime {
  static final _classicFormatter = DateFormat('dd-MM-yyyy');

  /// Will format [DateTime] object into `dd-MM-yyyy` format.
  String get formatTimeClassic => _classicFormatter.format(this);
}
