import 'package:common_package/common_package.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/models/get_orders_model.dart';

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({super.key, required this.order});

  final GetOrdersModelDataItem order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xffFF7A00), borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          Positioned(top: -75, left: -75, child: CircleAvatar(backgroundColor: context.onPrimary.withAlpha(25), radius: 90)),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: context.onPrimary.withAlpha(51),
                      child: Icon(Icons.access_time_filled, color: context.onPrimary, size: 20),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.labelMedium('الحالة الحالية', color: context.onPrimary, fontWeight: FontWeight.w500),
                          SizedBox(height: 8),
                          AppText.headlineMedium(order.statusLabelAr!, color: context.onPrimary, fontWeight: FontWeight.bold),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(color: context.onPrimary.withAlpha(51), borderRadius: BorderRadius.circular(99)),
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 6),
                      child: AppText.labelLarge(
                        order.acceptedAt == null ? '0' : DateFormat('hh:mm a').format(DateTime.parse(order.acceptedAt!)).toString(),
                        color: context.onPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  spacing: 8,
                  children: [
                    Expanded(child: _buildStatusInfoBox('منذ', '${DateTime.parse(order.acceptedAt!).difference(DateTime.now()).inMinutes} دقيقة', context)),
                    Expanded(child: _buildStatusInfoBox('الوقت المتوقع', '199', context)),
                    Expanded(
                      child: _buildStatusInfoBox(
                        'وقت الاستلام',
                        order.acceptedAt == null ? '0' : DateFormat('hh:mm a').format(DateTime.parse(order.acceptedAt!)).toString(),
                        context,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusInfoBox(String label, String value, BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(vertical: 10),
      decoration: BoxDecoration(color: context.onPrimary.withAlpha(51), borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText.labelMedium(label, color: context.onPrimary, fontWeight: FontWeight.w400),
          SizedBox(height: 4),
          AppText.bodyMedium(value, color: context.onPrimary, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
}
