import 'package:common_package/annotations/auto_route_page.dart';
import 'package:flutter/material.dart';

import '../../../home/view/screens/home_screen.dart';
import '../../../inventory/view/screens/inventory_screen.dart';
import '../../../orders/view/screens/orders_screen.dart';
import '../../../products/view/screens/products_screen.dart';
import '../../../profile/view/screens/more_screen.dart';
import '../widgets/bottom_nav_bar.dart';

@AutoRoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.mainScreenParam});

  final int? mainScreenParam;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 5, vsync: this);
    if (widget.mainScreenParam != null) {
      controller.index = widget.mainScreenParam!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(controller: controller),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [HomeScreen(), OrdersScreen(), ProductsScreen(), InventoryScreen(), MoreScreen()],
      ),
    );
  }
}
