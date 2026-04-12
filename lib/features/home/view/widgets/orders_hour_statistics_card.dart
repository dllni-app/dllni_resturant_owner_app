import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/assets.dart';
import '../manager/bloc/home_bloc.dart';

class OrdersHourStatisticsCard extends StatelessWidget {
  const OrdersHourStatisticsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: context.onPrimary,
        border: Border.all(color: Color(0xffF3F4F6), width: 1),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(4), offset: Offset(0, 2), blurRadius: 10)],
      ),
      padding: EdgeInsetsDirectional.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.bodyLarge('نشاط الطلبات (ساعات)', fontWeight: FontWeight.bold),
              AppImage.asset(Assets.images.statisticsIcon.path, width: 18, height: 18),
            ],
          ),
          SizedBox(height: 24),
          SizedBox(
            height: 220,
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                switch (state.homeOverviewStatus) {
                  case null:
                    return Center(child: CircularProgressIndicator.adaptive());
                  case BlocStatus.failed:
                    return Center(child: AppText.labelMedium(state.errorMessage ?? 'حدث حطا ما', color: context.error));
                  case BlocStatus.success:
                    final chartWidth = state.homeOverview!.kpis!.orderActivityByHour!.length * 40.0;

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: chartWidth,
                        child: BarChart(
                          BarChartData(
                            maxY: 210,
                            minY: 0,
                            barTouchData: BarTouchData(enabled: false),
                            titlesData: FlTitlesData(
                              show: true,
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 30,
                                  getTitlesWidget: (value, meta) {
                                    final index = value.toInt();
                                    if (index >= 0 && index < state.homeOverview!.kpis!.orderActivityByHour!.length) {
                                      return Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: AppText.labelMedium(
                                          '${state.homeOverview!.kpis!.orderActivityByHour![index].hour}',
                                          color: Color(0xff6B7280),
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  interval: 50,
                                  getTitlesWidget: (value, meta) {
                                    if (value == meta.min || value == meta.max) {
                                      return const SizedBox();
                                    }
                                    return AppText.labelSmall(value.toInt().toString(), color: Color(0xff9CA3AF));
                                  },
                                ),
                              ),
                            ),
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              horizontalInterval: 10,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(color: Color(0xffF3F4F6), strokeWidth: 1);
                              },
                            ),
                            borderData: FlBorderData(show: false),
                            barGroups: List.generate(
                              state.homeOverview!.kpis!.orderActivityByHour!.length,
                              (index) => BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    toY: state.homeOverview!.kpis!.orderActivityByHour![index].count!.toDouble(),
                                    width: 24,
                                    color: state.homeOverview!.kpis!.orderActivityByHour![index].hour == 12 ? context.secondary : context.primary,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                                  ),
                                ],
                                barsSpace: 8,
                              ),
                            ),
                            alignment: BarChartAlignment.start,
                          ),
                        ),
                      ),
                    );
                  case BlocStatus.loading:
                    return Center(child: CircularProgressIndicator.adaptive());
                  case BlocStatus.init:
                    return Center(child: CircularProgressIndicator.adaptive());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
