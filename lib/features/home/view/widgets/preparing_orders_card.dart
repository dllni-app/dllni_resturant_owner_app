import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/assets.dart';
import '../../../orders/view/manager/bloc/orders_bloc.dart';
import '../../../orders/view/screens/order_details_screen.dart';

class PreparingOrdersCard extends StatelessWidget {
  const PreparingOrdersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: context.onPrimary,
        border: Border.all(color: Color(0xffF3F4F6), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(4),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 18),
      child: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          switch (state.homePreparingOrdersStatus) {
            case null:
              return SizedBox.shrink();
            case BlocStatus.failed:
              return Center(
                child: AppText.labelLarge(
                  state.errorMessage ?? 'حدث خطأ ما',
                  color: context.error,
                ),
              );
            case BlocStatus.success:
              if (state.homePreparingOrders!.data!.isEmpty) {
                return Center(
                  child: AppText.labelLarge(
                    'لا يوجد طلبات قيد التحضير',
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    context.pushRoute(
                      '/orders/details',
                      arguments: OrderDetailsParams(
                        order: state.homePreparingOrders!.data![index],
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xff3B82F6),
                        radius: 4,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: AppText.bodyMedium(
                          'طلب #${state.homePreparingOrders?.data?[index].orderNumber}',
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(width: 8),

                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffF3F4F6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            child: Row(
                              children: [
                                AppImage.asset(
                                  Assets.images.orderClock.path,
                                  color: context.primary,
                                  width: 12,
                                  height: 12,
                                ),
                                SizedBox(width: 4),
                                AppText.labelLarge(
                                  formatMinutesAgo(
                                    DateTime.now()
                                        .difference(
                                          state
                                                      .homePreparingOrders
                                                      ?.data?[index]
                                                      .acceptedAt ==
                                                  null
                                              ? DateTime.now()
                                              : DateTime.parse(
                                                  state
                                                      .homePreparingOrders!
                                                      .data![index]
                                                      .acceptedAt!,
                                                ),
                                        )
                                        .inMinutes,
                                  ),
                                  color: context.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),

                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffF3F4F6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            child: AppText.labelSmall(
                              '${state.homePreparingOrders?.data?[index].orderType}',
                              color: Color(0xff9CA3AF),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 4),
                  child: Divider(thickness: 1, color: Color(0xffF9FAFB)),
                ),
                itemCount: state.homePreparingOrders!.data!.length,
              );
            case BlocStatus.loading:
              return Center(child: CircularProgressIndicator.adaptive());
            case BlocStatus.init:
              return Center(child: CircularProgressIndicator.adaptive());
          }
        },
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
    return hours == 1 ? 'منذ ساعة' : 'منذ $hours ساعات';
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

  return years == 1 ? 'منذ سنة' : 'منذ $years سنوات';
}
