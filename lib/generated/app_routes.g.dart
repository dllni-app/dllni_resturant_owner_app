// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import 'package:dllni_resturant_owner_app/features/auth/view/screens/login_screen.dart';
import 'package:dllni_resturant_owner_app/features/home/view/screens/notifications_screen.dart';
import 'package:dllni_resturant_owner_app/features/home/view/screens/performance_reports_screen.dart';
import 'package:dllni_resturant_owner_app/features/inventory/view/screens/create_inventory_item_screen.dart';
import 'package:dllni_resturant_owner_app/features/main/view/screens/main_screen.dart';
import 'package:dllni_resturant_owner_app/features/orders/view/screens/order_details_screen.dart';
import 'package:dllni_resturant_owner_app/features/products/view/screens/add_new_product_screen.dart';
import 'package:dllni_resturant_owner_app/features/products/view/screens/add_product_ai_screen.dart';
import 'package:dllni_resturant_owner_app/features/products/view/screens/add_product_details_screen.dart';
import 'package:dllni_resturant_owner_app/features/products/view/screens/add_product_menu_screen.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/activity_logs_screen.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/add_employee_screen.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/coupons_management_screen.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/create_coupon_screen.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/create_offer_screen.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/employee_activity_screen.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/employees_management_screen.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/offers_management_screen.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/pick_location_map_screen.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/profile_screen.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/support_screen.dart';
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
      case '/notifications':
        if (args is NotificationsScreenParams) {
          return MaterialPageRoute(
            builder: (_) => NotificationsScreen(args: args),
            settings: settings,
          );
        }
        return _errorRoute(settings);

      case '/performance-reports':
        return MaterialPageRoute(
          builder: (_) => PerformanceReportsScreen(),
          settings: settings,
        );
      case '/inventory/new':
        if (args is CreateInventoryItemScreenParams) {
          return MaterialPageRoute(
            builder: (_) => CreateInventoryItemScreen(params: args),
            settings: settings,
          );
        }
        return _errorRoute(settings);
      case '/main':
        if (args is int?) {
          return MaterialPageRoute(
            builder: (_) => MainScreen(mainScreenParam: args),
            settings: settings,
          );
        }
        return _errorRoute(settings);
      case '/orders/details':
        if (args is OrderDetailsParams) {
          return MaterialPageRoute(
            builder: (_) => OrderDetailsScreen(params: args),
            settings: settings,
          );
        }
        return _errorRoute(settings);
      case '/products/new_product':
        if (args is AddNewProductScreenParams) {
          return MaterialPageRoute(
            builder: (_) => AddNewProductScreen(params: args),
            settings: settings,
          );
        }
        return _errorRoute(settings);
      case '/products/new_product/ai':
        return MaterialPageRoute(
          builder: (_) => AddProductAIScreen(),
          settings: settings,
        );
      case '/products/new_product/details':
        if (args is AddProductDetailsScreenParams) {
          return MaterialPageRoute(
            builder: (_) => AddProductDetailsScreen(params: args),
            settings: settings,
          );
        }
        return _errorRoute(settings);
      case '/products/new_product/menu':
        return MaterialPageRoute(
          builder: (_) => AddProductMenuScreen(),
          settings: settings,
        );
      case '/employeesmanagement/new':
        if (args is AddEmployeeScreenParams) {
          return MaterialPageRoute(
            builder: (_) => AddEmployeeScreen(params: args),
            settings: settings,
          );
        }
        return _errorRoute(settings);
      case '/couponsmanagement':
        return MaterialPageRoute(
          builder: (_) => CouponsManagementScreen(),
          settings: settings,
        );
      case '/couponsmanagement/new':
        if (args is CreateCouponScreenParams?) {
          return MaterialPageRoute(
            builder: (_) => CreateCouponScreen(params: args),
            settings: settings,
          );
        }
        return _errorRoute(settings);
      case '/offersmanagement/new':
        if (args is CreateOfferScreenParams?) {
          return MaterialPageRoute(
            builder: (_) => CreateOfferScreen(params: args),
            settings: settings,
          );
        }
        return _errorRoute(settings);
      case '/employeesmanagement':
        return MaterialPageRoute(
          builder: (_) => EmployeesManagementScreen(),
          settings: settings,
        );
      case '/employees/activity':
        return MaterialPageRoute(
          builder: (_) => EmployeeActivityScreen(),
          settings: settings,
        );
      case '/employees/activity/logs':
        if (args is ActivityLogsScreenParams) {
          return MaterialPageRoute(
            builder: (_) => ActivityLogsScreen(params: args),
            settings: settings,
          );
        }
        return _errorRoute(settings);
      case '/offersmanagement':
        return MaterialPageRoute(
          builder: (_) => OffersManagementScreen(),
          settings: settings,
        );
      case '/profile/map':
        if (args is PickLocationMapParams) {
          return MaterialPageRoute(
            builder: (_) => PickLocationMapScreen(params: args),
            settings: settings,
          );
        }
        return _errorRoute(settings);
      case '/profile':
        if (args is ProfileScreenParams) {
          return MaterialPageRoute(
            builder: (_) => ProfileScreen(params: args),
            settings: settings,
          );
        }
        return _errorRoute(settings);
      case '/support':
        return MaterialPageRoute(
          builder: (_) => SupportScreen(),
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
      builder: (_) => const Scaffold(body: Center(child: Text('Route Error'))),
      settings: settings,
    );
  }
}
