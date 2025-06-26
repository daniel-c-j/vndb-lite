import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vndb_lite/src/constants/network_constants.dart';
import 'package:vndb_lite/src/core/local_db/shared_prefs.dart';
import 'package:vndb_lite/src/core/network/api_service.dart';
import 'package:vndb_lite/src/features/home/data/preview_sections_data.dart';
import 'package:vndb_lite/src/features/vn/data/local_vn_repo.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/features/home/data/home_repo_abstract.dart';
import 'package:vndb_lite/src/features/search/domain/generic_vn_post.dart';

part 'remote_home_repo.g.dart';

class RemoteHomeRepoImpl implements RemoteHomeRepo {
  RemoteHomeRepoImpl(this._apiService, this._sharedPref, this._localVnRepo);

  final ApiService _apiService;
  final SharedPreferences _sharedPref;
  final LocalVnRepo _localVnRepo;

  /// Fetch data from VNDB api using [ApiService].
  /// Will be used in [HomeService] for the success data processed into a model.
  @override
  Future<Response> fetchPreview(
    HomeSectionsCode sectionData,
    int maxItem, {
    CancelToken? cancelToken,
  }) async {
    final postData = _convertSectionDataToPostData(sectionData);

    return await _apiService.post(
      url: NetConsts.BASE_URL + '/kana/vn',
      data: postData.toMap(),
      cancelToken: cancelToken,
    );
  }

  GenericPost _convertSectionDataToPostData(HomeSectionsCode sectionData) {
    return GenericPost(
      reverse: true,
      sort: sectionData.labelCode?.name,
      fields: NetConsts.P1_FIELDS,
      filters: sectionData.filter?.toList(),
      results: sectionData.maxPreviewItem,
    );
  }

  /// This method allows for the fetched preview data to be processed centrally inside [LocalHomeRepo].
  @override
  Future<void> cachePreview(List<VnDataPhase01> vnData, {required String cacheKey}) async {
    final List<String> vnIds = [];

    for (VnDataPhase01 vnDataP1 in vnData) {
      await _localVnRepo.saveVnContent(vnDataP1);
      vnIds.add(vnDataP1.id);
    }

    final success = await _sharedPref.setStringList(cacheKey, vnIds);
    if (!success) throw Exception();
  }
}

@Riverpod(dependencies: [apiService, sharedPref, localVnRepo])
RemoteHomeRepoImpl remoteHomeRepo(Ref ref) {
  final apiService = ref.watch(apiServiceProvider);
  final sharedPref = ref.watch(sharedPrefProvider);
  final localVnRepo = ref.watch(localVnRepoProvider);
  return RemoteHomeRepoImpl(apiService, sharedPref, localVnRepo);
}

@Riverpod(dependencies: [remoteHomeRepo])
Future<Response> fetchPreview(
  Ref ref,
  HomeSectionsCode sectionData,
  int maxItem, {
  CancelToken? cancelToken,
}) async {
  final remoteHomeRepo = ref.watch(remoteHomeRepoProvider);
  return await remoteHomeRepo.fetchPreview(sectionData, maxItem, cancelToken: cancelToken);
}

@Riverpod(dependencies: [remoteHomeRepo])
Future<void> cachePreview(Ref ref, List<VnDataPhase01> vnData, {required String cacheKey}) {
  final remoteHomeRepo = ref.watch(remoteHomeRepoProvider);
  return remoteHomeRepo.cachePreview(vnData, cacheKey: cacheKey);
}
