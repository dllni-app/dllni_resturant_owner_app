import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/auth/view/screens/login_screen.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/manager/bloc/profile_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/app_router.dart';
import 'features/main/view/screens/main_screen.dart';

class App extends StatelessWidget {
  const App({super.key, required this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      builder: (context, child) {
        return BlocProvider<ProfileBloc>.value(
          value: getIt<ProfileBloc>(),
          child: child ?? const SizedBox.shrink(),
        );
      },
      title: 'Dllni resturant',
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: SharedPreferencesHelper.getData(key: 'token') != null && SharedPreferencesHelper.getData(key: 'token') != ''
          ? const MainScreen()
          : const LoginScreen(),
      theme: ThemeData(
        fontFamily: 'cairo',
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff1E2A78),
          onPrimary: Color(0xffFFFFFF),
          secondary: Color(0xff6C63FF),
          onSecondary: Color(0xffFFFFFF),
          error: Color(0xffBF393D),
          onError: Color(0xffFFFFFF),
          surface: Color(0xffF0F0F0),
          onSurface: Color(0xffFFFFFF),
          primaryContainer: Color(0xffFF7A00),
          onPrimaryContainer: Color(0xffFFFFFF),
        ),
      ),
    );
  }
}
