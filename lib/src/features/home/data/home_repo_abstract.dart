import 'package:dio/dio.dart';
import 'package:vndb_lite/src/features/home/data/preview_sections_data.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';

class RemoteHomeRepo {
  Future fetchPreview(
    HomeSectionsCode sectionData,
    int maxItem, {
    CancelToken? cancelToken,
  }) async {}

  Future cachePreview(List<VnDataPhase01> vnData, {required String cacheKey}) async {}
}

class LocalHomeRepo {
  bool doesCacheExist(String cacheKey) => true;

  Future fetchCachedPreview(int maxPreviewItem, {required String cacheKey}) => Future.value(0);
}
