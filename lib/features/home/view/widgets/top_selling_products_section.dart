import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/home/data/models/home_overview_performance_model.dart';
import 'package:flutter/material.dart';

class TopSellingProductsSection extends StatelessWidget {
  const TopSellingProductsSection({super.key, required this.status, required this.products, required this.errorMessage});

  final BlocStatus? status;
  final List<HomeOverviewPerformanceModelTopProductsItem> products;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {

    List<Color> topsColor = [
      Color(0xff064E3B),
      Color(0xffD97706),
      Color(0xff10B981),
    ];

    Widget buildBody() {
      switch (status) {
        case null:
        case BlocStatus.loading:
        case BlocStatus.init:
          return const Center(child: CircularProgressIndicator.adaptive());
        case BlocStatus.failed:
          return Center(child: AppText.labelMedium(errorMessage ?? 'حدث خطأ ما', color: context.error));
        case BlocStatus.success:
          if (products.isEmpty) {
            return Center(child: AppText.labelMedium('لا يوجد بيانات للعرض', color: const Color(0xff9CA3AF)));
          }
          final visible = products.length > 3 ? products.sublist(0, 3) : products;
          return Column(
            children: List.generate(
              visible.length,
              (i) => Container(
                margin: const EdgeInsetsDirectional.only(bottom: 12),
                padding: const EdgeInsetsDirectional.all(12),
                decoration: BoxDecoration(
                  color: Color(0xffF9FAFB),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(color: const Color(0xffF3F4F6), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.fastfood_rounded, color: Color(0xff6B7280)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.labelLarge(visible[i].name ?? '-', fontWeight: FontWeight.w600, color: const Color(0xff111827)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              AppText.labelMedium('${visible[i].quantity ?? 0} طلب', color: const Color(0xff6B7280)),
                              const SizedBox(width: 8),
                              CircleAvatar(radius: 3, backgroundColor: Color(0xff6B7280)),
                              const SizedBox(width: 8),
                              AppText.labelLarge('${visible[i].revenue ?? 0} ل.س', fontWeight: FontWeight.w700, color: const Color(0xff16A34A)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(color: topsColor[i].withAlpha(25), borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 8),
                      child: AppText.labelLarge('${i + 1}', color: topsColor[i],),
                    ),
                  ],
                ),
              ),
            ),
          );
      }
    }

    return Container(
      decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsetsDirectional.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppText.bodyMedium('أكثر المنتجات مبيعاً', fontWeight: FontWeight.bold),
              /*const Spacer(),
              AppText.labelMedium('عرض الكل', color: const Color(0xff064E3B), fontWeight: FontWeight.w600),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xff064E3B)),*/
            ],
          ),
          const SizedBox(height: 12),
          buildBody(),
        ],
      ),
    );
  }
}
