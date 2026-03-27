import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../data/models/get_orders_model.dart';

class CustomerInfoCard extends StatelessWidget {
  const CustomerInfoCard({super.key, required this.order});

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
              AppText.bodyMedium('معلومات الزبون', fontWeight: FontWeight.bold),
              Container(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: context.primary.withAlpha(25), borderRadius: BorderRadius.circular(20)),
                child: AppText.labelSmall(order.orderType == 'pickup' ? 'توصيل' : 'استلام', color: context.primary, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Color(0xff374151),
                child: Icon(Icons.person, color: Color(0xff9CA3AF)),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.bodyLarge(order.user?.name ?? '-', fontWeight: FontWeight.bold),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 18, color: Color(0xff6B7280)),
                        SizedBox(width: 8),
                        Expanded(child: AppText.bodyMedium(order.user?.email ?? '-', color: Color(0xff6B7280), textAlign: TextAlign.start, scrollText: true,)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on, size: 18, color: Color(0xff6B7280)),
                        SizedBox(width: 8),
                        Expanded(
                          child: AppText.bodyMedium(
                            'حي المحافظة، شارع الملك فيصل، بناية 234، الطابق الثاني',
                            color: Color(0xff6B7280),
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
          SizedBox(height: 16),
          Container(
            width: context.width,
            padding: EdgeInsetsDirectional.symmetric(vertical: 12),
            decoration: BoxDecoration(color: context.primary, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone, color: context.onPrimary, size: 20),
                SizedBox(width: 8),
                AppText.labelLarge('اتصال', color: context.onPrimary, fontWeight: FontWeight.bold),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
