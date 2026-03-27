import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../generated/assets.dart';
import '../manager/bloc/home_bloc.dart';

class TodayOverviewCard extends StatelessWidget {
  const TodayOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [context.primary, context.primary.withAlpha(127)],
          stops: [.8, 1],
          begin: AlignmentGeometry.bottomLeft,
          end: AlignmentGeometry.topRight,
        ),
      ),
      width: context.width,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.labelLarge('إجمالي الايرادات', color: context.onPrimary, fontWeight: FontWeight.w400),
                SizedBox(height: 14),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    switch (state.homeOverviewPerformanceStatus) {
                      case null:
                        return Shimmer.fromColors(
                          baseColor: context.onPrimary,
                          highlightColor: context.primary,
                          child: Container(color: context.surface, height: 10, width: 100),
                        );
                      case BlocStatus.failed:
                        return AppText.labelMedium(state.errorMessage!, color: context.error);
                      case BlocStatus.success:
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            AppText.displaySmall(
                              '${state.homeOverviewPerformance?.summary?.totalRevenue}',
                              color: context.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(width: 14),
                            AppText.bodyMedium('ل.س', color: Color(0xffFACC15), fontWeight: FontWeight.w500),
                          ],
                        );
                      case BlocStatus.loading:
                        return Shimmer.fromColors(
                          baseColor: context.onPrimary,
                          highlightColor: context.primary,
                          child: Container(color: context.surface, height: 10, width: 100),
                        );
                      case BlocStatus.init:
                        return Shimmer.fromColors(
                          baseColor: context.onPrimary,
                          highlightColor: context.primary,
                          child: Container(color: context.surface, height: 10, width: 100),
                        );
                    }
                  },
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Color(0xff22C55E).withAlpha(51), borderRadius: BorderRadius.circular(16)),
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 3),
                      child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          return Row(
                            children: [
                              AppImage.asset(Assets.imagesTodayCardArrow, width: 13),
                              SizedBox(width: 4),
                              AppText.labelSmall(
                                '${state.homeOverview?.kpis?.salesChangePercent ?? 0}%',
                                color: Color(0xff22C55E),
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 6),
                    AppText.labelSmall('مقارنة بالأمس', color: Color(0xffFFEEFF), fontWeight: FontWeight.w400),
                  ],
                ),
              ],
            ),
          ),
          AppImage.asset(Assets.imagesHomeEarningIcon, size: 60),
        ],
      ),
    );
  }
}
