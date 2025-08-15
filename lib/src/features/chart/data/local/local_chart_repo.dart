import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vndb_lite/src/constants/local_db_constants.dart';
import 'package:vndb_lite/src/core/local_db/shared_prefs.dart';
import 'package:vndb_lite/src/features/chart/data/search_chart._data.dart';

part 'local_chart_repo.g.dart';

class LocalChartRepo {
  const LocalChartRepo(this._sharedPref);

  final SharedPreferences _sharedPref;

  void modifyStatsFromMap(Map<String, dynamic> data) {
    // Loop through all statscode
    for (StatsCode statsCode in StatsCode.values) {
      // Override every statscode with a new updated immutable data.
      final newValue = searchChartStatsData[statsCode.name]!.copyWith(data: data[statsCode.name]);
      searchChartStatsData[statsCode.name] = newValue;
    }
  }

  Future<void> saveStatsFromMap(Map<String, dynamic> data) async {
    final Map<String, int> statsData = {};

    for (StatsCode statsCode in StatsCode.values) {
      statsData[statsCode.name] = data[statsCode.name];

      // Override every statscode with a new updated immutable data.
      final newValue = searchChartStatsData[statsCode.name]!.copyWith(data: data[statsCode.name]);
      searchChartStatsData[statsCode.name] = newValue;
    }

    await _sharedPref.setString(DBKeys.VNDB_STATS, json.encode(statsData));
  }

  Map<String, dynamic>? get latestStats {
    if (isLatestStatsCached) return json.decode(_sharedPref.getString(DBKeys.VNDB_STATS)!);
    return null;
  }

  bool get isLatestStatsCached => _sharedPref.containsKey(DBKeys.VNDB_STATS);
}

@Riverpod(dependencies: [sharedPref])
LocalChartRepo localChartRepo(Ref ref) {
  final sharedPref = ref.watch(sharedPrefProvider);
  return LocalChartRepo(sharedPref);
}
