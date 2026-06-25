import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_order_details_use_case.dart';
import '../manager/bloc/orders_bloc.dart';
import '../widgets/customer_info_card.dart';
import '../widgets/delivery_info_card.dart';
import '../widgets/order_details_app_bar.dart';
import '../widgets/order_details_edit_card.dart';
import '../widgets/order_details_item_card.dart';
import '../widgets/order_details_notes_card.dart';
import '../widgets/order_details_summary_card.dart';
import '../widgets/order_status_card.dart';

@AutoRoutePage(path: '/orders/details')
class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.params});

  final OrderDetailsParams params;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersBloc>(
      create: (_) => getIt<OrdersBloc>()..add(GetOrderDetailsEvent(params: GetOrderDetailsParams(orderId: params.orderId))),
      child: Scaffold(
        backgroundColor: const Color(0xffF0F0F0),
        body: SafeArea(
          child: BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, state) {
              final order = state.orderDetails?.data;
              return Column(
                children: [
                  OrderDetailsAppBar(id: order?.orderNumber ?? '#${params.orderId}'),
                  const SizedBox(height: 16),
                  Expanded(
                    child: order == null
                        ? _OrderDetailsPlaceholder(state: state, orderId: params.orderId)
                        : RefreshIndicator(
                            onRefresh: () async => context.read<OrdersBloc>().add(GetOrderDetailsEvent(params: GetOrderDetailsParams(orderId: params.orderId))),
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  OrderStatusCard(order: order),
                                  const SizedBox(height: 16),
                                  CustomerInfoCard(order: order),
                                  const SizedBox(height: 16),
                                  DeliveryInfoCard(order: order),
                                  const SizedBox(height: 16),
                                  OrderDetailsItemCard(order: order),
                                  const SizedBox(height: 16),
                                  if (order.canEditItems) ...[
                                    OrderDetailsEditCard(order: order, bloc: context.read<OrdersBloc>()),
                                    const SizedBox(height: 16),
                                  ],
                                  OrderDetailsSummaryCard(order: order),
                                  const SizedBox(height: 16),
                                  OrderDetailsNotesCard(order: order),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _OrderDetailsPlaceholder extends StatelessWidget {
  const _OrderDetailsPlaceholder({required this.state, required this.orderId});

  final OrdersState state;
  final int orderId;

  @override
  Widget build(BuildContext context) {
    if (state.orderDetailsStatus == BlocStatus.loading) return const Center(child: CircularProgressIndicator.adaptive());
    final message = state.errorMessage ?? 'تعذر تحميل تفاصيل الطلب';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.bodyMedium(message, color: context.error, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.read<OrdersBloc>().add(GetOrderDetailsEvent(params: GetOrderDetailsParams(orderId: orderId))),
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderDetailsParams {
  final int orderId;
  OrderDetailsParams({required this.orderId});
}
