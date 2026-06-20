import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/orders/domain/usecases/accept_order_use_case.dart';
import 'package:dllni_resturant_owner_app/features/profile/data/models/fetch_employees_model.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/fetch_employees_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

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
  bool _employeesLoading = true;
  String? _employeesError;
  final List<FetchEmployeesModelDataItem> _employees = [];
  final TextEditingController _kitchenNotesController = TextEditingController();
  final TextEditingController _customTimeController = TextEditingController();
  final List<int> _predefinedTimes = [15, 25, 35, 45];

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    final result = await getIt<FetchEmployeesUseCase>()(FetchEmployeesParams());
    result.fold(
      (failure) {
        _employeesError = failure.message;
      },
      (model) {
        _employees
          ..clear()
          ..addAll((model.data ?? []).where((employee) => employee.isActive != false));
        _employeesError = null;
      },
    );
    if (mounted) setState(() => _employeesLoading = false);
  }

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
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      height: context.height * .8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPreparationTimeSection(context),
                  const SizedBox(height: 24),
                  _buildEmployeeSection(context),
                  const SizedBox(height: 24),
                  _buildKitchenNotesSection(context),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.all(24),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffE5E7EB), width: 1))),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: BlocConsumer<OrdersBloc, OrdersState>(
                    bloc: widget.bloc,
                    listener: (context, state) {
                      switch (state.acceptOrderStatus) {
                        case BlocStatus.failed:
                          Loading.close();
                          AppToast.showToast(context: context, message: state.errorMessage ?? 'خطأ في قبول الطلب', type: ToastificationType.error);
                          break;
                        case BlocStatus.success:
                          Loading.close();
                          context.pop();
                          break;
                        case BlocStatus.loading:
                          Loading.show(context);
                          break;
                        case BlocStatus.init:
                        case null:
                          Loading.close();
                          break;
                      }
                    },
                    builder: (context, state) {
                      final preparationTime = _customPreparationTime ?? _selectedPreparationTime;
                      final canConfirm = preparationTime != null && state.acceptOrderStatus != BlocStatus.loading;
                      return InkWell(
                        onTap: canConfirm
                            ? () {
                                widget.bloc.add(
                                  AcceptOrderEvent(
                                    params: AcceptOrderParams(
                                      id: widget.order.id!,
                                      preparationTimeMinutes: preparationTime,
                                      assignedEmployeeId: _selectedEmployeeId,
                                      kitchenNotes: _kitchenNotesController.text.trim(),
                                    ),
                                  ),
                                );
                              }
                            : null,
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: canConfirm ? context.primary : const Color(0xffD1D5DB)),
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                          child: AppText.labelLarge('تأكيد الطلب', color: context.onPrimary, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
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
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 12),
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
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffE5E7EB), width: 1))),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.titleMedium('قبول الطلب #${widget.order.orderNumber}', fontWeight: FontWeight.bold, textAlign: TextAlign.start),
                AppText.bodySmall('يرجى تأكيد تفاصيل التجهيز قبل البدء', color: const Color(0xff6B7280), textAlign: TextAlign.start),
              ],
            ),
          ),
          const SizedBox(width: 8),
          InkWell(onTap: () => context.pop(), child: const Icon(Icons.close, color: Color(0xff6B7280))),
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
            const Icon(Icons.access_time, size: 20, color: Color(0xff3B82F6)),
            const SizedBox(width: 8),
            AppText.bodyMedium('وقت التجهيز المتوقع', fontWeight: FontWeight.bold),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: _predefinedTimes.map((time) {
            final isSelected = _selectedPreparationTime == time && _customPreparationTime == null;
            return Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 4),
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
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xff3B82F6).withAlpha(51) : context.onPrimary,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: isSelected ? const Color(0xff3B82F6) : const Color(0xffE5E7EB), width: 1),
                    ),
                    child: Column(
                      children: [
                        AppText.labelLarge('$time', color: isSelected ? const Color(0xff1D4ED8) : const Color(0xff2F2B3D), fontWeight: FontWeight.bold),
                        AppText.labelLarge('دقيقة', color: isSelected ? const Color(0xff1D4ED8) : const Color(0xff2F2B3D), fontWeight: FontWeight.w500),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _customTimeController,
          keyboardType: TextInputType.number,
          style: TextStyle(color: context.primary, fontWeight: FontWeight.bold, fontSize: 14),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) {
            setState(() {
              _customPreparationTime = value.isEmpty ? null : int.tryParse(value);
              if (_customPreparationTime != null) _selectedPreparationTime = null;
            });
          },
          decoration: _fieldDecoration(context, 'أدخل وقت مخصص (دقيقة)', Icons.hourglass_empty),
        ),
      ],
    );
  }

  Widget _buildEmployeeSection(BuildContext context) {
    final dropdownItems = _employees
        .map((employee) {
          final id = employee.userId;
          if (id == null) return null;
          final name = employee.user?.name ?? employee.user?.email ?? 'موظف #$id';
          return DropdownMenuItem<int>(value: id, child: Text(name, overflow: TextOverflow.ellipsis));
        })
        .whereType<DropdownMenuItem<int>>()
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.people, size: 20, color: Color(0xff3B82F6)),
            const SizedBox(width: 8),
            AppText.bodyMedium('تعيين موظف مسؤول', fontWeight: FontWeight.bold),
            const SizedBox(width: 8),
            AppText.bodyMedium('(اختياري)', fontWeight: FontWeight.w400, color: const Color(0xff9CA3AF)),
          ],
        ),
        const SizedBox(height: 16),
        if (_employeesLoading)
          const Center(child: CircularProgressIndicator.adaptive())
        else if (_employeesError != null)
          AppText.bodyMedium(_employeesError!, color: context.error, textAlign: TextAlign.start)
        else if (dropdownItems.isEmpty)
          AppText.bodyMedium('لا يوجد موظفين نشطين', color: const Color(0xff9CA3AF), textAlign: TextAlign.start)
        else
          DropdownButtonFormField<int>(
            value: _selectedEmployeeId,
            isExpanded: true,
            items: dropdownItems,
            onChanged: (value) => setState(() => _selectedEmployeeId = value),
            decoration: _fieldDecoration(context, 'اختر موظف....', Icons.person_outline),
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
            const Icon(Icons.sticky_note_2_outlined, color: Color(0xff3B82F6)),
            const SizedBox(width: 8),
            AppText.headlineMedium('ملاحظات المطبخ', fontWeight: FontWeight.bold),
          ],
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _kitchenNotesController,
          maxLines: 4,
          style: TextStyle(color: context.primary, fontWeight: FontWeight.bold, fontSize: 14),
          decoration: _fieldDecoration(context, 'أضف ملاحظات خاصة للتجهيز....', Icons.sticky_note_2_outlined),
        ),
      ],
    );
  }

  InputDecoration _fieldDecoration(BuildContext context, String hint, IconData icon) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xffF9FAFB),
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xff9CA3AF), fontSize: 14),
      prefixIcon: Icon(icon, color: const Color(0xff6B7280), size: 20),
      border: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xffE5E7EB)), borderRadius: BorderRadius.all(Radius.circular(12))),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xffE5E7EB)), borderRadius: BorderRadius.all(Radius.circular(12))),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: context.primary), borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}
