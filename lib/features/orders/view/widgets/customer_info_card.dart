import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/get_orders_model.dart';

class CustomerInfoCard extends StatelessWidget {
  const CustomerInfoCard({super.key, required this.order});

  final GetOrdersModelDataItem order;

  String get _contactValue => (order.user?.email ?? '').trim();

  Future<void> _callCustomer(BuildContext context) async {
    final digits = _contactValue.replaceAll(RegExp(r'[^0-9+]'), '');
    if (digits.length < 6) {
      AppToast.showToast(context: context, message: 'رقم هاتف العميل غير متوفر لهذا الطلب', type: ToastificationType.error);
      return;
    }

    final uri = Uri(scheme: 'tel', path: digits);
    if (!await launchUrl(uri)) {
      AppToast.showToast(context: context, message: 'تعذر فتح تطبيق الاتصال', type: ToastificationType.error);
    }
  }

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
                    AppText.bodyLarge(order.user?.name ?? '-', fontWeight: FontWeight.bold),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.phone, size: 18, color: Color(0xff6B7280)),
                        const SizedBox(width: 8),
                        Expanded(child: AppText.bodyMedium(_contactValue.isEmpty ? '-' : _contactValue, color: const Color(0xff6B7280), textAlign: TextAlign.start, scrollText: true)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on, size: 18, color: Color(0xff6B7280)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: AppText.bodyMedium(
                            'العنوان غير متوفر من بيانات الطلب الحالية',
                            color: const Color(0xff6B7280),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () => _callCustomer(context),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: context.width,
              padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
              decoration: BoxDecoration(color: context.primary, borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone, color: context.onPrimary, size: 20),
                  const SizedBox(width: 8),
                  AppText.labelLarge('اتصال', color: context.onPrimary, fontWeight: FontWeight.bold),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
