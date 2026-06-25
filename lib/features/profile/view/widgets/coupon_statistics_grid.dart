import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/assets.dart';
import '../manager/bloc/profile_bloc.dart';

class CouponsStatisticsGrid extends StatefulWidget {
  const CouponsStatisticsGrid({super.key});

  @override
  State<CouponsStatisticsGrid> createState() => _CouponsStatisticsGridState();
}

class _CouponsStatisticsGridState extends State<CouponsStatisticsGrid> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;
  late Animation<double> _rotationAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _sizeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _rotationAnimation = Tween<double>(begin: 0.5, end: 0.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.value = 0.0;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final summary = state.couponsSummary?.summary;
        final isLoading = state.couponsSummaryStatus == BlocStatus.loading;
        final hasError = state.couponsSummaryStatus == BlocStatus.failed;

        return Container(
          decoration: BoxDecoration(
            color: context.onPrimary,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(5), offset: const Offset(0, 2), blurRadius: 10)],
          ),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 17, vertical: 17),
          margin: const EdgeInsetsDirectional.symmetric(horizontal: 24),
          child: Column(
            children: [
              InkWell(
                onTap: _toggleExpansion,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: const Color(0xffDBEAFE), borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsetsDirectional.all(10),
                      child: AppImage.asset(Assets.images.offersStatisticsIcon.path, width: 24, height: 24),
                    ),
                    const SizedBox(width: 12),
                    AppText.bodyMedium('الإحصائيات', fontWeight: FontWeight.bold, color: const Color(0xff111827)),
                    const Spacer(),
                    RotationTransition(
                      turns: _rotationAnimation,
                      child: const Icon(Icons.keyboard_arrow_down_outlined, color: Color(0xff9CA3AF), size: 25),
                    ),
                  ],
                ),
              ),
              SizeTransition(
                sizeFactor: _sizeAnimation,
                axisAlignment: -1.0,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    if (isLoading)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: SizedBox(width: 20, height: 20, child: FittedBox(child: CircularProgressIndicator.adaptive())),
                      )
                    else if (hasError)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: AppText.labelMedium('حدث خطأ في تحميل الإحصائيات', color: context.error),
                      )
                    else ...[
                      Row(
                        spacing: 12,
                        children: [
                          Expanded(
                            child: StatePointer(
                              title: 'كوبونات نشطة',
                              value: summary?.activeCount ?? 0,
                              containerBorderColor: const Color(0xff10B981).withAlpha(51),
                              containerColor: const Color(0xff10B981).withAlpha(25),
                              icon: Icons.check_circle,
                              iconCardColor: const Color(0xff10B981).withAlpha(51),
                              iconColor: const Color(0xff10B981),
                            ),
                          ),
                          Expanded(
                            child: StatePointer(
                              title: 'كوبونات منتهية',
                              value: summary?.expiredCount ?? 0,
                              containerBorderColor: const Color(0xffE5E7EB),
                              containerColor: const Color(0xffF3F4F6),
                              icon: Icons.block,
                              iconCardColor: const Color(0xffE5E7EB),
                              iconColor: const Color(0xff6B7280),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        spacing: 12,
                        children: [
                          Expanded(
                            child: StatePointer(
                              title: 'طلبات استخدمت الكوبونات',
                              value: summary?.totalUsageOrders ?? 0,
                              containerBorderColor: const Color(0xff3B82F6).withAlpha(51),
                              containerColor: const Color(0xff3B82F6).withAlpha(25),
                              icon: Icons.shopping_bag_outlined,
                              iconCardColor: const Color(0xff3B82F6).withAlpha(51),
                              iconColor: const Color(0xff2563EB),
                            ),
                          ),
                          Expanded(
                            child: StatePointer(
                              title: 'إجمالي الخصومات (ل.س)',
                              value: summary?.totalSavings ?? 0,
                              containerBorderColor: const Color(0xffF59E0B).withAlpha(51),
                              containerColor: const Color(0xffF59E0B).withAlpha(25),
                              icon: Icons.discount_outlined,
                              iconCardColor: const Color(0xffF59E0B).withAlpha(51),
                              iconColor: const Color(0xffF59E0B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      StatePointer(
                        title: 'أثر الإيرادات (ل.س)',
                        value: summary?.revenueImpact ?? 0,
                        containerBorderColor: const Color(0xff8B5CF6).withAlpha(51),
                        containerColor: const Color(0xff8B5CF6).withAlpha(25),
                        icon: Icons.trending_up_rounded,
                        iconCardColor: const Color(0xff8B5CF6).withAlpha(51),
                        iconColor: const Color(0xff7C3AED),
                      ),
                      if (summary?.topPerforming != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsetsDirectional.all(14),
                          decoration: BoxDecoration(color: const Color(0xffECFDF5), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xff10B981).withAlpha(51))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.labelLarge('أفضل كوبون أداءً', color: const Color(0xff047857), fontWeight: FontWeight.bold, textAlign: TextAlign.start),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(child: AppText.bodyMedium(summary!.topPerforming?.code ?? '-', color: const Color(0xff064E3B), fontWeight: FontWeight.bold, textAlign: TextAlign.start, scrollText: true)),
                                  AppText.labelLarge('${summary.topPerforming?.usedCount ?? 0} استخدام', color: const Color(0xff047857)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class StatePointer extends StatelessWidget {
  const StatePointer({
    super.key,
    required this.title,
    required this.value,
    required this.containerColor,
    required this.containerBorderColor,
    required this.iconCardColor,
    required this.iconColor,
    required this.icon,
  });

  final String title;
  final num value;
  final dynamic icon;
  final Color containerColor;
  final Color containerBorderColor;
  final Color iconCardColor;
  final Color iconColor;

  String _formatValue(num value) {
    if (value % 1 == 0) return value.toInt().toString();
    return value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: containerBorderColor),
        boxShadow: const [BoxShadow(offset: Offset(0, 0), blurRadius: 15, color: Color(0x07000000))],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: iconCardColor),
            padding: const EdgeInsetsDirectional.all(11),
            child: icon is IconData ? Icon(icon, color: iconColor, size: 18) : AppImage.asset(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.displaySmall(_formatValue(value), fontWeight: FontWeight.bold),
                const SizedBox(height: 2),
                AppText.labelMedium(title, color: const Color(0xff4B5563), fontWeight: FontWeight.w500, scrollText: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
