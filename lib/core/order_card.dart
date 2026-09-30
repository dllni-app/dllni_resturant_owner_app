import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/orders/view/screens/order_details_screen.dart';
import 'package:flutter/material.dart';

import '../features/orders/data/models/get_orders_model.dart';
import '../features/orders/view/manager/bloc/orders_bloc.dart';
import '../features/orders/view/widgets/accept_order_bottom_sheet.dart';
import '../features/orders/view/widgets/order_status_action_bottom_sheet.dart';
import '../features/orders/view/widgets/reject_order_bottom_sheet.dart';
import '../generated/assets.dart';

enum OrderStatus { newOrder, preparingOrder, readyOrder, completedOrder, cancelledOrder }

class OrderCard extends StatefulWidget {
  const OrderCard({super.key, required this.isFromHome, required this.status, required this.order, required this.bloc});

  final bool isFromHome;
  final OrderStatus status;
  final GetOrdersModelDataItem order;
  final OrdersBloc bloc;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  Color color(OrderStatus status) {
    switch (status) {
      case OrderStatus.newOrder:
        return const Color(0xff1E2A78);
      case OrderStatus.preparingOrder:
        return const Color(0xffFF7A00);
      case OrderStatus.readyOrder:
        return const Color(0xff24B364);
      case OrderStatus.completedOrder:
        return Colors.grey.shade600;
      case OrderStatus.cancelledOrder:
        return Colors.red.shade600;
    }
  }

  Widget icon(OrderStatus status, Color color) {
    switch (status) {
      case OrderStatus.newOrder:
        return const Icon(Icons.notifications_active_rounded, size: 16, color: Colors.white);
      case OrderStatus.preparingOrder:
        return AppImage.asset(Assets.images.readyOrderIcon.path, size: 13);
      case OrderStatus.readyOrder:
        return Icon(Icons.check_circle, size: 14, color: color);
      case OrderStatus.completedOrder:
        return Icon(Icons.done_all, size: 14, color: color);
      case OrderStatus.cancelledOrder:
        return Icon(Icons.cancel, size: 14, color: color);
    }
  }

  String relativeTime() {
    final raw = widget.order.acceptedAt ?? widget.order.createdAt;
    final parsed = raw == null ? null : DateTime.tryParse(raw)?.toLocal();
    if (parsed == null) return '';
    final minutes = DateTime.now().difference(parsed).inMinutes;
    if (minutes < 1) return 'الآن';
    if (minutes < 60) return 'منذ $minutes دقيقة';
    final hours = minutes ~/ 60;
    if (hours < 24) return 'منذ $hours ساعة';
    return 'منذ ${hours ~/ 24} يوم';
  }

  String productsText() {
    final names = (widget.order.orderItems ?? []).map((item) => item.product?.name?.trim()).whereType<String>().where((name) => name.isNotEmpty).toList();
    return names.isEmpty ? 'لا توجد منتجات مرتبطة' : names.join('، ');
  }

  String deliveryLabel() {
    final type = (widget.order.orderType ?? '').toLowerCase().trim();
    return type == 'delivery' ? 'توصيل' : 'استلام من المطعم';
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.order.totalAmount ?? 0;
    final statusColor = color(widget.status);
    final isNew = widget.status == OrderStatus.newOrder || widget.order.status == 'pending';
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: isNew ? const Color(0xff1E2A78) : const Color(0xffE5E7EB), width: isNew ? 2 : 1),
      ),
      elevation: isNew ? 5 : 2,
      child: InkWell(
        onTap: widget.order.id == null ? null : () => context.pushRoute('/orders/details', arguments: OrderDetailsParams(orderId: widget.order.id!)),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isNew ? const Color(0xffF3F5FF) : Colors.white,
            border: Border(right: BorderSide(color: statusColor, width: isNew ? 8 : 6)),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (isNew) ...[
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(color: const Color(0xff1E2A78), borderRadius: BorderRadius.circular(20)),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.notifications_active_rounded, size: 15, color: Colors.white),
                          SizedBox(width: 6),
                          Text('طلب جديد', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    AppText.labelMedium(relativeTime(), color: const Color(0xff1E2A78), fontWeight: FontWeight.w700),
                  ],
                ),
                const SizedBox(height: 12),
              ],
              Row(children: [
                Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.all(10), child: Icon(Icons.person, color: context.primary)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [AppText.bodyMedium(widget.order.user?.name ?? 'عميل المطعم', fontWeight: FontWeight.bold), const SizedBox(height: 4), AppText.labelMedium('#${widget.order.orderNumber ?? widget.order.id ?? '-'}'), if (!isNew) AppText.labelMedium(relativeTime().isEmpty ? '' : '• ${relativeTime()}')])) ,
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [AppText.labelLarge('${total.toStringAsFixed(0)} ل.س', color: context.primary, fontWeight: FontWeight.bold), const SizedBox(height: 4), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)), child: AppText.labelSmall('نقدي', fontWeight: FontWeight.w600))]),
              ]),
              const Divider(height: 24),
              Container(width: double.infinity, padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.85), borderRadius: BorderRadius.circular(8)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [AppText.labelLarge(productsText(), maxLines: 2, overflow: TextOverflow.ellipsis), const SizedBox(height: 8), Row(children: [Icon(deliveryLabel() == 'توصيل' ? Icons.delivery_dining_rounded : Icons.storefront_rounded, size: 17, color: statusColor), const SizedBox(width: 6), AppText.labelLarge(deliveryLabel(), fontWeight: FontWeight.bold, color: statusColor)])])),
              if (!widget.isFromHome) ...[const SizedBox(height: 12), Align(alignment: Alignment.centerRight, child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)), child: Row(mainAxisSize: MainAxisSize.min, children: [icon(widget.status, statusColor), const SizedBox(width: 6), AppText.labelSmall(widget.order.statusLabelAr ?? widget.order.status ?? '-', color: statusColor, fontWeight: FontWeight.bold)])))],
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    if (widget.order.id == null) return const SizedBox.shrink();

    if (widget.order.status == 'pending') {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          children: [
            Expanded(child: ElevatedButton(onPressed: () => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => AcceptOrderBottomSheet(order: widget.order, bloc: widget.bloc)), child: const Text('قبول الطلب'))),
            const SizedBox(width: 12),
            Expanded(child: OutlinedButton(onPressed: () => showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => RejectOrderBottomSheet(order: widget.order, bloc: widget.bloc)), style: OutlinedButton.styleFrom(foregroundColor: context.error), child: const Text('رفض'))),
          ],
        ),
      );
    }

    if (!hasRestaurantOrderStatusActions(widget.order.status, orderType: widget.order.orderType)) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => OrderStatusActionBottomSheet.fromList(order: widget.order, bloc: widget.bloc),
          ),
          icon: const Icon(Icons.change_circle_outlined),
          label: const Text('تغيير حالة الطلب'),
        ),
      ),
    );
  }
}