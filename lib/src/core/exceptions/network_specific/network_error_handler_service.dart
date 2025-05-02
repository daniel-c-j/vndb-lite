import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../_exceptions.dart';

part 'network_error_handler_service.g.dart';

/// Handling basic Network Exceptions, and DioException by returning a NetFailure object containing
/// human-readable error message.
///
/// Typical usage in a catch block would be:
/// ``` dart
/// catch (error) {
///   return NetworkErrorHandlerService.handle(error);
/// }
///
class NetworkErrorHandlerService {
  AppException handle(DioException error) {
    return _getFailure(error);
  }

  AppException _getFailure(DioException error) {
    try {
      if (error.error is NoConnectionException) return NoConnectionException();

      final response = error.response;
      if (response == null) return UnknownException();

      // Checks for status code.
      final code = response.statusCode;
      for (AppException failure in NET_RESPONSE_ERROR) {
        if (failure.code == code) return failure;
      }

      // Status code not found, then return formatted raw message. Should be logged.
      final message = _extractErrorMessage(response.data);
      return CustomException(message);
    } catch (e) {
      return UnknownException();
    }
  }

  String _extractErrorMessage(dynamic data) {
    if (data is String) return data;

    if (data is Map) {
      String message = '';
      data.forEach((key, value) {
        if (value is List) {
          message += value.join(' \n');
        } else if (value is String) {
          message += (data.entries.last.key == key) ? value.toString() : "$value ";
        } else {
          message += " $value ";
        }
      });
      return message;
    }

    // If data is not a string or a map, return a default error message
    return UnknownException().toString();
  }

  @visibleForTesting
  String extractErrorMessage(dynamic data) => _extractErrorMessage(data);

  @visibleForTesting
  AppException getFailure(DioException error) => _getFailure(error);
}

@riverpod
NetworkErrorHandlerService netErrorHandler(Ref ref) {
  return NetworkErrorHandlerService();
}
