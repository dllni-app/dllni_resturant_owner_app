import 'package:common_package/helpers/typedef.dart';
import 'package:dio/dio.dart';

import 'error_handler.dart';

mixin HandlingApiManager {
  Future<T> wrapHandlingApi<T>({required Future<Response> Function() tryCall, required FromJson<T> jsonConvert}) async {
    final response = await tryCall();
    final statusCode = response.statusCode ?? -1;

    if (statusCode >= 200 && statusCode < 300) {
      if (statusCode == 204 || _isEmptySuccessBody(response.data)) {
        return jsonConvert(<String, dynamic>{});
      }
      return jsonConvert(response.data);
    } else if (statusCode == 401) {
      throw UnauthenticatedFailure(message: _extractErrorMessage(response.data));
    } else if (statusCode == 403) {
      throw UserBlockedFailure(message: _extractErrorMessage(response.data));
    } else {
      throw ServerFailure(message: _extractErrorMessage(response.data), statusCode: statusCode);
    }
  }

  bool _isEmptySuccessBody(dynamic body) {
    return body == null || (body is String && body.trim().isEmpty);
  }

  String _extractErrorMessage(dynamic body) {
    if (body is Map) {
      final message = body["message"];
      if (message != null && message.toString().trim().isNotEmpty) {
        return message.toString();
      }

      final errors = body["errors"];
      if (errors != null && errors.toString().trim().isNotEmpty) {
        return errors.toString();
      }
    } else if (body is String && body.trim().isNotEmpty) {
      return body;
    }

    return "Unknown server error";
  }
}
