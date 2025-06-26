// ignore_for_file: constant_identifier_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vndb_lite/src/constants/local_db_constants.dart';
import 'package:vndb_lite/src/core/local_db/shared_prefs.dart';
import 'package:vndb_lite/src/features/home/data/home_repo_abstract.dart';

part 'local_home_repo.g.dart';

class LocalHomeRepoImpl implements LocalHomeRepo {
  LocalHomeRepoImpl(this._sharedPref);

  final SharedPreferences _sharedPref;

  /// Checks whether cacheKey value exists or not in the local database.
  @override
  bool doesCacheExist(String cacheKey) {
    return _sharedPref.containsKey(cacheKey);
  }

  /// Returns a list of vn ids from all the cached preview either from remote
  /// datasource or local datasource. This method takes place in [LocalHomeRepo] since
  /// the preview ids already cached (local).
  @override
  Future<List<String>> fetchCachedPreview(int maxPreviewItem, {required String cacheKey}) async {
    // Will return empty list if cacheKey is not found.
    List<String> vnIds = _sharedPref.getStringList(cacheKey) ?? [];

    // Applying preview limitation app setting.
    if (vnIds.length > maxPreviewItem) {
      vnIds = vnIds.getRange(0, maxPreviewItem).toList();
    }

    return vnIds;
  }

  Future<void> refreshCollection() async {
    await _sharedPref.reload();
  }

  List<String> getInstantLocalPreview() {
    return _sharedPref.getStringList(DBKeys.COLLECTION_PREVIEW_CACHE_KEY) ?? [];
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> insertCollectionPreview(String vnId) async {
    final collectionPreview = _sharedPref.getStringList(DBKeys.COLLECTION_PREVIEW_CACHE_KEY) ?? [];

    // In order to prevent duplication, if vn id exists, then remove first.
    collectionPreview.remove(vnId);
    collectionPreview.insert(0, vnId);

    // Updating by overriding the value.
    await _sharedPref.setStringList(DBKeys.COLLECTION_PREVIEW_CACHE_KEY, collectionPreview);
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> popCollectionPreview(String vnId) async {
    final collectionPreview = _sharedPref.getStringList(DBKeys.COLLECTION_PREVIEW_CACHE_KEY) ?? [];
    collectionPreview.remove(vnId);

    // Updating by overriding the value.
    await _sharedPref.setStringList(DBKeys.COLLECTION_PREVIEW_CACHE_KEY, collectionPreview);
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  /// This method will only clear the remote previews.
  Future<void> clearAllLocalCachedPreviews() async {
    await _sharedPref.remove(DBKeys.COLLECTION_PREVIEW_CACHE_KEY);
  }

  /// This method will only clear the remote previews.
  Future<void> clearAllRemoteCachedPreviews() async {
    for (String key in _sharedPref.getKeys()) {
      if (key.contains(DBKeys.HOME_PREVIEW_CACHE_KEY)) {
        await _sharedPref.remove(key);
      }
    }
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //
}

@Riverpod(dependencies: [sharedPref])
LocalHomeRepoImpl localHomeRepo(Ref ref) {
  final sharedPref = ref.watch(sharedPrefProvider);
  return LocalHomeRepoImpl(sharedPref);
}

@Riverpod(dependencies: [localHomeRepo])
Future<List<String>> fetchCachedPreview(Ref ref, int maxPreviewItem, {required String cacheKey}) {
  final localHomeRepo = ref.watch(localHomeRepoProvider);
  return localHomeRepo.fetchCachedPreview(maxPreviewItem, cacheKey: cacheKey);
}
