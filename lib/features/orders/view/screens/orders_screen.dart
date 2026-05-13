import 'package:common_package/helpers/pagination_helper.dart';
import 'package:common_package/widgets/app_text.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/core/order_card.dart';
import 'package:dllni_resturant_owner_app/features/orders/domain/usecases/get_orders_use_case.dart';
import 'package:dllni_resturant_owner_app/features/orders/view/manager/orders_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/bloc/orders_bloc.dart';
import '../widgets/orders_app_bar.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrdersNotifier ordersNotifier = OrdersNotifier();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersBloc>(
      lazy: false,
      create: (context) => getIt<OrdersBloc>()
        ..add(GetOrdersEvent(params: GetOrdersParams(page: 1), isReload: true)),
      child: SafeArea(
        child: Column(
          children: [
            OrdersAppBar(ordersNotifier: ordersNotifier),
            SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<OrdersBloc, OrdersState>(
                buildWhen: (previous, current) =>
                    previous.orders != current.orders,
                builder: (context, state) {
                  return state.orders!.builder(
                    loadingWidget: Padding(
                      padding: EdgeInsetsDirectional.only(top: 40),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                    emptyWidget: AppText.labelMedium(
                      'لا يوجد طلبات',
                      fontWeight: FontWeight.w400,
                    ),
                    successWidget: () {
                      return ValueListenableBuilder(
                        valueListenable: ordersNotifier.status,
                        builder: (context, status, _) => ListView.separated(
                          padding: EdgeInsetsDirectional.only(
                            start: 24,
                            end: 24,
                            bottom: 20,
                          ),
                          itemBuilder: (context, index) {
                            if (state.orders!.length == index) {
                              if (!state.orders!.isEndPage && state.orders!.status != BlocStatus.loading) {
                                context.read<OrdersBloc>().add(
                                  GetOrdersEvent(
                                    isReload: false,
                                    params: GetOrdersParams(
                                      page: state.orders!.pageNumber,
                                      status: status,
                                    ),
                                  ),
                                );
                              }
                              return SizedBox(
                                width: 30,
                                height: 30,
                                child: FittedBox(
                                  child: CircularProgressIndicator.adaptive(
                                    strokeWidth: 3,
                                  ),
                                ),
                              );
                            }
                            return OrderCard(
                              order: state.orders!.list[index],
                              bloc: context.read<OrdersBloc>(),
                              isFromHome: false,
                              status: state.orders![index].status == 'pending'
                                  ? OrderStatus.newOrder
                                  : state.orders![index].status == 'preparing'
                                  ? OrderStatus.preparingOrder
                                  : state.orders![index].status == 'completed'
                                  ? OrderStatus.completedOrder
                                  : OrderStatus.readyOrder,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16),
                          itemCount: state.orders!.listLength(1),
                        ),
                      );
                    },
                    onTapRetry: () {
                      context.read<OrdersBloc>().add(
                        GetOrdersEvent(
                          params: GetOrdersParams(
                            page: 1,
                            status: 'worker_assigned',
                          ),
                          isReload: true,
                        ),
                      );
                    },
                    failedWidget: AppText.labelLarge(
                      state.errorMessage ?? 'حدث خطا ما',
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
