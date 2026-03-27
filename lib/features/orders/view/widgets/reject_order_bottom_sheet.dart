import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/orders/domain/usecases/reject_order_use_case.dart';
import 'package:dllni_resturant_owner_app/features/orders/view/manager/bloc/orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../data/models/get_orders_model.dart';

class RejectOrderBottomSheet extends StatefulWidget {
  const RejectOrderBottomSheet({super.key, required this.order, required this.bloc});

  final GetOrdersModelDataItem order;
  final OrdersBloc bloc;

  @override
  State<RejectOrderBottomSheet> createState() => _RejectOrderBottomSheetState();
}

class _RejectOrderBottomSheetState extends State<RejectOrderBottomSheet> {
  String? _selectedReason;
  final TextEditingController _notesController = TextEditingController();
  final int _maxNotesLength = 150;

  final List<RejectionReason> _rejectionReasons = [
    RejectionReason(code: 'out_of_stock', title: 'نفاد أحد العناصر', description: 'المكونات غير متوفرة حالياً'),
    RejectionReason(code: 'kitchen_busy', title: 'المطبخ مزدحم جداً', description: 'لا يمكن استقبال طلبات جديدة حالياً'),
    RejectionReason(code: 'end_of_work', title: 'انتهاء وقت العمل', description: 'المطعم سيغلق قريباً'),
    RejectionReason(code: 'other', title: 'سبب آخر', description: 'يرجى التوضيح في الحقل أدناه'),
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.onPrimary,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      height: context.height * .8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRejectionReasonSection(context),
                  SizedBox(height: 24),
                  _buildAdditionalNotesSection(context),
                  SizedBox(height: 24),
                  _buildInfoSection(context),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xffE5E7EB), width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.headlineMedium('رفض الطلب #${widget.order.orderNumber}', fontWeight: FontWeight.bold, textAlign: TextAlign.start),
                AppText.bodySmall('يرجى توضيح سبب الرفض للعميل', color: Color(0xff6B7280), textAlign: TextAlign.start),
              ],
            ),
          ),
          SizedBox(width: 12),
          InkWell(
            onTap: () {
              context.pop();
            },
            child: Icon(Icons.close, color: Color(0xff6B7280)),
          ),
        ],
      ),
    );
  }

  Widget _buildRejectionReasonSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.checklist_rounded, color: context.error),
            SizedBox(width: 8),
            AppText.titleMedium('سبب الرفض', fontWeight: FontWeight.bold),
            AppText.bodyLarge(' *', color: context.error, fontWeight: FontWeight.bold),
          ],
        ),
        SizedBox(height: 16),
        ..._rejectionReasons.map((reason) => _buildReasonOption(context, reason)),
      ],
    );
  }

  Widget _buildReasonOption(BuildContext context, RejectionReason reason) {
    final isSelected = _selectedReason == reason.code;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedReason = reason.code;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: EdgeInsetsDirectional.only(bottom: 12),
        padding: EdgeInsetsDirectional.all(16),
        decoration: BoxDecoration(
          color: isSelected ? context.primary.withAlpha(25) : context.onPrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? context.primary : Color(0xffE5E7EB), width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? context.primary : Color(0xffD1D5DB), width: 2),
                color: isSelected ? context.primary : Colors.transparent,
              ),
              child: isSelected ? Icon(Icons.check, size: 16, color: context.onPrimary) : null,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.bodyMedium(reason.title, fontWeight: FontWeight.bold),
                  SizedBox(height: 4),
                  AppText.bodySmall(reason.description, color: Color(0xff6B7280)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalNotesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.chat_bubble_outline, size: 20, color: Color(0xff6B7280)),
            SizedBox(width: 8),
            AppText.headlineMedium('ملاحظات إضافية', fontWeight: FontWeight.bold),
          ],
        ),
        SizedBox(height: 12),
        TextField(
          controller: _notesController,
          maxLines: 4,
          style: TextStyle(color: context.primary, fontWeight: FontWeight.bold, fontSize: 14),
          maxLength: _maxNotesLength,
          onChanged: (value) {
            setState(() {});
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffF9FAFB),
            hintText: 'اكتب رسالة توضيحية للعميل....',
            hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
            counterText: '${_notesController.text.length}/$_maxNotesLength',
            counterStyle: TextStyle(color: Color(0xff6B7280), fontSize: 12),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: context.primary),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(color: Color(0xffFFF7ED), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xffF59E0B).withAlpha(51)),
                child: Icon(Icons.info, size: 16, color: Color(0xffF59E0B)),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.labelLarge('ماذا سيحدث بعد الرفض؟', fontWeight: FontWeight.bold, color: Color(0xff92400E)),
                    SizedBox(height: 12),
                    _buildInfoItem('سيتم إشعار العميل فوراً بإلغاء الطلب.', context),
                    SizedBox(height: 8),
                    _buildInfoItem('قد يؤثر تكرار الرفض على نقاط الثقة.', context),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String text, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: EdgeInsetsDirectional.only(top: 6, end: 8),
          decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xffF59E0B)),
        ),
        Expanded(
          child: AppText.labelMedium(text, color: Color(0xffC2410C), textAlign: TextAlign.start),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final canConfirm = _selectedReason != null;

    return Container(
      padding: EdgeInsetsDirectional.all(24),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xffE5E7EB), width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: BlocConsumer<OrdersBloc, OrdersState>(
              bloc: widget.bloc,
              listener: (context, state) {
                switch (state.rejectOrderStatus) {
                  case null:
                    Loading.close();
                    break;
                  case BlocStatus.failed:
                    AppToast.showToast(context: context, message: state.errorMessage ?? 'خطا في رفض الطلب', type: ToastificationType.error);
                    Loading.close();
                    break;
                  case BlocStatus.success:
                    Loading.close();
                    break;
                  case BlocStatus.loading:
                    Loading.show(context);
                    break;
                  case BlocStatus.init:
                    Loading.close();
                    break;
                }
              },
              builder: (context, state) {
                return InkWell(
                  onTap: canConfirm
                      ? () {
                          widget.bloc.add(
                            RejectOrderEvent(
                              params: RejectOrderParams(reason: _selectedReason!, message: _notesController.text, id: widget.order.id!),
                            ),
                          );
                        }
                      : null,
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: canConfirm ? context.primary : Color(0xffD1D5DB)),
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                    child: AppText.labelLarge('تأكيد الرفض', color: context.onPrimary, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () => context.pop(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: context.error.withAlpha(50),
                  border: Border.all(color: context.error),
                ),
                padding: EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 12),
                child: AppText.labelLarge('تراجع', color: context.error, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RejectionReason {
  final String code;
  final String title;
  final String description;

  RejectionReason({required this.code, required this.title, required this.description});
}
