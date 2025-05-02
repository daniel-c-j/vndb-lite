import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  static final _formatter = DateFormat('dd-MM-yyyy');

  /// Will format [DateTime] object into `dd-MM-yyyy` format.
  String get formatTime => _formatter.format(this);
}
