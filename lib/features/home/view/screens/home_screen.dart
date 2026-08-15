import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/home/domain/usecases/home_overview_performance_use_case.dart';
import 'package:dllni_resturant_owner_app/features/home/domain/usecases/home_overview_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/seller_permission_access.dart';
import '../../../../core/order_card.dart';
import '../../../orders/domain/usecases/get_orders_use_case.dart';
import '../../../orders/view/manager/bloc/orders_bloc.dart';
import '../manager/bloc/home_bloc.dart';
import '../widgets/engagement_features_cards.dart';
import '../widgets/home_app_bar.dart';
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
    final access = SellerPermissionAccess.current();
    final canManageOrders = access.can(RestaurantPermissionCodes.orders);
    final showQuickActions = access.can(RestaurantPermissionCodes.meals) ||
        access.can(RestaurantPermissionCodes.offersAndCoupons) ||
        access.can(RestaurantPermissionCodes.warehouse) ||
        access.hasFullAccess;

    return MultiBlocProvider(
      providers: [
        BlocProvider<OrdersBloc>(
          create: (context) {
            final bloc = getIt<OrdersBloc>();
            if (canManageOrders) {
              bloc
                ..add(GetOrdersEvent(
                  params: GetOrdersParams(page: 1, status: 'pending'),
                  isReload: true,
                ))
                ..add(GetHomePreparingOrdersEvent(
                  params: GetOrdersParams(page: 1, status: 'preparing'),
                ));
            }
            return bloc;
          },
        ),
        BlocProvider<HomeBloc>(
          lazy: false,
          create: (context) => getIt<HomeBloc>()
            ..add(HomeOverviewEvent(params: HomeOverviewParams()))
            ..add(HomeOverviewPerformanceEvent(
              params: HomeOverviewPerformanceParams(),
            )),
        ),
      ],
      child: SafeArea(
        child: Column(
          children: [
            const HomeAppBar(),
            Expanded(
              child: Builder(
                builder: (context) => RefreshIndicator(
                  onRefresh: () async {
                    context.read<HomeBloc>()
                      ..add(HomeOverviewEvent(params: HomeOverviewParams()))
                      ..add(HomeOverviewPerformanceEvent(
                        params: HomeOverviewPerformanceParams(),
                      ));

                    if (canManageOrders) {
                      context.read<OrdersBloc>()
                        ..add(GetOrdersEvent(
                          params: GetOrdersParams(page: 1, status: 'pending'),
                          isReload: true,
                        ))
                        ..add(GetHomePreparingOrdersEvent(
                          params: GetOrdersParams(page: 1, status: 'preparing'),
                        ));
                    }
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 25),
                        if (canManageOrders) ...[
                          AppText.bodyMedium('نظرة عامة عن اليوم', fontWeight: FontWeight.bold),
                          const SizedBox(height: 12),
                          const TodayOverviewCard(),
                          const SizedBox(height: 12),
                          const StatisticsRow(),
                          const SizedBox(height: 24),
                        ],
                        if (showQuickActions) ...[
                          AppText.bodyMedium('إجراءات سريعة', fontWeight: FontWeight.bold),
                          const SizedBox(height: 12),
                          const QuickActionsRow(),
                          const SizedBox(height: 16),
                        ],
                        if (access.hasFullAccess) ...[
                          const EngagementFeaturesCards(),
                          const SizedBox(height: 24),
                        ],
                        if (canManageOrders) ...[
                          BlocBuilder<OrdersBloc, OrdersState>(
                            builder: (context, state) => Row(
                              children: [
                                AppText.bodyMedium('طلبات جديدة', fontWeight: FontWeight.bold),
                                const SizedBox(width: 8),
                                CircleAvatar(
                                  radius: 13,
                                  backgroundColor: context.error,
                                  child: AppText.labelLarge(
                                    state.orders!.isSuccess ? '${state.orders!.length}' : '0',
                                    color: context.onError,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          BlocBuilder<OrdersBloc, OrdersState>(
                            buildWhen: (previous, current) => previous.orders != current.orders,
                            builder: (context, state) => state.orders!.builder(
                              loadingWidget: const Padding(
                                padding: EdgeInsetsDirectional.only(top: 40),
                                child: Center(child: CircularProgressIndicator.adaptive()),
                              ),
                              emptyWidget: AppText.labelMedium(
                                'لا يوجد طلبات',
                                fontWeight: FontWeight.w400,
                              ),
                              successWidget: () => ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => OrderCard(
                                  order: state.orders!.list[index],
                                  isFromHome: false,
                                  status: OrderStatus.newOrder,
                                  bloc: context.read<OrdersBloc>(),
                                ),
                                separatorBuilder: (context, index) => const SizedBox(height: 16),
                                itemCount: state.orders!.length,
                              ),
                              failedWidget: AppText.labelLarge(
                                state.errorMessage ?? 'حدث خطا ما',
                                color: context.error,
                              ),
                              onTapRetry: () => context.read<OrdersBloc>().add(
                                GetOrdersEvent(
                                  params: GetOrdersParams(page: 1),
                                  isReload: true,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          AppText.bodyMedium('قيد التحضير', fontWeight: FontWeight.bold),
                          const SizedBox(height: 12),
                          const PreparingOrdersCard(),
                          const SizedBox(height: 24),
                          const OrdersHourStatisticsCard(),
                        ],
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
