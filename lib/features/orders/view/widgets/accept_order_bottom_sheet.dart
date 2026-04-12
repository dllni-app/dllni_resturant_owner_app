import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/orders/domain/usecases/accept_order_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../../generated/assets.dart';
import '../../data/models/get_orders_model.dart';
import '../manager/bloc/orders_bloc.dart';

class AcceptOrderBottomSheet extends StatefulWidget {
  const AcceptOrderBottomSheet({super.key, required this.order, required this.bloc});

  final GetOrdersModelDataItem order;
  final OrdersBloc bloc;

  @override
  State<AcceptOrderBottomSheet> createState() => _AcceptOrderBottomSheetState();
}

class _AcceptOrderBottomSheetState extends State<AcceptOrderBottomSheet> {
  int? _selectedPreparationTime;
  int? _customPreparationTime;
  int? _selectedEmployeeId;
  final TextEditingController _kitchenNotesController = TextEditingController();
  final TextEditingController _customTimeController = TextEditingController();

  final List<int> _predefinedTimes = [15, 25, 35, 45];

  @override
  void dispose() {
    _kitchenNotesController.dispose();
    _customTimeController.dispose();
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
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPreparationTimeSection(context),
                  SizedBox(height: 24),
                  _buildEmployeeSection(context),
                  SizedBox(height: 24),
                  _buildKitchenNotesSection(context),
                  SizedBox(height: 24),
                  _buildAutomaticActionsSection(context),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
          Container(
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
                      switch (state.acceptOrderStatus) {
                        case null:
                          Loading.close();
                          break;
                        case BlocStatus.failed:
                          AppToast.showToast(context: context, message: state.errorMessage ?? 'خطا في قبول الطلب', type: ToastificationType.error);
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
                      final preparationTime = _customPreparationTime ?? _selectedPreparationTime;
                      final canConfirm = preparationTime != null;
                      return InkWell(
                        onTap: canConfirm
                            ? () {
                                widget.bloc.add(
                                  AcceptOrderEvent(
                                    params: AcceptOrderParams(
                                      id: widget.order.id!,
                                      preparationTimeMinutes: _selectedPreparationTime ?? int.parse(_customTimeController.text.split('.').first),
                                      kitchenNotes: _kitchenNotesController.text,
                                    ),
                                  ),
                                );
                              }
                            : null,
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: canConfirm ? context.primary : Color(0xffD1D5DB)),
                          padding: EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                          child: AppText.labelLarge('تأكيد الطلب', color: context.onPrimary, fontWeight: FontWeight.bold),
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
          ),
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
                AppText.titleMedium('قبول الطلب #${widget.order.orderNumber}', fontWeight: FontWeight.bold, textAlign: TextAlign.start),
                AppText.bodySmall('يرجى تأكيد تفاصيل التجهيز قبل البدء', color: Color(0xff6B7280), textAlign: TextAlign.start),
              ],
            ),
          ),
          SizedBox(width: 8),
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

  Widget _buildPreparationTimeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.access_time, size: 20, color: Color(0xff3B82F6)),
            SizedBox(width: 8),
            AppText.bodyMedium('وقت التجهيز المتوقع', fontWeight: FontWeight.bold),
          ],
        ),
        SizedBox(height: 16),
        Row(
          spacing: 12,
          children: _predefinedTimes.map((time) {
            final isSelected = _selectedPreparationTime == time && _customPreparationTime == null;
            return Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedPreparationTime = time;
                    _customPreparationTime = null;
                    _customTimeController.clear();
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xff3B82F6).withAlpha(51) : context.onPrimary,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: isSelected ? Color(0xff3B82F6) : Color(0xffE5E7EB), width: 1),
                  ),
                  child: Column(
                    children: [
                      AppText.labelLarge('$time', color: isSelected ? Color(0xff1D4ED8) : Color(0xff2F2B3D), fontWeight: FontWeight.bold),
                      AppText.labelLarge('دقيقة', color: isSelected ? Color(0xff1D4ED8) : Color(0xff2F2B3D), fontWeight: FontWeight.w500),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _customTimeController,
          keyboardType: TextInputType.number,
          style: TextStyle(color: context.primary, fontWeight: FontWeight.bold, fontSize: 14),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) {
            setState(() {
              if (value.isNotEmpty) {
                _customPreparationTime = int.tryParse(value);
                _selectedPreparationTime = null;
              } else {
                _customPreparationTime = null;
              }
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffF9FAFB),
            hintText: 'أدخل وقت مخصص (دقيقة)',
            hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
            prefixIcon: Icon(Icons.hourglass_empty, color: Color(0xff6B7280), size: 20),
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

  Widget _buildEmployeeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.people, size: 20, color: Color(0xff3B82F6)),
            SizedBox(width: 8),
            Row(
              children: [
                AppText.bodyMedium('تعيين موظف مسؤول', fontWeight: FontWeight.bold),
                SizedBox(width: 8),
                AppText.bodyMedium('(اختياري)', fontWeight: FontWeight.w400, color: Color(0xff9CA3AF)),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        InkWell(
          onTap: () {
            // TODO: Show employee selection dialog
          },
          child: Container(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Color(0xffF9FAFB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xffE5E7EB)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AppText.bodyMedium(
                    _selectedEmployeeId == null ? 'اختر موظف....' : 'موظف #$_selectedEmployeeId',
                    color: _selectedEmployeeId == null ? Color(0xff9CA3AF) : Color(0xff2F2B3D),
                    textAlign: TextAlign.start,
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: Color(0xff6B7280)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKitchenNotesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.sticky_note_2_outlined, color: Color(0xff3B82F6)),
            SizedBox(width: 8),
            AppText.headlineMedium('ملاحظات المطبخ', fontWeight: FontWeight.bold),
          ],
        ),
        SizedBox(height: 12),
        TextField(
          controller: _kitchenNotesController,
          maxLines: 4,
          style: TextStyle(color: context.primary, fontWeight: FontWeight.bold, fontSize: 14),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffF9FAFB),
            hintText: 'أضف ملاحظات خاصة للتجهيز....',
            hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
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

  Widget _buildAutomaticActionsSection(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(
        color: Color(0xffF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xffF3F4F6), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.labelLarge('الإجراءات التلقائية', fontWeight: FontWeight.bold, color: Color(0xff6B7280)),
          SizedBox(height: 16),
          // Row(
          //   children: [
          //     Container(
          //       decoration: BoxDecoration(
          //         color: context.onPrimary,
          //         border: Border.all(color: Color(0xffE5E7EB), width: 1),
          //         borderRadius: BorderRadius.circular(99),
          //         boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), offset: Offset(0, 2), blurRadius: 2)],
          //       ),
          //       padding: EdgeInsetsDirectional.all(9),
          //       child: AppImage.asset(Assets.images.navBarInventory.path, size: 14, color: Color(0xff2563EB),),
          //     ),
          //     SizedBox(width: 12),
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           AppText.bodyMedium('سيتم خصم المخزون', fontWeight: FontWeight.bold),
          //           SizedBox(height: 4),
          //           AppText.labelSmall('تحديث تلقائي للكميات المتاحة', color: Color(0xff6B7280)),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 16),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.onPrimary,
                  border: Border.all(color: Color(0xffE5E7EB), width: 1),
                  borderRadius: BorderRadius.circular(99),
                  boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), offset: Offset(0, 2), blurRadius: 2)],
                ),
                padding: EdgeInsetsDirectional.all(9),
                child: AppImage.asset(Assets.images.homeNotification.path, size: 14, color: Color(0xff2563EB)),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.bodyMedium('سيتم إشعار العميل', fontWeight: FontWeight.bold),
                    SizedBox(height: 4),
                    AppText.labelSmall('إرسال حالة "قيد التحضير" فورا', color: Color(0xff6B7280)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
