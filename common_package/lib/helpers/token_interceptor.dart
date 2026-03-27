import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:common_package/helpers/debug_agent_log.dart';
import 'package:common_package/helpers/shared_preferences_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TokenInterceptor extends Interceptor {
  final String? tokenKey;
  final String? fcmKey;
  final String? lang;
  final Function()? onRequestFunction;

  TokenInterceptor({required this.tokenKey, required this.fcmKey, required this.lang, required this.onRequestFunction});

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      if (onRequestFunction != null) {
        onRequestFunction!();
      }

      if (tokenKey != null) {
        final token = SharedPreferencesHelper.getData(key: tokenKey!) ?? '';
        options.headers['Authorization'] = 'Bearer $token';
        log('========================> token: $token');
        // #region agent log
        if (options.path.contains('notifications')) {
          agentDebugLog(
            hypothesisId: 'H1',
            location: 'token_interceptor.dart:onRequest',
            message: 'notifications auth header',
            data: {'tokenLength': token.length, 'path': options.path},
          );
        }
        // #endregion
        // #region agent log
        if (options.path.contains('coupons')) { try { final logFile = File(r'g:\my_projects\dllni_com\dllni_resturant_owner_app\.cursor\debug.log'); logFile.writeAsStringSync('${logFile.existsSync() ? logFile.readAsStringSync() : ""}${jsonEncode({"id":"log_${DateTime.now().millisecondsSinceEpoch}","timestamp":DateTime.now().millisecondsSinceEpoch,"location":"token_interceptor.dart:28","message":"TokenInterceptor Authorization header","data":{"tokenLength":token.length,"authHeader":options.headers['Authorization'],"path":options.path},"runId":"run1","hypothesisId":"C"})}\n', mode: FileMode.append); } catch (_) {} }
        // #endregion
      }

      if (fcmKey != null) {
        final fcm = SharedPreferencesHelper.getData(key: fcmKey!) ?? '';
        options.headers['fcm-token'] = fcm;
        log('========================> fcm: $fcm');
      }

      if (lang != null && lang!.isNotEmpty) {
        options.headers['App-Language'] = lang!;
        log('========================> lang: ${lang!}');
      }
      // #region agent log
      if (options.path.contains('coupons')) { try { final logFile = File(r'g:\my_projects\dllni_com\dllni_resturant_owner_app\.cursor\debug.log'); logFile.writeAsStringSync('${logFile.existsSync() ? logFile.readAsStringSync() : ""}${jsonEncode({"id":"log_${DateTime.now().millisecondsSinceEpoch}","timestamp":DateTime.now().millisecondsSinceEpoch,"location":"token_interceptor.dart:42","message":"TokenInterceptor final headers","data":{"allHeaders":options.headers,"queryParams":options.queryParameters,"body":options.data?.toString()},"runId":"run1","hypothesisId":"D"})}\n', mode: FileMode.append); } catch (_) {} }
      // #endregion
    } catch (e) {
      debugPrint('TokenInterceptor Error: $e');
    }

    super.onRequest(options, handler);
  }
}
