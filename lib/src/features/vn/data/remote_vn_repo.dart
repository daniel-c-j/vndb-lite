import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vndb_lite/src/constants/network_constants.dart';
import 'package:vndb_lite/src/core/network/api_service.dart';
import 'package:vndb_lite/src/features/search/domain/generic_vn_post.dart';

part 'remote_vn_repo.g.dart';

class RemoteVnRepo {
  RemoteVnRepo(this._apiService);

  final ApiService _apiService;

  static final vnEndpoint = NetConsts.BASE_URL + "/kana/vn";
  static final releaseEndpoint = NetConsts.BASE_URL + "/kana/release";

  Future<Response> fetchP1Data(String vnId, {CancelToken? cancelToken}) async {
    return await _apiService.post(
      url: vnEndpoint,
      data: GenericPost(filters: ["id", "=", vnId], fields: NetConsts.P1_FIELDS).toMap(),
      cancelToken: cancelToken,
    );
  }

  Future<Response> fetchP2aData(String vnId, {CancelToken? cancelToken}) async {
    return await _apiService.post(
      url: vnEndpoint,
      data: GenericPost(filters: ["id", "=", vnId], fields: NetConsts.P2a_FIELDS).toMap(),
      cancelToken: cancelToken,
    );
  }

  Future<Response> fetchP2bData(String vnId, {CancelToken? cancelToken}) async {
    return await _apiService.post(
      url: releaseEndpoint,
      data:
          GenericPost(
            filters: [
              "vn",
              "=",
              ["id", "=", vnId],
            ],
            fields: NetConsts.P2b_FIELDS,
          ).toMap(),
      cancelToken: cancelToken,
    );
  }

  Future<Response> fetchP3Data(String vnId, {CancelToken? cancelToken}) async {
    return await _apiService.post(
      url: vnEndpoint,
      data: GenericPost(filters: ["id", "=", vnId], fields: NetConsts.P3_FIELDS).toMap(),
      cancelToken: cancelToken,
    );
  }
}

@Riverpod(dependencies: [apiService])
RemoteVnRepo remoteVnRepo(Ref ref) {
  final apiService = ref.watch(apiServiceProvider);
  return RemoteVnRepo(apiService);
}
