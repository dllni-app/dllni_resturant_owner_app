import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/home/data/models/home_overview_performance_model.dart';
import 'package:flutter/material.dart';

class DeliveryStatisticsSection extends StatelessWidget {
  const DeliveryStatisticsSection({
    super.key,
    required this.status,
    required this.fulfillment,
    required this.errorMessage,
  });

  final BlocStatus? status;
  final HomeOverviewPerformanceModelFulfillment? fulfillment;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    Widget buildBody() {
      switch (status) {
        case null:
        case BlocStatus.loading:
        case BlocStatus.init:
          return const Center(child: CircularProgressIndicator.adaptive());
        case BlocStatus.failed:
          return Center(
            child: AppText.labelMedium(
              errorMessage ?? 'حدث خطأ ما',
              color: context.error,
            ),
          );
        case BlocStatus.success:
          return Column(
            children: [
              _DeliveryRow(
                title: 'متوسط وقت التحضير',
                value: '${fulfillment?.averagePrepTimeMinutes ?? 0} دقيقة',
                icon: Icons.timer_outlined,
                iconColor: const Color(0xff064E3B),
                backgroundColor: const Color(0xff064E3B).withAlpha(25),
              ),
              const SizedBox(height: 8),
              _DeliveryRow(
                title: 'متوسط وقت التوصيل',
                value: '${fulfillment?.averageReadyToPickupMinutes ?? 0} دقيقة',
                icon: Icons.delivery_dining_rounded,
                iconColor: const Color(0xffF97316),
                backgroundColor: const Color(0xffFFEDD5),
              ),
              const SizedBox(height: 8),
              _DeliveryRow(
                title: 'نسبة الطلبات المتأخرة',
                value: '${fulfillment?.delayedOrdersPercent?.toStringAsFixed(1) ?? '0.0'}٪',
                icon: Icons.hourglass_bottom_rounded,
                iconColor: const Color(0xffEF4444),
                backgroundColor: const Color(0xffFEE2E2),
              ),
              const SizedBox(height: 8),
              _DeliveryRow(
                title: 'طلبات الاستلام من المطعم',
                value: '-',
                icon: Icons.shopping_bag,
                iconColor: const Color(0xff10B981),
                backgroundColor: const Color(0xff10B981).withAlpha(25),
              ),
            ],
          );
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: context.onPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsetsDirectional.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.bodyMedium(
            'إحصائيات التوصيل',
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 12),
          buildBody(),
        ],
      ),
    );
  }
}

class _DeliveryRow extends StatelessWidget {
  const _DeliveryRow({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF9FAFB),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsetsDirectional.all(8),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.labelLarge(
                  title,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                  color: const Color(0xff111827),
                ),
                const SizedBox(height: 8),
                AppText.bodyMedium(
                  value,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff4B5563),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


