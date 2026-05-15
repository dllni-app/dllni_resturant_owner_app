import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../data/models/get_orders_model.dart';

class OrderDetailsNotesCard extends StatelessWidget {
  const OrderDetailsNotesCard({super.key, required this.order});

  final GetOrdersModelDataItem order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.headlineMedium('ملاحظات الطلب', fontWeight: FontWeight.bold),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsetsDirectional.all(12),
            decoration: BoxDecoration(color: Color(0xffFEF3C7), borderRadius: BorderRadius.circular(8)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.person, size: 20, color: Color(0xffD97706)),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.labelSmall('ملاحظات الزبون', color: Color(0xffD97706), fontWeight: FontWeight.bold),
                      SizedBox(height: 4),
                      AppText.bodySmall(
                        order.orderItems == null || order.orderItems!.every((o) => o.specialInstructions == null)
                            ? 'لا يوجد ملاحظات'
                            : order.orderItems!.map((e) => e.specialInstructions ?? '').join(', '),
                        color: Color(0xff92400E),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsetsDirectional.all(12),
            decoration: BoxDecoration(color: Color(0xffF3F4F6), borderRadius: BorderRadius.circular(8)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.restaurant, size: 20, color: Color(0xff6B7280)),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.labelSmall('ملاحظات المطبخ', color: Color(0xff6B7280), fontWeight: FontWeight.bold),
                      SizedBox(height: 4),
                      AppText.bodySmall(order.kitchenNotes ?? 'لا يوجد ملاحطات للمطبخ', color: Color(0xff374151), textAlign: TextAlign.start),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
