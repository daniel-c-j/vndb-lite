import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vndb_lite/src/constants/conf.dart';
import 'package:vndb_lite/src/constants/network_constants.dart';
import 'package:vndb_lite/src/core/network/api_service.dart';
import 'package:vndb_lite/src/features/collection/data/collection_status_data.dart';
import 'package:vndb_lite/src/features/collection/data/local/local_collection_repo.dart';
import 'package:vndb_lite/src/features/collection/domain/record.dart';
import 'package:vndb_lite/src/features/sort_filter/data/sortable_data.dart';
import 'package:vndb_lite/src/features/sync/data/remote/remote_sync_repo_helper.dart';

part 'remote_sync_repo.g.dart';

class RemoteSyncRepo {
  RemoteSyncRepo(this._apiService, this._collection);

  final ApiService _apiService;
  final LocalCollectionRepo _collection;

  static final authEndpoint = NetConsts.BASE_URL + "/kana/authinfo";

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<Response> authenticate(String token) async {
    return await _apiService.get(
      url: authEndpoint,
      options: Options(headers: {'Authorization': 'token $token'}),
    );
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> removeResidualData() async {
    _collection.addedByTheAppNotBySync();
    _collection.cleanVnToBeRemovedWhenSync();
    return;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  /// List of api call responses, meant to store future data, and outside any function
  /// to prevent being overwritten.
  final List<Map<String, String>> _resultFromAPI = [];

  /// Page of results.
  int _page = 1;

  Future<List<Map<String, String>>> getLatestDataFromCloud(String userId) async {
    // Get the collections from the cloud.
    final Response requestToServer = await _apiService.post(
      url: NetConsts.BASE_URL + "/kana/ulist",
      data: {
        "user": userId,
        "sort": SortableCode.added.name,
        "fields": NetConsts.USER_VNS_FIELDS,
        "results": Default.MAX_VN_SEARCH_RESULT,
        "page": _page,
      },
    );

    // Keeps appending till reach `more = false` flag.
    _resultFromAPI.addAll(requestToServer.data['results']);

    // Repeating again until there is no 'more' left.
    if (requestToServer.data['more']) {
      _page++;
      return getLatestDataFromCloud(userId);
    }

    // Back to default
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _resultFromAPI.clear();
      _page = 1;
    });

    return _resultFromAPI;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  // TODO sync snackbar/user feedback when data is deleted/saved/modified.
  Future<List> filterAndSyncRecords(
    List<VnRecord> localRecords,
    List cloudRecords, {
    required String authToken,
    required bool keepVns,
  }) async {
    final List vnIdsToBeSaved = [];

    // *** Filter the localRecords first.
    for (VnRecord localRecord in localRecords) {
      final int statusId = COLLECTION_STATUS_DATA[localRecord.status.toLowerCase()]!.id;
      final localRecordInTheCloud = cloudRecords.firstWhereOrNull(
        (idx) => idx['id'] == localRecord.id,
      );

      // ** MODIFYING SECTION
      // * If local record exists in the cloud. (Just need to be done once)
      if (localRecordInTheCloud != null) {
        // Preparing for comparing data to check for any changes.
        if (isThereAnyDierence(localRecord, localRecordInTheCloud)) {
          // For behavioral issue of the API (or maybe I was drunk at that time, jk), such logic happen:
          // If vote exists in vn, then delete the vn first, and then repost the record.
          if (localVnHasVote(localRecord)) {
            await delete(localRecordInTheCloud['id']!, authToken: authToken);
          }

          await post(localRecord, authToken: authToken, statusId: statusId);
        }

        vnIdsToBeSaved.add(localRecordInTheCloud);
        vnIdsToBeSaved.add(localRecord);
      }

      // ** ADDING/DELETING SECTION
      // * If local record does not exist in the cloud. Then:
      // * 1. If VN never been deleted before locally, then backup it to the server.
      if (localRecord.isAddedByTheAppNotBySync()) {
        await post(localRecord, authToken: authToken, statusId: statusId);
        vnIdsToBeSaved.add(localRecord);
        continue;
      }

      // * 2. The record already deleted from the server, then sync the deletion to local too.
      _collection.removeVnRecord(localRecord.id);
    }

    // *** Filter the rest that are unique only in cloudRecords.
    for (Map<String, String> cloudRecord in cloudRecords) {
      final cloudRecordInTheLocal = localRecords.firstWhereOrNull(
        (idx) => idx.id == cloudRecord['id'],
      );

      // ** MODIFYING SECTION
      // * If cloud record exists in the local: Then do nothing. Intersection already handled by
      // * the above filter.

      // ** ADDING/DELETING SECTION CONTD.
      // * If cloud record does not exist in the local.
      if (cloudRecordInTheLocal == null) {
        // * 1. If ever deleted before, then delete the vn too in the cloud.
        if (_collection.vnToBeRemovedWhenSync.contains(cloudRecord['id']!)) {
          await delete(cloudRecord['id']!, authToken: authToken);
          continue;
        }

        // * 2. If never exists before, then save it to the local.
        vnIdsToBeSaved.add(cloudRecord);
      }
    }

    return vnIdsToBeSaved;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> delete(String vnId, {required String authToken}) async {
    return await Future.delayed(const Duration(milliseconds: 1200), () async {
      await _apiService.delete(
        url: NetConsts.BASE_URL + "/kana/ulist/$vnId",
        options: Options(
          contentType: 'application/json',
          headers: {'Authorization': 'token $authToken'},
        ),
      );
    });
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> post(
    VnRecord localRecord, {
    required String authToken,
    required int statusId,
  }) async {
    return await Future.delayed(const Duration(milliseconds: 1200), () async {
      // Despite how the method name is "patch", it still works logically as if posting
      // a new data related to the user, that is, posting new vnrecord related to the user.
      await _apiService.patch(
        url: NetConsts.BASE_URL + "/kana/ulist/${localRecord.id}",
        options: Options(
          contentType: 'application/json',
          headers: {'Authorization': 'token $authToken'},
        ),
        data: {
          'labels': [statusId],
          // If vote data does exist.
          if (localVnHasVote(localRecord)) 'vote': localRecord.vote * 10,
          'started': getLocalVnDate('started', localRecord.toMap()),
          'finished': getLocalVnDate('finished', localRecord.toMap()),
        },
      );
    });
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //
}

@Riverpod(dependencies: [apiService, localCollectionRepo])
RemoteSyncRepo remoteSyncRepo(Ref ref) {
  final apiService = ref.watch(apiServiceProvider);
  final localCollectionRepo = ref.watch(localCollectionRepoProvider);
  return RemoteSyncRepo(apiService, localCollectionRepo);
}

@Riverpod(dependencies: [remoteSyncRepo])
Future<Response> authenticate(Ref ref, String token) async {
  final remoteSyncRepo = ref.watch(remoteSyncRepoProvider);
  return await remoteSyncRepo.authenticate(token);
}
