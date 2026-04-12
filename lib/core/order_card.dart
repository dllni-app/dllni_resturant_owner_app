import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/orders/view/screens/order_details_screen.dart';
import 'package:flutter/material.dart';

import '../features/orders/data/models/get_orders_model.dart';
import '../features/orders/view/manager/bloc/orders_bloc.dart';
import '../features/orders/view/widgets/accept_order_bottom_sheet.dart';
import '../features/orders/view/widgets/reject_order_bottom_sheet.dart';
import '../generated/assets.dart';

enum OrderStatus { newOrder, preparingOrder, readyOrder, completedOrder }

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
  Color orderStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.newOrder:
        return Color(0xff1E2A78);
      case OrderStatus.preparingOrder:
        return Color(0xffFF7A00);
      case OrderStatus.readyOrder:
        return Color(0xff24B364);
      case OrderStatus.completedOrder:
        return Color(0xff24B364);
    }
  }

  Widget orderStatusWidget(OrderStatus status, Color color) {
    switch (status) {
      case OrderStatus.newOrder:
        return CircleAvatar(radius: 4, backgroundColor: color);
      case OrderStatus.preparingOrder:
        return AppImage.asset(Assets.images.readyOrderIcon.path, size: 13);
      case OrderStatus.readyOrder:
        return Icon(Icons.check_circle, size: 10, color: color);
      case OrderStatus.completedOrder:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushRoute('/orders/details', arguments: OrderDetailsParams(order: widget.order));
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: context.onPrimary,
          border: Border(right: BorderSide(color: context.primaryContainer, width: 5)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 16, end: 16, top: widget.isFromHome ? 16 : 30, bottom: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Color(0xff374151)),
                        padding: EdgeInsetsDirectional.all(12),
                        child: Icon(Icons.person, color: Color(0xff9CA3AF)),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.bodyMedium('${widget.order.user?.name}', color: Color(0xff2F2B3D), fontWeight: FontWeight.bold),
                            AppText.labelMedium(
                              '#${widget.order.orderNumber} • منذ 2 دقيقة',
                              color: Color(0xff2F2B3D).withAlpha(153),
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        children: [
                          AppText.labelLarge('${widget.order.totalAmount} ل.س', color: context.primary, fontWeight: FontWeight.bold),
                          SizedBox(height: 4),
                          Container(
                            decoration: BoxDecoration(color: context.primaryContainer, borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 8),
                            child: AppText.labelSmall('نقدي', color: context.onPrimaryContainer, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xff2F2B3D).withAlpha(31)),
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 8),
                    width: context.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: AppText.labelLarge(
                            widget.order.orderItems?.map((e) => e.product?.name).join(', ') ?? '',
                            color: Color(0xff2F2B3D).withAlpha(230),
                            fontWeight: FontWeight.w400,
                            maxLines: 1,
                          ),
                        ),
                        Divider(color: Color(0xff2F2B3D).withAlpha(21), endIndent: 8, indent: 8, thickness: 1),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AppImage.asset(Assets.images.motor.path, size: 18),
                            SizedBox(width: 4),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: AppText.labelLarge(
                                  widget.order.orderType == 'pickup' ? 'توصيل' : 'توصيل',
                                  color: Color(0xff2F2B3D).withAlpha(153),
                                  fontWeight: FontWeight.bold,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: InkWell(
                          onTap: () async {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              enableDrag: true,
                              builder: (context) => AcceptOrderBottomSheet(order: widget.order, bloc: widget.bloc),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: context.primary),
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 8),
                            child: AppText.labelLarge('قبول الطلب', color: context.onPrimary, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () async {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => RejectOrderBottomSheet(order: widget.order, bloc: widget.bloc),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.error.withAlpha(50),
                              border: Border.all(color: context.error),
                            ),
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 8),
                            child: AppText.labelLarge('رفض', color: context.error, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            widget.isFromHome
                ? SizedBox.shrink()
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(14), bottomRight: Radius.circular(10)),
                              color: orderStatusColor(widget.status).withAlpha(51),
                            ),
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 8),
                            child: Row(
                              children: [
                                orderStatusWidget(widget.status, orderStatusColor(widget.status)),
                                SizedBox(width: 4),
                                AppText.labelSmall(
                                  '${widget.order.statusLabelAr}',
                                  fontWeight: FontWeight.bold,
                                  color: orderStatusColor(widget.status),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
