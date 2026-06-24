import 'package:common_package/common_package.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/models/get_orders_model.dart';

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({super.key, required this.order});

  final GetOrdersModelDataItem order;

  @override
  Widget build(BuildContext context) {
    final anchor = _parseDate(order.acceptedAt) ?? _parseDate(order.createdAt) ?? DateTime.now();
    final elapsed = DateTime.now().difference(anchor);
    final elapsedMinutes = elapsed.inMinutes < 0 ? 0 : elapsed.inMinutes;
    final estimatedMinutes = order.estimatedPreparationMinutes ?? 0;
    final pickupTime = _parseDate(order.readyForPickupAt) ?? (estimatedMinutes > 0 ? anchor.add(Duration(minutes: estimatedMinutes)) : null);

    return Container(
      decoration: BoxDecoration(color: const Color(0xffFF7A00), borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          Positioned(top: -75, left: -75, child: CircleAvatar(backgroundColor: context.onPrimary.withAlpha(25), radius: 90)),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: context.onPrimary.withAlpha(51),
                      child: Icon(Icons.access_time_filled, color: context.onPrimary, size: 20),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.labelMedium('الحالة الحالية', color: context.onPrimary, fontWeight: FontWeight.w500),
                          const SizedBox(height: 8),
                          AppText.headlineMedium(order.statusLabelAr ?? order.status ?? '-', color: context.onPrimary, fontWeight: FontWeight.bold),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(color: context.onPrimary.withAlpha(51), borderRadius: BorderRadius.circular(99)),
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 6),
                      child: AppText.labelLarge(_formatTime(anchor), color: context.onPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(child: _buildStatusInfoBox('منذ', formatMinutesAgo(elapsedMinutes), context)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildStatusInfoBox('الوقت المتوقع', estimatedMinutes > 0 ? '$estimatedMinutes د' : '-', context)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildStatusInfoBox('وقت الاستلام', pickupTime == null ? '-' : _formatTime(pickupTime), context)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DateTime? _parseDate(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return DateTime.tryParse(value)?.toLocal();
  }

  String _formatTime(DateTime value) => DateFormat('hh:mm a', 'en').format(value);

  Widget _buildStatusInfoBox(String label, String value, BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
      decoration: BoxDecoration(color: context.onPrimary.withAlpha(51), borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText.labelMedium(label, color: context.onPrimary, fontWeight: FontWeight.w400),
          const SizedBox(height: 4),
          AppText.bodyMedium(value, color: context.onPrimary, fontWeight: FontWeight.bold, maxLines: 1),
        ],
      ),
    );
  }
}
String formatMinutesAgo(int minutes) {
  if (minutes < 1) {
    return 'الآن';
  }

  if (minutes < 60) {
    return 'منذ $minutes ${minutes == 1 ? 'دقيقة' : 'دقائق'}';
  }

  final hours = minutes ~/ 60;
  if (hours < 24) {
    return hours == 1
        ? 'منذ ساعة'
        : 'منذ $hours ساعات';
  }

  final days = hours ~/ 24;

  if (days == 1) {
    return 'أمس';
  }

  if (days < 7) {
    return 'منذ $days أيام';
  }

  final weeks = days ~/ 7;

  if (weeks == 1) {
    return 'منذ أسبوع';
  }

  if (weeks < 4) {
    return 'منذ $weeks أسابيع';
  }

  final months = days ~/ 30;

  if (months == 1) {
    return 'منذ شهر';
  }

  if (months < 12) {
    return 'منذ $months أشهر';
  }

  final years = days ~/ 365;

  return years == 1
      ? 'منذ سنة'
      : 'منذ $years سنوات';
}