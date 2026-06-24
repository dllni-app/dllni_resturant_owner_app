import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../data/models/owner_order_details_model.dart';

class DeliveryInfoCard extends StatelessWidget {
  const DeliveryInfoCard({super.key, required this.order});

  final OwnerOrderDetailsData order;

  @override
  Widget build(BuildContext context) {
    final label = order.orderType == 'pickup' ? 'معلومات الاستلام' : 'معلومات التوصيل';
    final mode = order.pickupMode ?? '-';
    final scheduledFor = order.pickupScheduledFor ?? '-';
    return Container(
      padding: const EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.headlineMedium(label, fontWeight: FontWeight.bold),
          const SizedBox(height: 16),
          _box('نوع الطلب', order.orderType == 'pickup' ? 'استلام' : 'توصيل', context),
          const SizedBox(height: 8),
          _box('نمط الطلب', mode, context),
          const SizedBox(height: 8),
          _box('الوقت المجدول', scheduledFor, context),
        ],
      ),
    );
  }

  Widget _box(String label, String value, BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsetsDirectional.all(12),
      decoration: BoxDecoration(color: const Color(0xffF9FAFB), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText.labelSmall(label, color: const Color(0xff6B7280), fontWeight: FontWeight.w500),
          AppText.bodyMedium(value, color: const Color(0xff2F2B3D), fontWeight: FontWeight.w700),
        ],
      ),
    );
  }
}
