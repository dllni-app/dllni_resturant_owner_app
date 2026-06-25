import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../data/models/owner_order_details_model.dart';

class CustomerInfoCard extends StatelessWidget {
  const CustomerInfoCard({super.key, required this.order});

  final OwnerOrderDetailsData order;

  @override
  Widget build(BuildContext context) {
    final customer = order.customer;
    final phone = (customer?.phone?.trim().isNotEmpty ?? false) ? customer!.phone!.trim() : (order.customerAddress?.mobile?.trim() ?? '');
    final address = order.customerAddress?.displayText.trim() ?? '';

    return Container(
      padding: const EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.bodyMedium('معلومات الزبون', fontWeight: FontWeight.bold),
              Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: context.primary.withAlpha(25), borderRadius: BorderRadius.circular(20)),
                child: AppText.labelSmall(order.orderType == 'pickup' ? 'استلام' : 'توصيل', color: context.primary, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(radius: 24, backgroundColor: Color(0xff374151), child: Icon(Icons.person, color: Color(0xff9CA3AF))),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.bodyLarge(customer?.name ?? '-', fontWeight: FontWeight.bold),
                    const SizedBox(height: 8),
                    _infoLine(Icons.phone, phone.isEmpty ? '-' : phone),
                    const SizedBox(height: 8),
                    _infoLine(Icons.email, customer?.email ?? '-'),
                    const SizedBox(height: 8),
                    _infoLine(Icons.location_on, address.isEmpty ? 'العنوان غير متوفر من بيانات الطلب الحالية' : address),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoLine(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xff6B7280)),
        const SizedBox(width: 8),
        Expanded(child: AppText.bodyMedium(value, color: const Color(0xff6B7280), textAlign: TextAlign.start, scrollText: true)),
      ],
    );
  }
}
