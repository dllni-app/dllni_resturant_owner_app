import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/orders/data/models/get_orders_model.dart';
import 'package:dllni_resturant_owner_app/features/orders/data/models/owner_order_details_model.dart';
import 'package:dllni_resturant_owner_app/features/orders/domain/usecases/change_order_status_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../manager/bloc/orders_bloc.dart';

class RestaurantOrderStatusAction {
  final String status;
  final String label;
  final String description;
  final IconData icon;
  final bool isDanger;

  const RestaurantOrderStatusAction({required this.status, required this.label, required this.description, required this.icon, this.isDanger = false});
}

String restaurantOrderStatusLabel(String? status) {
  return switch (status) {
    'pending' => 'قيد الانتظار',
    'accepted' => 'مقبول',
    'preparing' => 'قيد التحضير',
    'ready_for_pickup' => 'جاهز للاستلام',
    'picked_up' => 'تم الاستلام',
    'completed' => 'مكتمل',
    'cancelled' => 'ملغي',
    _ => status ?? '-',
  };
}

List<RestaurantOrderStatusAction> restaurantOrderNextStatusActions(String? status) {
  return switch (status) {
    'accepted' => const [
        RestaurantOrderStatusAction(status: 'preparing', label: 'بدء التحضير', description: 'نقل الطلب إلى تبويب قيد التحضير.', icon: Icons.restaurant_menu),
        RestaurantOrderStatusAction(status: 'cancelled', label: 'إلغاء الطلب', description: 'إلغاء الطلب وإشعار العميل.', icon: Icons.cancel_outlined, isDanger: true),
      ],
    'preparing' => const [
        RestaurantOrderStatusAction(status: 'ready_for_pickup', label: 'جاهز للاستلام', description: 'إخبار الفريق أن الطلب أصبح جاهزاً للتسليم.', icon: Icons.inventory_2_outlined),
        RestaurantOrderStatusAction(status: 'cancelled', label: 'إلغاء الطلب', description: 'إلغاء الطلب عند وجود مشكلة تمنع التجهيز.', icon: Icons.cancel_outlined, isDanger: true),
      ],
    'ready_for_pickup' => const [
        RestaurantOrderStatusAction(status: 'picked_up', label: 'تم الاستلام', description: 'تأكيد استلام الطلب من السائق أو العميل.', icon: Icons.delivery_dining),
        RestaurantOrderStatusAction(status: 'completed', label: 'إكمال الطلب', description: 'إنهاء الطلب مباشرة إذا تم التسليم.', icon: Icons.done_all),
      ],
    'picked_up' => const [
        RestaurantOrderStatusAction(status: 'completed', label: 'إكمال الطلب', description: 'تأكيد انتهاء الطلب بنجاح.', icon: Icons.done_all),
      ],
    _ => const [],
  };
}

bool hasRestaurantOrderStatusActions(String? status) => restaurantOrderNextStatusActions(status).isNotEmpty;

class OrderStatusActionBottomSheet extends StatefulWidget {
  final int orderId;
  final String? orderNumber;
  final String? status;
  final String? statusLabelAr;
  final OrdersBloc bloc;

  const OrderStatusActionBottomSheet._({required this.orderId, required this.bloc, this.orderNumber, this.status, this.statusLabelAr});

  factory OrderStatusActionBottomSheet.fromList({required GetOrdersModelDataItem order, required OrdersBloc bloc}) {
    return OrderStatusActionBottomSheet._(orderId: order.id!, orderNumber: order.orderNumber, status: order.status, statusLabelAr: order.statusLabelAr, bloc: bloc);
  }

  factory OrderStatusActionBottomSheet.fromDetails({required OwnerOrderDetailsData order, required OrdersBloc bloc}) {
    return OrderStatusActionBottomSheet._(orderId: order.id, orderNumber: order.orderNumber, status: order.status, statusLabelAr: order.statusLabelAr, bloc: bloc);
  }

  @override
  State<OrderStatusActionBottomSheet> createState() => _OrderStatusActionBottomSheetState();
}

class _OrderStatusActionBottomSheetState extends State<OrderStatusActionBottomSheet> {
  final TextEditingController _cancelReasonController = TextEditingController();

  @override
  void dispose() {
    _cancelReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actions = restaurantOrderNextStatusActions(widget.status);
    final currentLabel = widget.statusLabelAr ?? restaurantOrderStatusLabel(widget.status);
    final hasCancelAction = actions.any((action) => action.status == 'cancelled');

    return Container(
      decoration: BoxDecoration(
        color: context.onPrimary,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: BlocConsumer<OrdersBloc, OrdersState>(
          bloc: widget.bloc,
          listenWhen: (previous, current) => previous.changeOrderStatusStatus != current.changeOrderStatusStatus,
          listener: (context, state) {
            switch (state.changeOrderStatusStatus) {
              case BlocStatus.loading:
                Loading.show(context);
                break;
              case BlocStatus.success:
                Loading.close();
                context.pop();
                AppToast.showToast(context: context, message: 'تم تحديث حالة الطلب بنجاح', type: ToastificationType.success);
                break;
              case BlocStatus.failed:
                Loading.close();
                AppToast.showToast(context: context, message: state.errorMessage ?? 'تعذر تحديث حالة الطلب', type: ToastificationType.error);
                break;
              case BlocStatus.init:
              case null:
                Loading.close();
                break;
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.titleMedium('تغيير حالة الطلب #${widget.orderNumber ?? widget.orderId}', fontWeight: FontWeight.bold, textAlign: TextAlign.start),
                            const SizedBox(height: 4),
                            AppText.bodySmall('الحالة الحالية: $currentLabel', color: const Color(0xff6B7280), textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                      InkWell(onTap: () => context.pop(), child: const Icon(Icons.close, color: Color(0xff6B7280))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (actions.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsetsDirectional.all(16),
                      decoration: BoxDecoration(color: const Color(0xffF3F4F6), borderRadius: BorderRadius.circular(12)),
                      child: AppText.bodyMedium('لا توجد إجراءات متاحة لهذه الحالة.', textAlign: TextAlign.start),
                    )
                  else ...[
                    AppText.bodyMedium('اختر الحالة التالية:', fontWeight: FontWeight.bold),
                    const SizedBox(height: 12),
                    ...actions.map((action) => _buildActionTile(context, action, state.changeOrderStatusStatus == BlocStatus.loading)),
                    if (hasCancelAction) ...[
                      const SizedBox(height: 12),
                      TextField(
                        controller: _cancelReasonController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'سبب الإلغاء للعميل (اختياري)',
                          filled: true,
                          fillColor: Color(0xffF9FAFB),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, RestaurantOrderStatusAction action, bool isLoading) {
    final color = action.isDanger ? context.error : context.primary;
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: isLoading ? null : () => _confirmAndSubmit(context, action),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsetsDirectional.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withAlpha(90)),
            color: color.withAlpha(18),
          ),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: color.withAlpha(35), child: Icon(action.icon, color: color, size: 20)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.bodyMedium(action.label, color: color, fontWeight: FontWeight.bold, textAlign: TextAlign.start),
                    const SizedBox(height: 4),
                    AppText.bodySmall(action.description, color: const Color(0xff6B7280), textAlign: TextAlign.start),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: color),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmAndSubmit(BuildContext context, RestaurantOrderStatusAction action) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('تأكيد ${action.label}'),
        content: Text('سيتم تغيير حالة الطلب إلى "${restaurantOrderStatusLabel(action.status)}". هل تريد المتابعة؟'),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('تراجع')),
          ElevatedButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: const Text('تأكيد')),
        ],
      ),
    );

    if (confirmed != true) return;

    widget.bloc.add(
      ChangeOrderStatusEvent(
        params: ChangeOrderStatusParams(
          orderId: widget.orderId,
          status: action.status,
          reason: action.status == 'cancelled' ? 'owner_cancelled' : null,
          note: action.status == 'cancelled' ? _cancelReasonController.text.trim() : null,
        ),
      ),
    );
  }
}
