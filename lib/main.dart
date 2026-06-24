import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'core/di/injection.dart';
import 'core/session/session_expired_handler.dart';

Future<void> main() async {
  final navigatorKey = GlobalKey<NavigatorState>();
  SessionExpiredHandler.navigatorKey = navigatorKey;

  await bootstrapApp(
    AppBootstrapConfig(
      navigatorKey: navigatorKey,
      app: App(navigatorKey: navigatorKey),
      configureDependencies: configureInjection,
      startLocale: Locale('ar'),
      enableNotifications: true,
      onBackgroundTap: (message) async {
        print('==================================================== background');
        print(message);
      },
      onForegroundTap: (message) {
        print('==================================================== foreground');
        print(message);
      },
      onTerminatedTap: (message) async {
        print('==================================================== terminated');
        print(message);
      },
      fallbackLocale: const Locale('ar'),
      supportedLocales: const <Locale>[
        Locale('en'),
        Locale('ar'),
      ],
      translationsAssetPath: 'assets/translations',
      fcmTokenKey: 'fcm',
    ),
  );
}
