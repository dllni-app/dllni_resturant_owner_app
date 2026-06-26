import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/orders/data/models/get_orders_model.dart';
import 'package:dllni_resturant_owner_app/features/orders/data/models/owner_order_details_model.dart';
import 'package:flutter/material.dart';

import '../manager/bloc/orders_bloc.dart';
import 'accept_order_bottom_sheet.dart';
import 'order_status_action_bottom_sheet.dart';
import 'reject_order_bottom_sheet.dart';

class OrderDetailsStatusActionsCard extends StatelessWidget {
  const OrderDetailsStatusActionsCard({super.key, required this.order, required this.bloc});

  final OwnerOrderDetailsData order;
  final OrdersBloc bloc;

  @override
  Widget build(BuildContext context) {
    final status = order.status;
    final canChangeStatus = hasRestaurantOrderStatusActions(status);
    final isTerminal = status == 'completed' || status == 'cancelled';

    if (status == 'pending') {
      final listOrder = GetOrdersModelDataItem(id: order.id, orderNumber: order.orderNumber, status: order.status, statusLabelAr: order.statusLabelAr);
      return _ActionShell(
        title: 'إجراءات الطلب',
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => AcceptOrderBottomSheet(order: listOrder, bloc: bloc)),
                child: const Text('قبول الطلب'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => RejectOrderBottomSheet(order: listOrder, bloc: bloc)),
                style: OutlinedButton.styleFrom(foregroundColor: context.error),
                child: const Text('رفض'),
              ),
            ),
          ],
        ),
      );
    }

    if (!canChangeStatus) {
      return _ActionShell(
        title: 'إجراءات الطلب',
        child: Container(
          width: double.infinity,
          padding: const EdgeInsetsDirectional.all(12),
          decoration: BoxDecoration(color: const Color(0xffF3F4F6), borderRadius: BorderRadius.circular(10)),
          child: AppText.bodyMedium(isTerminal ? 'لا توجد إجراءات متاحة بعد اكتمال أو إلغاء الطلب.' : 'لا توجد إجراءات متاحة لهذه الحالة.', textAlign: TextAlign.start),
        ),
      );
    }

    return _ActionShell(
      title: 'إجراءات الطلب',
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => OrderStatusActionBottomSheet.fromDetails(order: order, bloc: bloc),
          ),
          icon: const Icon(Icons.change_circle_outlined),
          label: const Text('تغيير حالة الطلب'),
        ),
      ),
    );
  }
}

class _ActionShell extends StatelessWidget {
  const _ActionShell({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(color: context.onPrimary, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xffE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.bodyMedium(title, fontWeight: FontWeight.bold, textAlign: TextAlign.start),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
