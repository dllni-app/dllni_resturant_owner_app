import 'package:common_package/annotations/auto_route_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/helpers/seller_permission_access.dart';
import '../../../../generated/assets.dart';
import '../../../home/view/screens/home_screen.dart';
import '../../../inventory/view/screens/inventory_screen.dart';
import '../../../orders/view/screens/orders_screen.dart';
import '../../../products/view/screens/products_screen.dart';
import '../../../profile/domain/usecases/fetch_resturant_data_use_case.dart';
import '../../../profile/view/manager/bloc/profile_bloc.dart';
import '../../../profile/view/screens/more_screen.dart';
import '../widgets/bottom_nav_bar.dart';

@AutoRoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.mainScreenParam});

  final int? mainScreenParam;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late final TabController controller;
  late final List<_MainTab> tabs;

  @override
  void initState() {
    super.initState();

    final access = SellerPermissionAccess.current();
    tabs = [
      _MainTab(
        screen: const HomeScreen(),
        destination: BottomNavDestinationData(
          title: 'الرئيسية',
          image: Assets.images.navBarHome.path,
        ),
      ),
      if (access.can(RestaurantPermissionCodes.orders))
        _MainTab(
          screen: const OrdersScreen(),
          destination: BottomNavDestinationData(
            title: 'الطلبات',
            image: Assets.images.navBarOrders.path,
          ),
        ),
      if (access.can(RestaurantPermissionCodes.meals))
        _MainTab(
          screen: const ProductsScreen(),
          destination: BottomNavDestinationData(
            title: 'الوجبات',
            image: Assets.images.navBarProducts.path,
          ),
        ),
      if (access.can(RestaurantPermissionCodes.warehouse))
        _MainTab(
          screen: const InventoryScreen(),
          destination: BottomNavDestinationData(
            title: 'المخزون',
            image: Assets.images.navBarInventory.path,
          ),
        ),
      _MainTab(
        screen: const MoreScreen(),
        destination: BottomNavDestinationData(
          title: 'المزيد',
          image: Assets.images.navBarMore.path,
        ),
      ),
    ];

    final requestedIndex = widget.mainScreenParam;
    final initialIndex = requestedIndex == 4
        ? tabs.length - 1
        : (requestedIndex ?? 0).clamp(0, tabs.length - 1).toInt();

    controller = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: initialIndex,
    );

    getIt<ProfileBloc>().add(
      FetchResturantDataEvent(params: FetchResturantDataParams()),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        controller: controller,
        items: tabs.map((tab) => tab.destination).toList(growable: false),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: tabs.map((tab) => tab.screen).toList(growable: false),
      ),
    );
  }
}

class _MainTab {
  const _MainTab({required this.screen, required this.destination});

  final Widget screen;
  final BottomNavDestinationData destination;
}
