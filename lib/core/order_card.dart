import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/orders/view/screens/order_details_screen.dart';
import 'package:flutter/material.dart';

import '../features/orders/data/models/get_orders_model.dart';
import '../features/orders/view/manager/bloc/orders_bloc.dart';
import '../features/orders/view/widgets/accept_order_bottom_sheet.dart';
import '../features/orders/view/widgets/reject_order_bottom_sheet.dart';
import '../generated/assets.dart';

enum OrderStatus { newOrder, preparingOrder, readyOrder, completedOrder }

// class OrderCard extends StatefulWidget {
//   const OrderCard({super.key, required this.isFromHome, required this.status, required this.order, required this.bloc});
//
//   final bool isFromHome;
//   final OrderStatus status;
//   final GetOrdersModelDataItem order;
//   final OrdersBloc bloc;
//
//   @override
//   State<OrderCard> createState() => _OrderCardState();
// }
//
// class _OrderCardState extends State<OrderCard> {
//   Color orderStatusColor(OrderStatus status) {
//     switch (status) {
//       case OrderStatus.newOrder:
//         return const Color(0xff1E2A78);
//       case OrderStatus.preparingOrder:
//         return const Color(0xffFF7A00);
//       case OrderStatus.readyOrder:
//       case OrderStatus.completedOrder:
//         return const Color(0xff24B364);
//     }
//   }
//
//   Widget orderStatusWidget(OrderStatus status, Color color) {
//     switch (status) {
//       case OrderStatus.newOrder:
//         return CircleAvatar(radius: 4, backgroundColor: color);
//       case OrderStatus.preparingOrder:
//         return AppImage.asset(Assets.images.readyOrderIcon.path, size: 13);
//       case OrderStatus.readyOrder:
//         return Icon(Icons.check_circle, size: 10, color: color);
//       case OrderStatus.completedOrder:
//         return const SizedBox.shrink();
//     }
//   }
//
//   String _relativeTime() {
//     final raw = widget.order.acceptedAt ?? widget.order.createdAt;
//     final parsed = raw == null ? null : DateTime.tryParse(raw)?.toLocal();
//     if (parsed == null) return '';
//     final diff = DateTime.now().difference(parsed);
//     final minutes = diff.inMinutes < 0 ? 0 : diff.inMinutes;
//     if (minutes < 1) return 'الآن';
//     if (minutes < 60) return 'منذ $minutes دقيقة';
//     final hours = diff.inHours;
//     if (hours < 24) return 'منذ $hours ساعة';
//     return 'منذ ${diff.inDays} يوم';
//   }
//
//   String _productsText() {
//     final items = widget.order.orderItems ?? [];
//     final names = items.map((item) => item.product?.name?.trim()).whereType<String>().where((name) => name.isNotEmpty).toList();
//     if (names.isEmpty) return 'لا توجد منتجات مرتبطة بهذا الطلب';
//     return names.join('، ');
//   }
//
//   String _deliveryLabel() {
//     final type = widget.order.orderType;
//     final mode = widget.order.pickupMode;
//     if (type == 'pickup' || mode == 'immediate_pickup' || mode == 'scheduled_pickup') return 'استلام';
//     return 'توصيل';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final total = widget.order.totalAmount ?? 0;
//     final relative = _relativeTime();
//
//     return InkWell(
//       onTap: () {
//         context.pushRoute('/orders/details', arguments: OrderDetailsParams(order: widget.order));
//       },
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         decoration: BoxDecoration(
//           color: context.onPrimary,
//           border: Border(right: BorderSide(color: context.primaryContainer, width: 5)),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Stack(
//           children: [
//             Padding(
//               padding: EdgeInsetsDirectional.only(start: 16, end: 16, top: widget.isFromHome ? 16 : 30, bottom: 16),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color(0xff374151)),
//                         padding: const EdgeInsetsDirectional.all(12),
//                         child: const Icon(Icons.person, color: Color(0xff9CA3AF)),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             AppText.bodyMedium(widget.order.user?.name ?? 'عميل المطعم', color: const Color(0xff2F2B3D), fontWeight: FontWeight.bold, maxLines: 1),
//                             AppText.labelMedium(
//                               '#${widget.order.orderNumber ?? widget.order.id ?? '-'}${relative.isEmpty ? '' : ' • $relative'}',
//                               color: const Color(0xff2F2B3D).withAlpha(153),
//                               fontWeight: FontWeight.w500,
//                               maxLines: 1,
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Column(
//                         children: [
//                           AppText.labelLarge('${total.toStringAsFixed(total % 1 == 0 ? 0 : 2)} ل.س', color: context.primary, fontWeight: FontWeight.bold),
//                           const SizedBox(height: 4),
//                           Container(
//                             decoration: BoxDecoration(color: context.primaryContainer, borderRadius: BorderRadius.circular(8)),
//                             padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 8),
//                             child: AppText.labelSmall('نقدي', color: context.onPrimaryContainer, fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Container(
//                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xff2F2B3D).withAlpha(31)),
//                     padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 8),
//                     width: context.width,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         AppText.labelLarge(
//                           _productsText(),
//                           color: const Color(0xff2F2B3D).withAlpha(230),
//                           fontWeight: FontWeight.w400,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.start,
//                         ),
//                         Divider(color: const Color(0xff2F2B3D).withAlpha(21), endIndent: 8, indent: 8, thickness: 1),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             AppImage.asset(Assets.images.motor.path, size: 18),
//                             const SizedBox(width: 4),
//                             Expanded(
//                               child: AppText.labelLarge(
//                                 _deliveryLabel(),
//                                 color: const Color(0xff2F2B3D).withAlpha(153),
//                                 fontWeight: FontWeight.bold,
//                                 maxLines: 1,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   if (widget.order.status == 'pending') ...[
//                     const SizedBox(height: 12),
//                     Row(
//                       children: [
//                         Expanded(
//                           flex: 5,
//                           child: InkWell(
//                             onTap: () async {
//                               await showModalBottomSheet(
//                                 context: context,
//                                 isScrollControlled: true,
//                                 backgroundColor: Colors.transparent,
//                                 enableDrag: true,
//                                 builder: (context) => AcceptOrderBottomSheet(order: widget.order, bloc: widget.bloc),
//                               );
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: context.primary),
//                               padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 8),
//                               child: AppText.labelLarge('قبول الطلب', color: context.onPrimary, fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           flex: 2,
//                           child: InkWell(
//                             onTap: () async {
//                               await showModalBottomSheet(
//                                 context: context,
//                                 isScrollControlled: true,
//                                 backgroundColor: Colors.transparent,
//                                 builder: (context) => RejectOrderBottomSheet(order: widget.order, bloc: widget.bloc),
//                               );
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 color: context.error.withAlpha(50),
//                                 border: Border.all(color: context.error),
//                               ),
//                               padding: const EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 8),
//                               child: AppText.labelLarge('رفض', color: context.error, fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//             if (!widget.isFromHome)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), bottomRight: Radius.circular(10)),
//                       color: orderStatusColor(widget.status).withAlpha(51),
//                     ),
//                     padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 8),
//                     child: Row(
//                       children: [
//                         orderStatusWidget(widget.status, orderStatusColor(widget.status)),
//                         const SizedBox(width: 4),
//                         AppText.labelSmall(
//                           widget.order.statusLabelAr ?? widget.order.status ?? '-',
//                           fontWeight: FontWeight.bold,
//                           color: orderStatusColor(widget.status),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class OrderCard extends StatefulWidget {
  const OrderCard({
    super.key,
    required this.isFromHome,
    required this.status,
    required this.order,
    required this.bloc,
  });

  final bool isFromHome;
  final OrderStatus status;
  final GetOrdersModelDataItem order;
  final OrdersBloc bloc;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  // --- منطق الألوان لكل حالة ---
  Color _orderStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.newOrder: return const Color(0xff1E2A78);
      case OrderStatus.preparingOrder: return const Color(0xffFF7A00);
      case OrderStatus.readyOrder: return const Color(0xff24B364);
      case OrderStatus.completedOrder: return Colors.grey.shade600;
    }
  }

  // --- منطق الأيقونات لكل حالة ---
  Widget _orderStatusWidget(OrderStatus status, Color color) {
    switch (status) {
      case OrderStatus.newOrder: return CircleAvatar(radius: 4, backgroundColor: color);
      case OrderStatus.preparingOrder: return AppImage.asset(Assets.images.readyOrderIcon.path, size: 13);
      case OrderStatus.readyOrder: return Icon(Icons.check_circle, size: 14, color: color);
      case OrderStatus.completedOrder: return Icon(Icons.done_all, size: 14, color: color);
    }
  }

  // --- منطق الوقت النسبي ---
  String _relativeTime() {
    final raw = widget.order.acceptedAt ?? widget.order.createdAt;
    final parsed = raw == null ? null : DateTime.tryParse(raw)?.toLocal();
    if (parsed == null) return '';
    final diff = DateTime.now().difference(parsed);
    final minutes = diff.inMinutes < 0 ? 0 : diff.inMinutes;
    if (minutes < 1) return 'الآن';
    if (minutes < 60) return 'منذ $minutes دقيقة';
    final hours = diff.inHours;
    if (hours < 24) return 'منذ $hours ساعة';
    return 'منذ ${diff.inDays} يوم';
  }

  // --- منطق عرض المنتجات ---
  String _productsText() {
    final items = widget.order.orderItems ?? [];
    final names = items.map((item) => item.product?.name?.trim()).whereType<String>().where((name) => name.isNotEmpty).toList();
    return names.isEmpty ? 'لا توجد منتجات مرتبطة' : names.join('، ');
  }

  Widget _deliveryIcon(String? type) {
    switch (type) {
      case 'scheduled_pickup': return const Icon(Icons.calendar_today, size: 16);
      case 'delivery': return const Icon(Icons.motorcycle, size: 16);
      default: return const Icon(Icons.local_mall, size: 16);
    }
  }

  // --- منطق التوصيل/الاستلام ---
  String _deliveryLabel() {
    final type = widget.order.orderType;
    final mode = widget.order.pickupMode;

    // التحقق من حالات الاستلام
    if (type == 'pickup') {
      if (mode == 'scheduled_pickup') return 'استلام مجدول';
      return 'استلام ذاتي';
    }

    // التحقق من حالات التوصيل
    if (type == 'delivery') {
      if (mode == 'scheduled_delivery') return 'توصيل مجدول';
      return 'توصيل فوري';
    }

    return 'طلب غير محدد';
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.order.totalAmount ?? 0;
    final relative = _relativeTime();
    final statusColor = _orderStatusColor(widget.status);

    return Card(
      margin: const EdgeInsets.symmetric( vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: InkWell(
        onTap: () => context.pushRoute('/orders/details', arguments: OrderDetailsParams(order: widget.order)),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border(right: BorderSide(color: context.primaryContainer, width: 6)),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // --- Header ---
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(color: context.surface, borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.all(10),
                    child: Icon(Icons.person, color: context.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.bodyMedium(widget.order.user?.name ?? 'عميل المطعم', fontWeight: FontWeight.bold),
                        SizedBox(height: 4,),
                        AppText.labelMedium('#${widget.order.orderNumber ?? widget.order.id ?? '-'}'),

                        AppText.labelMedium(relative.isEmpty ? '' : '• $relative'),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppText.labelLarge('${total.toStringAsFixed(0)} ل.س', color: context.primary, fontWeight: FontWeight.bold),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: context.surface, borderRadius: BorderRadius.circular(6)),
                        child: AppText.labelSmall('نقدي', fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 24),
              // --- Body ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: context.surface.withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.labelLarge(_productsText(), maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _deliveryIcon(widget.order.pickupMode),
                        const SizedBox(width: 6),
                        AppText.labelLarge(_deliveryLabel(), fontWeight: FontWeight.bold),
                      ],
                    ),
                  ],
                ),
              ),
              // --- Status Tag (if not from home) ---
              if (!widget.isFromHome) ...[
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _orderStatusWidget(widget.status, statusColor),
                        const SizedBox(width: 6),
                        AppText.labelSmall(widget.order.statusLabelAr ?? widget.order.status ?? '-', color: statusColor, fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                ),
              ],
              // --- Actions ---
              if (widget.order.status == 'pending') ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: ElevatedButton(onPressed: () => showModalBottomSheet(context: context, builder: (_) => AcceptOrderBottomSheet(order: widget.order, bloc: widget.bloc)), child: const Text('قبول الطلب'))),
                    const SizedBox(width: 12),
                    Expanded(child: OutlinedButton(onPressed: () => showModalBottomSheet(context: context, builder: (_) => RejectOrderBottomSheet(order: widget.order, bloc: widget.bloc)), style: OutlinedButton.styleFrom(foregroundColor: context.error), child: const Text('رفض'))),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}