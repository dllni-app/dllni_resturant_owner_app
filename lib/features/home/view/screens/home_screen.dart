import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/home/domain/usecases/home_overview_performance_use_case.dart';
import 'package:dllni_resturant_owner_app/features/home/domain/usecases/home_overview_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../orders/domain/usecases/get_orders_use_case.dart';
import '../../../orders/view/manager/bloc/orders_bloc.dart';
import '../manager/bloc/home_bloc.dart';
import '../widgets/home_app_bar.dart';
import '../../../../core/order_card.dart';
import '../widgets/orders_hour_statistics_card.dart';
import '../widgets/preparing_orders_card.dart';
import '../widgets/quick_actions_row.dart';
import '../widgets/statistics_row.dart';
import '../widgets/today_overview_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrdersBloc>(
          create: (context) => getIt<OrdersBloc>()
            ..add(GetOrdersEvent(params: GetOrdersParams(page: 1, status: 'pending'), isReload: true))
            ..add(GetHomePreparingOrdersEvent(params: GetOrdersParams(page: 1, status: 'preparing'))),
        ),
        BlocProvider<HomeBloc>(
          lazy: false,
          create: (context) => getIt<HomeBloc>()
            ..add(HomeOverviewEvent(params: HomeOverviewParams()))
            ..add(HomeOverviewPerformanceEvent(params: HomeOverviewPerformanceParams())),
        ),
      ],
      child: SafeArea(
        child: Column(
          children: [
            HomeAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25),
                    AppText.bodyMedium('نظرة عامة عن اليوم', fontWeight: FontWeight.bold),
                    SizedBox(height: 12),
                    TodayOverviewCard(),
                    SizedBox(height: 12),
                    StatisticsRow(),
                    SizedBox(height: 24),
                    AppText.bodyMedium('إجراءات سريعة', fontWeight: FontWeight.bold),
                    SizedBox(height: 12),
                    QuickActionsRow(),
                    SizedBox(height: 16),
                    BlocBuilder<OrdersBloc, OrdersState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            AppText.bodyMedium('طلبات جديدة', fontWeight: FontWeight.bold),
                            SizedBox(width: 8),
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: context.error,
                              child: AppText.labelLarge(state.orders!.isSuccess ? '${state.orders!.length}' : '0', color: context.onError),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 12),
                    BlocBuilder<OrdersBloc, OrdersState>(
                      buildWhen: (previous, current) => previous.orders != current.orders,
                      builder: (context, state) {
                        return state.orders!.builder(
                          loadingWidget: Padding(
                            padding: EdgeInsetsDirectional.only(top: 40),
                            child: Center(child: CircularProgressIndicator.adaptive()),
                          ),
                          emptyWidget: AppText.labelMedium('لا يوجد طلبات', fontWeight: FontWeight.w400),
                          successWidget: () {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return OrderCard(
                                  order: state.orders!.list[index],
                                  isFromHome: false,
                                  status: OrderStatus.newOrder,
                                  bloc: context.read<OrdersBloc>(),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(height: 16),
                              itemCount: state.orders!.length,
                            );
                          },
                          failedWidget: AppText.labelLarge(state.errorMessage ?? 'حدث خطا ما', color: context.error),
                          onTapRetry: () {
                            context.read<OrdersBloc>().add(GetOrdersEvent(params: GetOrdersParams(page: 1), isReload: true));
                          },
                        );
                      },
                    ),
                    SizedBox(height: 12),
                    AppText.bodyMedium('قيد التحضير', fontWeight: FontWeight.bold),
                    SizedBox(height: 12),
                    PreparingOrdersCard(),
                    SizedBox(height: 24),
                    OrdersHourStatisticsCard(),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
