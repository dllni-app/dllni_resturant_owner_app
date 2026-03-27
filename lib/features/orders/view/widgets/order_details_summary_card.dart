import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../data/models/get_orders_model.dart';

class OrderDetailsSummaryCard extends StatelessWidget {
  const OrderDetailsSummaryCard({super.key, required this.order});

  final GetOrdersModelDataItem order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.bodyMedium('ملخص الدفع', fontWeight: FontWeight.bold),
          SizedBox(height: 16),
          _buildPaymentRow('تكلفة المنتجات', '${order.subtotal} ل.س', context),
          SizedBox(height: 8),
          _buildPaymentRow('رسوم التوصيل', '${order.taxAmount} ل.س', context),
          SizedBox(height: 8),
          _buildPaymentRow('رسوم الخدمة', '${order.serviceFee} ل.س', context),
          SizedBox(height: 8),
          _buildPaymentRow('الخصم', '${order.discountAmount} ل.س', context, isDiscount: true),
          SizedBox(height: 12),
          Divider(color: Color(0xffE5E7EB)),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.titleMedium('الإجمالي', fontWeight: FontWeight.bold),
              AppText.titleMedium('${order.totalAmount} ل.س', fontWeight: FontWeight.bold, color: context.primary),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: Color(0xff24B364).withAlpha(25), borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.money, size: 16, color: Color(0xff24B364)),
                SizedBox(width: 6),
                AppText.labelSmall('نقداً عند الاستلام', color: Color(0xff24B364), fontWeight: FontWeight.bold),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value, BuildContext context, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.bodyMedium(label, color: Color(0xff6B7280), fontWeight: FontWeight.w400,),
        AppText.bodyMedium(value, color: isDiscount ? Color(0xff24B364) : Color(0xff2F2B3D), fontWeight: FontWeight.bold),
      ],
    );
  }

}
