import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

/// Clears session storage and navigates to login when a protected API returns 401.
class SessionExpiredHandler {
  SessionExpiredHandler._();

  static GlobalKey<NavigatorState>? navigatorKey;

  static bool _navigating = false;

  static Future<void> handle() async {
    if (_navigating) return;
    _navigating = true;
    try {
      await SharedPreferencesHelper.clearData();
      final nav = navigatorKey?.currentState;
      if (nav != null) {
        // Must await: otherwise [handle] completes immediately, the interceptor
        // clears its gate, and every other 401 triggers another login navigation.
        await nav.pushNamedAndRemoveUntil<void>(
          '/login',
          (route) => false,
        );
      }
    } finally {
      _navigating = false;
    }
  }
}
