import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../widgets/inventory_app_bar.dart';
import '../widgets/inventory_categories_list.dart';
import '../widgets/inventory_item_card.dart';
import '../widgets/inventory_statistics_grid.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          InventoryAppBar(),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 24),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: context.primaryContainer),
              width: context.width,
              padding: EdgeInsetsDirectional.symmetric(vertical: 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle, color: context.onPrimaryContainer, size: 22),
                  SizedBox(width: 8),
                  AppText.labelLarge('إضافة مادة جديدة', color: context.onPrimaryContainer, fontWeight: FontWeight.bold),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          InventoryStatisticsGrid(),
          SizedBox(height: 16),
          InventoryCategoriesList(),
          SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsetsDirectional.only(start: 24, end: 24, bottom: 10),
              itemBuilder: (context, index) => InventoryItemCard(
                isLow: index % 2 == 0,
                productName: 'زيت الزيتون',
                currentQuantity: '2.5 لتر',
                minimumQuantity: '5 لتر',
                statusText: 'منخفض',
                lastUpdated: 'منذ 5 ساعات',
                cardColor: index % 2 == 0 ? context.error : Color(0xff24B364),
                onIncrement: () {},
                onDecrement: () {},
                onAdjustQuantity: () {},
              ),
              separatorBuilder: (context, index) => SizedBox(height: 16),
              itemCount: 7,
            ),
          ),
        ],
      ),
    );
  }
}
