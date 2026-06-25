import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../data/models/get_orders_model.dart';

class OrderDetailsItemCard extends StatelessWidget {
  const OrderDetailsItemCard({super.key, required this.order});

  final GetOrdersModelDataItem order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.headlineMedium('تفاصيل الطلب', fontWeight: FontWeight.bold),
              AppText.labelMedium('${order.orderItems?.length ?? 0} منتجات', color: Color(0xff6B7280)),
            ],
          ),
          SizedBox(height: 16),
          ...List.generate(
            order.orderItems?.length ?? 0,
            (index) => _buildOrderItem(
              context,
              order.orderItems?[index].product?.name ?? '-',
              order.orderItems?[index].totalPrice == null ? '0' : order.orderItems![index].totalPrice.toString(),
              order.orderItems?[index].quantity == null ? '0' : order.orderItems![index].quantity.toString(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, String name, String price, String quantity) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(color: Color(0xffF3F4F6), borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.fastfood, color: Color(0xff9CA3AF)),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.bodyMedium(name, fontWeight: FontWeight.bold),
                  SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(color: Color(0xff6B7280).withAlpha(51), borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 2),
                    child: AppText.labelMedium('x$quantity'),
                  ),

                ],
              ),
            ),
            AppText.bodyMedium('$price ل.س', fontWeight: FontWeight.bold, color: context.primary),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
