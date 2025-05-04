// coverage:ignore-file

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants/_constants.dart';
import '../../core/_core.dart';
import 'data/theme_data.dart';

part 'theme_data_provider.g.dart';

@Riverpod(keepAlive: true)
class AppThemeState extends _$AppThemeState {
  @override
  ThemeCode build() => _appTheme;

  ThemeCode get _appTheme {
    try {
      final sharedPref = ref.read(sharedPrefProvider);
      final String? theme = sharedPref.getString(DBKeys.THEME_CONF);

      // Validate
      if (theme != null) return ThemeCode.values.byName(theme);
    } catch (e) {
      // Doesn't care if there's an error, just return default conf.
    }

    return Default.THEME_CONF;
  }

  set appTheme(ThemeCode themeCode) {
    final sharedPref = ref.read(sharedPrefProvider);
    sharedPref.setString(DBKeys.THEME_CONF, themeCode.name);
    sharedPref.reload();

    state = themeCode;
  }
}
