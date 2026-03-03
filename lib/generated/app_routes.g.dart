// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import 'package:dllni_resturant_owner_app/features/auth/view/screens/login_screen.dart';
import 'package:dllni_resturant_owner_app/features/main/view/screens/main_screen.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/profile_screen.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/working_time_screen.dart';

class GeneratedAppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
          settings: settings,
        );
      case '/main':
        if (args is int?) {
          return MaterialPageRoute(
            builder: (_) => MainScreen(mainScreenParam: args),
            settings: settings,
          );
        }
        return _errorRoute(settings);
      case '/profile':
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
          settings: settings,
        );
      case '/workingtime':
        return MaterialPageRoute(
          builder: (_) => WorkingTimeScreen(),
          settings: settings,
        );

    }

    return null;
  }

  static Route<dynamic> _errorRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('Route Error')),
      ),
      settings: settings,
    );
  }
}
