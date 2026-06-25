import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../data/models/owner_order_details_model.dart';

class OrderDetailsSummaryCard extends StatelessWidget {
  const OrderDetailsSummaryCard({super.key, required this.order});

  final OwnerOrderDetailsData order;

  @override
  Widget build(BuildContext context) {
    final amounts = order.amounts;
    return Container(
      padding: const EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.bodyMedium('ملخص الدفع', fontWeight: FontWeight.bold),
          const SizedBox(height: 16),
          _row('تكلفة المنتجات', amounts.subtotal, context),
          const SizedBox(height: 8),
          _row('الضريبة', amounts.tax, context),
          const SizedBox(height: 8),
          _row('رسوم الخدمة', amounts.serviceFee, context),
          const SizedBox(height: 8),
          _row('الخصم', amounts.discount, context, isDiscount: true),
          const SizedBox(height: 12),
          const Divider(color: Color(0xffE5E7EB)),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [AppText.titleMedium('الإجمالي', fontWeight: FontWeight.bold), AppText.titleMedium('${amounts.total.toStringAsFixed(0)} ل.س', fontWeight: FontWeight.bold, color: context.primary)]),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: const Color(0xff24B364).withAlpha(25), borderRadius: BorderRadius.circular(20)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.money, size: 16, color: Color(0xff24B364)), const SizedBox(width: 6), AppText.labelSmall('نقداً عند الاستلام', color: const Color(0xff24B364), fontWeight: FontWeight.bold)]),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, double value, BuildContext context, {bool isDiscount = false}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [AppText.bodyMedium(label, color: const Color(0xff6B7280), fontWeight: FontWeight.w400), AppText.bodyMedium('${value.toStringAsFixed(0)} ل.س', color: isDiscount ? const Color(0xff24B364) : const Color(0xff2F2B3D), fontWeight: FontWeight.bold)]);
  }
}
