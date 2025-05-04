import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vndb_lite/src/constants/conf.dart';
import 'package:vndb_lite/src/constants/local_db_constants.dart';
import 'package:vndb_lite/src/core/local_db/shared_prefs.dart';
import 'package:vndb_lite/src/features/theme/theme_data_provider.dart';
import 'package:vndb_lite/src/features/settings/domain/settings_theme.conf.dart';
import 'package:vndb_lite/src/features/theme/data/theme_data.dart';

part 'settings_theme_state.g.dart';

@riverpod
class SettingsThemeState extends _$SettingsThemeState {
  @override
  SettingsThemeConf build() {
    return SettingsThemeConf(fontSize: _fontSize);
  }

  // TODO Should talk to repo instead of directly?

  double get _fontSize {
    final sharedPref = ref.read(sharedPrefProvider);
    final double? fontSize = sharedPref.getDouble(DBKeys.CUSTOM_FONT_SIZE_CONF);

    // Validate
    if (fontSize != null) {
      return fontSize;
    }

    return Default.CUSTOM_FONT_SIZE_CONF;
  }

  set fontSize(double value) {
    final sharedPref = ref.read(sharedPrefProvider);
    sharedPref.setDouble(DBKeys.CUSTOM_FONT_SIZE_CONF, value);
    sharedPref.reload();

    state = state.copyWith(fontSize: value);
  }
}
