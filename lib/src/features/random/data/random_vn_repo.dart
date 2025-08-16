import 'dart:math';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vndb_lite/src/features/search/domain/generic_vn_post.dart';
import 'package:vndb_lite/src/features/sort_filter/data/sortable_data.dart';
import 'package:vndb_lite/src/features/sort_filter/domain/filter_.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';

import '../../../constants/_constants.dart';
import '../../../core/_core.dart';

part 'random_vn_repo.g.dart';

class RandomVnRepo {
  RandomVnRepo(this._apiService);

  final ApiService _apiService;

  static const ratingMin = 80;
  static const ratingMax = 90;
  final random = Random();

  int get randomRatingNum => (ratingMin + (random.nextDouble() * (ratingMax - ratingMin))).toInt();

  Future generate() async {
    final rawData = await _getRawData();
    final List formattedData = rawData.data['results'];
    return VnDataPhase01.fromMap(formattedData.sample(1)[0]);
  }

  Future<Response> _getRawData() async {
    final postData = GenericPost(
      reverse: true,
      sort: SortableCode.rating.name,
      filters: CustomFilterData(query: [SortableCode.rating.name, ">=", randomRatingNum]).toList(),
      fields: NetConsts.P1_FIELDS,
      results: 20,
    );

    return await _apiService.post(url: '${NetConsts.BASE_URL}/kana/vn', data: postData.toMap());
  }
}

@Riverpod(dependencies: [apiService])
RandomVnRepo randomVnRepo(Ref ref) {
  final apiService = ref.watch(apiServiceProvider);
  return RandomVnRepo(apiService);
}
