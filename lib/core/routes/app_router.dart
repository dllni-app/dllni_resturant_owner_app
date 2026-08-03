import 'package:flutter/material.dart';

import '../../features/main/view/screens/main_screen.dart';
import '../../generated/app_routes.g.dart';
import '../helpers/seller_permission_access.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final access = SellerPermissionAccess.current();
    final requiredPermission = _requiredPermission(settings.name);

    if (requiredPermission != null && !access.can(requiredPermission)) {
      return _permissionDeniedRoute(settings);
    }

    if (_isOwnerOnlyRoute(settings.name) && !access.hasFullAccess) {
      return _permissionDeniedRoute(settings);
    }

    return GeneratedAppRoutes.onGenerateRoute(settings);
  }

  static String? _requiredPermission(String? routeName) {
    if (routeName == '/orders/details') {
      return RestaurantPermissionCodes.orders;
    }

    if (routeName?.startsWith('/products/') ?? false) {
      return RestaurantPermissionCodes.meals;
    }

    if (routeName == '/inventory/new') {
      return RestaurantPermissionCodes.warehouse;
    }

    if (routeName?.startsWith('/couponsmanagement') ?? false) {
      return RestaurantPermissionCodes.offersAndCoupons;
    }

    if (routeName?.startsWith('/offersmanagement') ?? false) {
      return RestaurantPermissionCodes.offersAndCoupons;
    }

    if (routeName?.startsWith('/employeesmanagement') ?? false) {
      return RestaurantPermissionCodes.employees;
    }

    if (routeName?.startsWith('/employees/activity') ?? false) {
      return RestaurantPermissionCodes.employees;
    }

    if (routeName == '/profile' ||
        routeName == '/profile/map' ||
        routeName == '/workingtime') {
      return RestaurantPermissionCodes.storeData;
    }

    return null;
  }

  static bool _isOwnerOnlyRoute(String? routeName) {
    return routeName == '/performance-reports';
  }

  static Route<dynamic> _permissionDeniedRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('غير مصرح')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_outline, size: 48),
                const SizedBox(height: 16),
                const Text(
                  'ليس لديك صلاحية للوصول إلى هذه الصفحة.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const MainScreen()),
                      (_) => false,
                    );
                  },
                  child: const Text('العودة إلى الرئيسية'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
