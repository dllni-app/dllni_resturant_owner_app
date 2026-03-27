import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class DeliveryInfoCard extends StatelessWidget {
  const DeliveryInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.headlineMedium('معلومات التوصيل', fontWeight: FontWeight.bold),
          SizedBox(height: 16),
          Container(
            height: 150,
            decoration: BoxDecoration(color: Color(0xffF3F4F6), borderRadius: BorderRadius.circular(12)),
            child: Center(child: Icon(Icons.map, size: 48, color: Color(0xff9CA3AF))),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildDeliveryInfoBox('المسافة', '3.2 كم', context)),
              SizedBox(width: 12),
              Expanded(child: _buildDeliveryInfoBox('وقت التوصيل', '20-15 دقيقة', context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfoBox(String label, String value, BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(12),
      decoration: BoxDecoration(color: Color(0xffF9FAFB), borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.labelSmall(label, color: Color(0xff6B7280), fontWeight: FontWeight.w500),
          SizedBox(height: 4),
          AppText.bodyMedium(value, color: Color(0xff2F2B3D), fontWeight: FontWeight.w700),
        ],
      ),
    );
  }
}
