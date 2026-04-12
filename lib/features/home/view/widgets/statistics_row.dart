import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../generated/assets.dart';
import '../manager/bloc/home_bloc.dart';

class StatisticsRow extends StatelessWidget {
  const StatisticsRow({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [Color(0xff3B82F6), Color(0xffF97316), Color(0xff22C55E)];
    List<String> titles = ['طلبات جديدة', 'طلبات مؤكدة', 'طلبات مكتملة'];
    List<String> images = [Assets.images.homeNewOrdersIcon.path, Assets.images.homeConfirmedOrdersIcon.path, Assets.images.homeCompletedOrdersIcon.path];

    return Row(
      spacing: 24,
      children: List.generate(
        3,
        (i) => Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border(bottom: BorderSide(color: colors[i], width: 2)),
              color: context.onPrimary,
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(63), offset: Offset(0, 2), blurRadius: 4)],
            ),
            padding: EdgeInsetsDirectional.symmetric(vertical: 14),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: colors[i].withAlpha(51),
                  child: AppImage.asset(images[i], size: 15, color: colors[i]),
                ),
                SizedBox(height: 14),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    switch (state.homeOverviewStatus) {
                      case null:
                        return Shimmer.fromColors(
                          baseColor: context.onPrimary,
                          highlightColor: context.primary,
                          child: Container(color: context.surface, height: 20, width: 20),
                        );
                      case BlocStatus.failed:
                        return CircleAvatar(radius: 15, backgroundColor: context.surface, child: AppText.labelMedium('0'));
                      case BlocStatus.success:
                        final value = i == 0
                            ? state.homeOverview?.kpis?.ordersByStatus?.pending
                            : i == 1
                            ? state.homeOverview?.kpis?.ordersByStatus?.accepted
                            : state.homeOverview?.kpis?.ordersByStatus?.completed;
                        return AppText.labelLarge('${value ?? 0}');
                      case BlocStatus.loading:
                        return Shimmer.fromColors(
                          baseColor: context.onPrimary,
                          highlightColor: context.primary,
                          child: Container(color: context.surface, height: 20, width: 20),
                        );
                      case BlocStatus.init:
                        return Shimmer.fromColors(
                          baseColor: context.onPrimary,
                          highlightColor: context.primary,
                          child: Container(color: context.surface, height: 20, width: 20),
                        );
                    }
                  },
                ),
                SizedBox(height: 14),
                AppText.labelMedium(titles[i], fontWeight: FontWeight.w500),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
