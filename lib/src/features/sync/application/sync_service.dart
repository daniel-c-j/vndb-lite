import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vndb_lite/src/features/_base/presentation/upper_parts/buttons/refresh_button.dart';
import 'package:vndb_lite/src/features/collection/application/collection_vn_service.dart';
import 'package:vndb_lite/src/features/collection/data/collection_status_data.dart';
import 'package:vndb_lite/src/features/collection/data/local/local_collection_repo.dart';
import 'package:vndb_lite/src/features/collection/domain/collection_status.dart';
import 'package:vndb_lite/src/features/collection/domain/record.dart';
import 'package:vndb_lite/src/features/local_notification/application/local_notification_service.dart';
import 'package:vndb_lite/src/features/sync/application/sync_notif_data.dart';
import 'package:vndb_lite/src/features/sync/data/local/local_sync_repo.dart';
import 'package:vndb_lite/src/features/sync/data/remote/remote_sync_repo.dart';
import 'package:vndb_lite/src/features/sync/data/remote/remote_sync_repo_helper.dart';
import 'package:vndb_lite/src/features/sync/domain/user_identity.dart';
import 'package:vndb_lite/src/features/sync/presentation/auth_screen_controller.dart';
import 'package:vndb_lite/src/features/vn/data/local_vn_repo.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

import '../../../core/_core.dart';

part 'sync_service.g.dart';

class SyncService {
  SyncService(this.ref, {required this.snackbar});

  final Ref ref;
  final void Function(String text, {required IconData icon, required Color iconColor}) snackbar;

  // A placeholder.
  Timer _refreshCollection = Timer(const Duration(days: 365), () {});

  Future<void> sync({required bool keepVns, required VoidCallback whenDownloadingAndSaving}) async {
    // Does not do any process whatsoever if there is no internet connection.
    final hasConnection = ref.read(connectivityNotifierProvider);
    if (!hasConnection) return returnError(status: 0);

    // Checking whether user already authenticated or not.
    final userIdentity = ref.read(authScreenControllerProvider);
    if (userIdentity == null) return returnError(status: 2);

    // User friendly message.
    ref
        .read(localNotifServiceProvider)
        .show(title: SyncStatus.ongoing.title, detail: getSyncNotifDetail(SyncStatus.ongoing));
    snackbar('Synchronizing account...', icon: Icons.sync, iconColor: kColor().tertiary);

    if (!await _isTokenValid(userIdentity)) return returnError(status: 1);

    final remoteSyncRepo = ref.read(remoteSyncRepoProvider);
    // Sync process begin
    try {
      // 1. Fetch all Vns data from the cloud collection
      await Future.delayed(const Duration(milliseconds: 1500));
      List rawRecords = await remoteSyncRepo.getLatestDataFromCloud(userIdentity.id);

      // 2. If user chose to keep his/her Vns from the local collection (default), then post and patch
      // the vns to the cloud collection.
      if (keepVns) {
        final localRecords = await ref.read(localCollectionRepoProvider).getAllRecords();

        snackbar('Processing records...', icon: Icons.sync, iconColor: kColor().tertiary);
        rawRecords = await remoteSyncRepo.filterAndSyncRecords(
          localRecords,
          rawRecords,
          authToken: userIdentity.authToken,
        );
      }

      // 3. After all record has been synchronized and the filtered data retrieved,
      // it's best to clean the residual data first.
      await remoteSyncRepo.removeResidualData();

      // 4. After that, it is time to fetch them back to make sure data is correct
      // and served locally.
      await getDataPhases(rawRecords, whenDownloadingAndSaving);

      // 5. Success
      _successfullySynchronized(whenDownloadingAndSaving);
      //
    } catch (e) {
      debugPrint(e.toString());

      // * If error, clean only the data in memory, not the persistent ones in local storage.
      // * Because it still reflects the changes made by the user from the app.
      remoteSyncRepo.cleanFetchLatestData();
      returnError();
      //
    } finally {
      _refreshCollection.cancel();
      await AppBarRefreshButton.tap(); // Forbidden Ref
    }
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  VnRecord _generateVnRecord(Map<String, dynamic> cloudRecord) {
    return VnRecord(
      id: cloudRecord['id'],
      title: cloudRecord['vn']['title'],
      status: cloudRecord['status'],
      vote: getVnCloudVote(cloudRecord),
      added: getVnCloudDate('added', cloudRecord),
      started: getVnCloudDate('started', cloudRecord),
      finished: getVnCloudDate('finished', cloudRecord),
    );
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> getDataPhases(List records, VoidCallback whenDownloadingAndSaving) async {
    final Set<VnRecord> vnRecords = {};

    for (var record in records) {
      if (record is VnRecord) {
        vnRecords.add(record);
        continue;
      }

      // This eliminates strange status label that is not defined in the vn status label.
      String labelValue = "";
      for (Map<String, dynamic> label in record['labels']) {
        final String newLabel = label['label']?.toLowerCase();
        if (newLabel == 'vote') continue;

        if (COLLECTION_STATUS_DATA.containsKey(newLabel)) labelValue = newLabel;
      }

      // TODO supports custom label and multiple labels.
      if (labelValue.isEmpty) continue;

      // Injecting label to cloudrecord's status to make it available to process.
      record['status'] = labelValue;
      vnRecords.add(_generateVnRecord(record));
    }

    // After saving all of the records, now's the time to save each phase 01
    // and phase 02 data of the vn.
    await _downloadAndSaveData(vnRecords, whenDownloadingAndSaving);
    return;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _downloadAndSaveData(
    Set<VnRecord> vnRecords,
    VoidCallback whenDownloadingAndSaving,
  ) async {
    final localVnRepo = ref.read(localVnRepoProvider);
    final collectionRepo = ref.read(localCollectionRepoProvider);

    _refreshCollection = Timer.periodic(const Duration(milliseconds: 6000), (_) async {
      whenDownloadingAndSaving();
    });

    for (VnRecord record in vnRecords) {
      // Checks locally if either p1 or p2 data exists or not, if not will download both and save.
      if (!localVnRepo.p1Exist(record.id) || !localVnRepo.p2Exist(record.id)) {
        await ref.read(validateVnAndSaveToLocalProvider(record.id).future);
      }

      // Saves vn record if data exists in local collection.
      await collectionRepo.saveVnRecord(record);
      await collectionRepo.refreshCollection();
      await Future.delayed(const Duration(milliseconds: 500));

      final title =
          (record.title.length >= 14) ? '${record.title.substring(0, 12)}...' : record.title;
      if (!localVnRepo.p1Exist(record.id) || !localVnRepo.p2Exist(record.id)) {
        snackbar("Failed to sync $title", icon: Icons.error, iconColor: Colors.red);
      } else {
        snackbar("$title synced! ", icon: Icons.check_circle, iconColor: Colors.green);
      }
    }
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  void returnError({int status = 0}) async {
    // TODO enhance this.
    return await Future.delayed(const Duration(milliseconds: 400), () {
      if (status == 0) {
        snackbar(
          'Connection Error. Try again later, ok?',
          icon: Icons.error,
          iconColor: Colors.red,
        );
        //
      } else if (status == 1) {
        snackbar('Bad Token Permissions', icon: Icons.error, iconColor: Colors.red);
        //
      } else {
        snackbar('Error. Please try to re-authenticate.', icon: Icons.error, iconColor: Colors.red);
      }

      // Shows statusbar notification error.
      ref
          .read(localNotifServiceProvider)
          .show(title: SyncStatus.failed.title, detail: getSyncNotifDetail(SyncStatus.failed));
    });
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<bool> _isTokenValid(UserIdentity userIdentity) async {
    try {
      final response = await ref
          .read(authScreenControllerProvider.notifier)
          .authenticate(userIdentity.authToken);

      if (response.data['permissions'].contains('listread') &&
          response.data['permissions'].contains('listwrite')) {
        return true;
      }
    } catch (e) {
      //
    }

    return false;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  void _successfullySynchronized(VoidCallback whenSuccess) {
    ref.read(localSyncRepoProvider).isUserSynchronized = true;

    Future.delayed(const Duration(milliseconds: 3500), () {
      whenSuccess();
      ref
          .read(localNotifServiceProvider)
          .show(title: SyncStatus.success.title, detail: getSyncNotifDetail(SyncStatus.success));
      snackbar('Synchronization successful', icon: Icons.sync, iconColor: kColor().tertiary);
    });

    return;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //
}

@riverpod
SyncService syncService(
  Ref ref, {
  required void Function(String, {required IconData icon, required Color iconColor}) snackbar,
}) {
  return SyncService(ref, snackbar: snackbar);
}
