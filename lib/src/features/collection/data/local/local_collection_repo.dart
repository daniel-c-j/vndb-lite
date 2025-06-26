// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vndb_lite/src/constants/local_db_constants.dart';
import 'package:vndb_lite/src/core/local_db/shared_prefs.dart';
import 'package:vndb_lite/src/features/collection/domain/record.dart';
import 'package:vndb_lite/src/features/home/data/local/local_home_repo.dart';

part 'local_collection_repo.g.dart';

class LocalCollectionRepo {
  const LocalCollectionRepo(this._sharedPref, this._localHomeRepo);

  final SharedPreferences _sharedPref;
  final LocalHomeRepoImpl _localHomeRepo;

  Future<void> refreshCollection() async {
    await _sharedPref.reload();
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> saveVnRecord(VnRecord vnRecord) async {
    final int? sectionRange = getSectionFromId(vnRecord.id);

    if (sectionRange == null) {
      // TODO do this more.
      throw Exception('Bad sectionRange. Please check the typical vn id (e.g v12345).');
    }

    final List<String> collection =
        _sharedPref.getStringList('${DBKeys.SAVED_COLLECTION_OF_SECTION_V}$sectionRange') ?? [];

    // In order to prevent duplication, if vn record exists, then remove first.
    collection.removeWhere((record) => record.contains('"${vnRecord.id}"'));

    // ! Breaking change for version > 2.0.0, assign lastmod property for VN record.
    collection.add(
      vnRecord
          .copyWith(lastmod: (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString())
          .toJson(),
    );

    // Override data
    await _sharedPref.setStringList(
      '${DBKeys.SAVED_COLLECTION_OF_SECTION_V}$sectionRange',
      collection,
    );

    // Updates home interface
    await _updateSectionRangeList(vnRecord.id);
    await _localHomeRepo.insertCollectionPreview(vnRecord.id);
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> removeVnRecord(String vnId) async {
    final int? sectionRange = getSectionFromId(vnId);

    if (sectionRange == null) {
      throw Exception('Bad sectionRange. Please check the typical vn id (e.g v12345).');
    }

    // If section never exists, just ignore it.
    if (!_sharedPref.containsKey('${DBKeys.SAVED_COLLECTION_OF_SECTION_V}$sectionRange')) return;

    final List<String> collection =
        _sharedPref.getStringList('${DBKeys.SAVED_COLLECTION_OF_SECTION_V}$sectionRange') ?? [];

    collection.removeWhere((vnRecord) => vnRecord.contains('"$vnId"'));

    await _sharedPref.setStringList(
      '${DBKeys.SAVED_COLLECTION_OF_SECTION_V}$sectionRange',
      collection,
    );

    await _updateSectionRangeList(vnId);
    await _localHomeRepo.popCollectionPreview(vnId);
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _updateSectionRangeList(String vnId) async {
    final List<String> currentSectionRangeLists =
        _sharedPref.getStringList(DBKeys.SAVED_COLLECTION_SECTIONS) ?? [];
    final int sectionRange = getSectionFromId(vnId)!;

    if (currentSectionRangeLists.contains('$sectionRange')) {
      final VnRecord? vnInCollection = getVnRecordFromId(vnId);

      // If a section found have nothing inside, then delete the section.
      if (vnInCollection == null) {
        await _sharedPref.remove('${DBKeys.SAVED_COLLECTION_OF_SECTION_V}$sectionRange');
        currentSectionRangeLists.remove('$sectionRange');
      }
      //
    } else {
      //
      currentSectionRangeLists.add('$sectionRange');
    }

    await _sharedPref.setStringList(DBKeys.SAVED_COLLECTION_SECTIONS, currentSectionRangeLists);
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  VnRecord? getVnRecordFromId(String vnId) {
    final int? sectionRange = getSectionFromId(vnId);
    final List<String> collection = getVnRecordsFromSection('$sectionRange');

    final rawVnRecord = collection.firstWhereOrNull((savedVn) => savedVn.contains('"$vnId"'));

    if (rawVnRecord == null) return null;
    return VnRecord.fromMap(json.decode(rawVnRecord));
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  int? getSectionFromId(String vnId) {
    final int vnRecordsPerSection = 100;

    // Expected raw vnId is one letter prefix, the rest are numbers. (v34522)
    final int? extractedVnId = int.tryParse(vnId.toLowerCase().replaceAll("v", ""));
    if (extractedVnId == null) return null;

    // (~/) is dart's floor division operator syntax, not to confuse with (%) modulo.
    final int sectionCode = extractedVnId ~/ vnRecordsPerSection;
    if (sectionCode == 0) return vnRecordsPerSection;

    // Added one to prevent having a sectionRange with 200 items, since V100 used for those
    // id under 100 (see above), and if sectionCode == 1 comes to play, it will also have the same
    // sectionRange of V100 (sectionCode * 100), so afterwards, the sectionRange must be incremented
    // specifically by one except for sectionCode of 0.
    return (sectionCode + 1) * vnRecordsPerSection;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  List<String> getVnRecordsFromSection(String sectionRange) {
    return _sharedPref.getStringList('${DBKeys.SAVED_COLLECTION_OF_SECTION_V}$sectionRange') ?? [];
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  List<String> get rawAllRecords {
    final List<String> collectionSections =
        _sharedPref.getStringList(DBKeys.SAVED_COLLECTION_SECTIONS) ?? [];
    List<String> fullCollectionList = [];

    for (String sectionRange in collectionSections) {
      final List<String> collectionPerSection = getVnRecordsFromSection(sectionRange);

      // Appending the previous results.
      if (collectionPerSection.isNotEmpty) {
        fullCollectionList = [...fullCollectionList, ...collectionPerSection];
      }
    }

    return fullCollectionList;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> removeAllCollection({required bool includeSync}) async {
    // A case scenario where user already once synchronized with the server, and for some reason,
    // they want to delete or remove all of their collections, then the below operation must also
    // be executed, in order to also remove those collections in their cloud account too.
    // But ONLY will happen, if they're clicking the sync button again.
    final List<String> removeVnIds = getVnToBeRemovedWhenSync();
    if (includeSync) {
      final allRecords = await getAllRecords();
      for (VnRecord record in allRecords) {
        removeVnIds.add(record.id);
      }

      await setVnToBeRemovedWhenSync(removeVnIds);
    }

    final collectionSections =
        _sharedPref.getStringList(DBKeys.SAVED_COLLECTION_SECTIONS) ?? <String>[];
    for (String sectionRange in collectionSections) {
      //
      if (_sharedPref.containsKey('${DBKeys.SAVED_COLLECTION_OF_SECTION_V}$sectionRange')) {
        await _sharedPref.remove('${DBKeys.SAVED_COLLECTION_OF_SECTION_V}$sectionRange');
      }
    }

    await _sharedPref.remove(DBKeys.SAVED_COLLECTION_SECTIONS);
    await _localHomeRepo.clearAllLocalCachedPreviews();
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> cleanVnToBeRemovedWhenSync() async {
    await _sharedPref.setStringList(DBKeys.VN_RECORDS_TO_BE_REMOVED, []);
  }

  Future<void> setVnToBeRemovedWhenSync(List<String> vnId) async {
    List<String> vns = _sharedPref.getStringList(DBKeys.VN_RECORDS_TO_BE_REMOVED) ?? [];
    vns = [...vns, ...vnId];

    await _sharedPref.setStringList(DBKeys.VN_RECORDS_TO_BE_REMOVED, vns);
  }

  List<String> getVnToBeRemovedWhenSync() {
    return _sharedPref.getStringList(DBKeys.VN_RECORDS_TO_BE_REMOVED) ?? [];
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> cleanAddedViaAppNotBySync() async {
    await _sharedPref.setStringList(DBKeys.VN_RECORDS_ADDED_BY_APP, []);
  }

  /// Returns an ID of VNs that are added directly by the app in order
  /// to not conflict with VNs that are added by synchronizing from the
  /// cloud.
  Future<void> setAddedViaAppNotBySync(List<String> vnId) async {
    List<String> vns = _sharedPref.getStringList(DBKeys.VN_RECORDS_ADDED_BY_APP) ?? [];
    vns = [...vns, ...vnId];

    await _sharedPref.setStringList(DBKeys.VN_RECORDS_ADDED_BY_APP, vns);
  }

  /// Returns an ID of VNs that are added directly by the app in order
  /// to not conflict with VNs that are added by synchronizing from the
  /// cloud.
  List<String> getAddedViaAppNotBySync() {
    return _sharedPref.getStringList(DBKeys.VN_RECORDS_ADDED_BY_APP) ?? [];
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  List<String> getRawRecords(List<VnRecord> records) {
    final List<String> tempDB = [];
    for (VnRecord vnRecord in records) {
      tempDB.add(json.encode(vnRecord.toMap()));
    }

    return tempDB;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<List<VnRecord>> getAllRecords([List<String>? partialCollection]) async {
    final List<String> dbCollection = partialCollection ?? rawAllRecords;
    return [for (String rawRecord in dbCollection) VnRecord.fromJson(rawRecord)];
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //
}

@Riverpod(dependencies: [sharedPref, localHomeRepo])
LocalCollectionRepo localCollectionRepo(Ref ref) {
  final sharedPref = ref.watch(sharedPrefProvider);
  final localHomeRepo = ref.watch(localHomeRepoProvider);
  return LocalCollectionRepo(sharedPref, localHomeRepo);
}
