import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../data/models/owner_order_details_model.dart';

class OrderDetailsNotesCard extends StatelessWidget {
  const OrderDetailsNotesCard({super.key, required this.order});

  final OwnerOrderDetailsData order;

  @override
  Widget build(BuildContext context) {
    final itemNotes = order.items.map((e) => e.specialInstructions?.trim()).whereType<String>().where((e) => e.isNotEmpty).join('، ');
    return Container(
      padding: const EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.headlineMedium('ملاحظات الطلب', fontWeight: FontWeight.bold),
          const SizedBox(height: 16),
          _note('ملاحظات الزبون', itemNotes.isEmpty ? (order.specialInstructions ?? 'لا يوجد ملاحظات') : itemNotes, const Color(0xffD97706), const Color(0xffFEF3C7)),
          const SizedBox(height: 12),
          _note('ملاحظات المطبخ', order.kitchenNotes ?? 'لا يوجد ملاحظات للمطبخ', const Color(0xff6B7280), const Color(0xffF3F4F6)),
        ],
      ),
    );
  }

  Widget _note(String title, String body, Color color, Color background) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(12),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [AppText.labelSmall(title, color: color, fontWeight: FontWeight.bold), const SizedBox(height: 4), AppText.bodySmall(body, color: color, textAlign: TextAlign.start)]),
    );
  }
}
