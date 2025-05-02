// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants/_constants.dart';

part 'dio_factory.g.dart';

/// Dio with basic configurations.
class DioFactory {
  Dio getDio() {
    final Dio dio = Dio();

    // Certificate issue handler.
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final HttpClient client = HttpClient(context: SecurityContext(withTrustedRoots: false));
        client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );

    dio.options = BaseOptions(
      headers: {
        NetConsts.CONTENT_TYPE: NetConsts.APPLICATION_JSON,
        NetConsts.ACCEPT: NetConsts.APPLICATION_JSON,
      },
      contentType: NetConsts.APPLICATION_JSON,
      receiveTimeout: const Duration(milliseconds: NetConsts.API_TIMEOUT),
      sendTimeout: const Duration(milliseconds: NetConsts.API_TIMEOUT),
      connectTimeout: const Duration(milliseconds: NetConsts.API_TIMEOUT),
    );

    // If not in release mode, log network requests with dio
    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }

    return dio;
  }
}

@riverpod
Dio dio(Ref ref) {
  return DioFactory().getDio();
}
