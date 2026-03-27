import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/models/home_overview_performance_model.dart';

class PerformanceKpiCards extends StatelessWidget {
  const PerformanceKpiCards({super.key, required this.status, required this.summary, required this.errorMessage});

  final BlocStatus? status;
  final HomeOverviewPerformanceModelSummary? summary;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    Widget buildValue(String text) {
      return AppText.headlineLarge(text, fontWeight: FontWeight.bold, color: const Color(0xff111827));
    }

    Widget buildLoading() {
      return Shimmer.fromColors(
        baseColor: const Color(0xffE5E7EB),
        highlightColor: const Color(0xffF9FAFB),
        child: Container(height: 14, width: 40, color: Colors.white),
      );
    }

    Widget buildError() {
      return AppText.labelMedium(errorMessage ?? 'حدث خطأ ما', color: context.error);
    }

    Widget valueOrState(String value) {
      switch (status) {
        case null:
        case BlocStatus.loading:
        case BlocStatus.init:
          return buildLoading();
        case BlocStatus.failed:
          return buildError();
        case BlocStatus.success:
          return buildValue(value);
      }
    }

    final cards = [
      _KpiCardConfig(
        title: 'إجمالي المبيعات',
        icon: Assets.imagesOverviewMoney,
        backgroundColor: const Color(0xff064E3B).withAlpha(51),
        iconColor: const Color(0xff064E3B),
        valueBuilder: () => valueOrState('${summary?.totalRevenue ?? 0}'),
        subtitle: 'ل.س',
      ),
      _KpiCardConfig(
        title: 'عدد الطلبات',
        icon: Assets.imagesNavBarOrders,
        backgroundColor: const Color(0xffD97706).withAlpha(51),
        iconColor: const Color(0xffD97706),
        valueBuilder: () => valueOrState('${summary?.totalOrders ?? 0}'),
      ),
      _KpiCardConfig(
        title: 'معدل إلغاء الطلبات',
        icon: Icons.close_rounded,
        backgroundColor: const Color(0xffEF4444).withAlpha(51),
        iconColor: const Color(0xffEF4444),
        valueBuilder: () => valueOrState('${summary?.cancellationRatePercent?.toStringAsFixed(1) ?? '0.0'} %'),
      ),
      _KpiCardConfig(
        title: 'متوسط قيمة الطلب',
        icon: Assets.imagesAvgCancelation,
        backgroundColor: const Color(0xff10B981).withAlpha(51),
        iconColor: const Color(0xff10B981),
        valueBuilder: () => valueOrState('${summary?.averageOrderValue ?? 0}'),
        subtitle: 'ل.س',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 180 / 110,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return Container(
          decoration: BoxDecoration(
            color: card.iconColor.withAlpha(25),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: card.iconColor.withAlpha(51), width: 1),
          ),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(color: card.backgroundColor, borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsetsDirectional.all(8),
                    child: card.icon is String ? AppImage.asset(card.icon, color: card.iconColor, size: 18) : Icon(card.icon, color: card.iconColor, size: 18),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: AppText.labelMedium(card.title, fontWeight: FontWeight.w500, color: const Color(0xff4B5563), textAlign: TextAlign.start,),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              card.valueBuilder(),
              /*if (card.subtitle != null) ...[
                const SizedBox(height: 4),
                AppText.labelMedium(card.subtitle!, color: const Color(0xff6B7280), fontWeight: FontWeight.w500),
              ],*/
            ],
          ),
        );
      },
    );
  }
}

class _KpiCardConfig {
  final String title;
  final dynamic icon;
  final Color backgroundColor;
  final Color iconColor;
  final Widget Function() valueBuilder;
  final String? subtitle;

  _KpiCardConfig({
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.valueBuilder,
    this.subtitle,
  });
}
