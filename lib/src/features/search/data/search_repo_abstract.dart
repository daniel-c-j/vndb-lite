import 'package:dio/dio.dart';
import 'package:vndb_lite/src/features/search/domain/generic_vn_post.dart';

abstract class RemoteSearchRepo {
  Future remoteSearchVn(GenericPost requestData, {CancelToken? cancelToken}) async {}
}
