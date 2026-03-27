import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';
import '../../data/models/home_overview_performance_model.dart';

class OfferAnalysisSection extends StatelessWidget {
  const OfferAnalysisSection({super.key, required this.status, required this.offersImpact, required this.errorMessage, this.bestOffer});

  final BlocStatus? status;
  final HomeOverviewPerformanceModelOffersImpact? offersImpact;
  final HomeOverviewModelBestOfferPerformance? bestOffer;
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
          return Center(child: AppText.labelMedium(errorMessage ?? 'حدث خطأ ما', color: context.error));
        case BlocStatus.success:
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff064E3B).withAlpha(25),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0xff064E3B).withAlpha(51), width: 1),
                ),
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Color(0xff064E3B).withAlpha(51), borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsetsDirectional.all(10),
                          child: AppImage.asset(Assets.imagesOrderHasOffers, color: Color(0xff064E3B), size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppText.labelMedium(
                                      'طلبات استخدمت عروض',
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff6B7280),
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(height: 4),
                                    AppText.titleMedium('${offersImpact?.discountedOrdersCount ?? 0} طلب', fontWeight: FontWeight.bold, textAlign: TextAlign.start),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppText.labelMedium(
                                      'نسبة الاستفادة',
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff6B7280),
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(height: 4),
                                    AppText.titleMedium('${offersImpact?.conversionRatePercent ?? 0}%', fontWeight: FontWeight.bold, textAlign: TextAlign.start),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12,),
                    LinearProgressIndicator(
                      value: offersImpact?.conversionRatePercent == null ? 0 : offersImpact!.conversionRatePercent! / 100,
                      color: const Color(0xff064E3B),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(99),
                      backgroundColor: context.onPrimary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _OfferRow(
                title: 'إيرادات من العروض',
                value: '${offersImpact?.discountedRevenue ?? 0} ل.س',
                iconColor: const Color(0xff10B981),
                backgroundColor: const Color(0xff10B981).withAlpha(51),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffD97706).withAlpha(25),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xffD97706).withAlpha(51), width: 1),
                ),
                padding: const EdgeInsetsDirectional.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.labelLarge('أفضل عرض أداءً', fontWeight: FontWeight.w500, color: const Color(0xff111827)),
                          const SizedBox(height: 8),
                          AppText.titleSmall(bestOffer?.code ?? '-', fontWeight: FontWeight.bold),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText.labelLarge('استخداماتً', fontWeight: FontWeight.w500, color: const Color(0xff111827)),
                                  const SizedBox(height: 8),
                                  AppText.titleSmall('${bestOffer?.usesCount ?? 0} مرة', fontWeight: FontWeight.bold),
                                ],
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText.labelLarge('إيرادات', fontWeight: FontWeight.w500, color: const Color(0xff111827)),
                                  const SizedBox(height: 8),
                                  AppText.titleSmall('${bestOffer?.revenue ?? 0} ل.س', fontWeight: FontWeight.bold, color: Color(0xffD97706)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Color(0xffD97706).withAlpha(51), borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsetsDirectional.all(8),
                      child: AppImage.asset(Assets.imagesCup, size: 25),
                    ),
                  ],
                ),
              ),
            ],
          );
      }
    }

    return Container(
      decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsetsDirectional.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.bodyMedium('تحليل العروض', fontWeight: FontWeight.bold),
          const SizedBox(height: 12),
          buildBody(),
        ],
      ),
    );
  }
}

class _OfferRow extends StatelessWidget {
  const _OfferRow({required this.title, required this.value, required this.iconColor, required this.backgroundColor});

  final String title;
  final String value;
  final Color iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: iconColor.withAlpha(25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: iconColor.withAlpha(51), width: 1),
      ),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsetsDirectional.all(10),
            child: AppImage.asset(Assets.imagesRevinuDashboard, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.labelMedium(title, fontWeight: FontWeight.w500, color: const Color(0xff6B7280), textAlign: TextAlign.start),
                const SizedBox(height: 4),
                AppText.titleMedium(value, fontWeight: FontWeight.bold, textAlign: TextAlign.start),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
