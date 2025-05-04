// ignore_for_file: public_member_api_docs, sort_constructors_first

class SettingsThemeConf {
  const SettingsThemeConf({required this.fontSize});

  final double fontSize;

  SettingsThemeConf copyWith({double? fontSize}) {
    return SettingsThemeConf(fontSize: fontSize ?? this.fontSize);
  }
}
