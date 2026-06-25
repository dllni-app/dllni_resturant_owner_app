import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../data/models/owner_order_details_model.dart';

class OrderDetailsItemCard extends StatelessWidget {
  const OrderDetailsItemCard({super.key, required this.order});

  final OwnerOrderDetailsData order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.headlineMedium('تفاصيل الطلب', fontWeight: FontWeight.bold),
              AppText.labelMedium('${order.items.length} منتجات', color: const Color(0xff6B7280)),
            ],
          ),
          const SizedBox(height: 16),
          if (order.items.isEmpty)
            AppText.bodyMedium('لا توجد منتجات مرتبطة بهذا الطلب', color: const Color(0xff6B7280))
          else
            ...order.items.map((item) => _buildOrderItem(context, item)),
        ],
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, OwnerOrderDetailsItem item) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _image(item.imageUrl),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                AppText.bodyMedium(item.name ?? '-', fontWeight: FontWeight.bold),
                const SizedBox(height: 4),
                Container(decoration: BoxDecoration(color: const Color(0xff6B7280).withAlpha(51), borderRadius: BorderRadius.circular(8)), padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 2), child: AppText.labelMedium('x${item.quantity}')),
                if ((item.specialInstructions ?? '').isNotEmpty) ...[const SizedBox(height: 4), AppText.labelSmall(item.specialInstructions!, color: const Color(0xff6B7280), textAlign: TextAlign.start)],
              ]),
            ),
            AppText.bodyMedium('${item.totalPrice.toStringAsFixed(1)} ل.س', fontWeight: FontWeight.bold, color: context.primary),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _image(String? url) {
    final imageUrl = url?.trim();
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 60,
        height: 60,
        color: const Color(0xffF3F4F6),
        child: imageUrl == null || imageUrl.isEmpty
            ? const Icon(Icons.fastfood, color: Color(0xff9CA3AF))
            : Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, color: Color(0xff9CA3AF)),
              ),
      ),
    );
  }
}
