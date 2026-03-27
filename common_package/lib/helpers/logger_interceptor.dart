import 'dart:convert';
import 'dart:io';

import 'package:common_package/helpers/debug_agent_log.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
class LoggerInterceptor extends Interceptor {
  final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 75,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  String _prettyJson(dynamic data) {
    try {
      if (data is String) {
        final decoded = json.decode(data);
        return const JsonEncoder.withIndent('  ').convert(decoded);
      } else {
        return const JsonEncoder.withIndent('  ').convert(data);
      }
    } catch (_) {
      return data.toString();
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    // #region agent log
    if (options.path.contains('notifications')) {
      agentDebugLog(
        hypothesisId: 'H3',
        location: 'logger_interceptor.dart:onRequest',
        message: 'notifications resolved URL',
        data: {
          'method': options.method,
          'fullUrl': requestPath,
          'queryParameters': options.queryParameters.toString(),
          'hasBody': options.data != null,
          'bodyType': options.data?.runtimeType.toString(),
        },
      );
    }
    // #endregion
    _logger.i(
        '${options.method} REQUEST => $requestPath\n'
            'Headers: ${jsonEncode(options.headers)}\n'
            'Query: ${jsonEncode(options.queryParameters)}\n'
            'Body: ${_prettyJson(options.data)}'
    );
    // #region agent log
    if (options.path.contains('coupons')) { try { final logFile = File(r'g:\my_projects\dllni_com\dllni_resturant_owner_app\.cursor\debug.log'); logFile.writeAsStringSync('${logFile.existsSync() ? logFile.readAsStringSync() : ""}${jsonEncode({"id":"log_${DateTime.now().millisecondsSinceEpoch}","timestamp":DateTime.now().millisecondsSinceEpoch,"location":"logger_interceptor.dart:40","message":"LoggerInterceptor final request","data":{"method":options.method,"url":"${options.baseUrl}${options.path}","headers":options.headers,"queryParameters":options.queryParameters,"body":options.data},"runId":"run1","hypothesisId":"E"})}\n', mode: FileMode.append); } catch (_) {} }
    // #endregion
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final requestPath = '${response.requestOptions.baseUrl}${response.requestOptions.path}';
    _logger.i(
        'RESPONSE [${response.statusCode}] => $requestPath\n'
            'Data: ${_prettyJson(response.data)}'
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    _logger.e(
        'ERROR => $requestPath\n'
            'Message: ${err.message}\n'
            'StatusCode: ${err.response?.statusCode}\n'
            'Response: ${_prettyJson(err.response?.data)}'
    );
    // #region agent log
    if (options.path.contains('notifications')) {
      final rd = err.response?.data;
      final s = rd is String ? rd : rd?.toString();
      final preview = s == null ? '' : (s.length > 120 ? s.substring(0, 120) : s);
      agentDebugLog(
        hypothesisId: 'H4',
        location: 'logger_interceptor.dart:onError',
        message: 'notifications 403/error response shape',
        data: {
          'statusCode': err.response?.statusCode,
          'responseRuntimeType': rd?.runtimeType.toString(),
          'responsePreview': preview,
          'contentType': err.response?.headers.value('content-type'),
        },
      );
    }
    if (options.path.contains('coupons')) { try { final logFile = File(r'g:\my_projects\dllni_com\dllni_resturant_owner_app\.cursor\debug.log'); logFile.writeAsStringSync('${logFile.existsSync() ? logFile.readAsStringSync() : ""}${jsonEncode({"id":"log_${DateTime.now().millisecondsSinceEpoch}","timestamp":DateTime.now().millisecondsSinceEpoch,"location":"logger_interceptor.dart:66","message":"LoggerInterceptor error response","data":{"statusCode":err.response?.statusCode,"errorMessage":err.message,"requestUrl":"${options.baseUrl}${options.path}","requestHeaders":options.headers,"requestQueryParams":options.queryParameters,"requestBody":options.data,"responseData":err.response?.data},"runId":"run1","hypothesisId":"E"})}\n', mode: FileMode.append); } catch (_) {} }
    // #endregion
    return super.onError(err, handler);
  }
}

