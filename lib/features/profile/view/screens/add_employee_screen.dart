import 'dart:io';

import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/products/view/widgets/app_buttons.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/add_employee_use_case.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/fetch_employees_permissions_use_case.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/fetch_employees_use_case.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/widgets/add_employee_account_status_card.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/widgets/add_employee_app_bar.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/widgets/add_employee_basic_info_card.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/widgets/add_employee_permissions_card.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/widgets/create_offer_step_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../data/models/fetch_employees_model.dart';
import '../manager/bloc/profile_bloc.dart';

@AutoRoutePage(path: '/employeesmanagement/new')
class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key, required this.params});

  final AddEmployeeScreenParams params;

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isAccountEnabled = true;
  File? _pickedImagePath;
  final Set<int> _selectedPermissions = <int>{};

  @override
  void initState() {
    super.initState();
    final employee = widget.params.employee;
    if (employee != null) {
      _nameController.text = employee.user?.name ?? '';
      _phoneController.text = employee.user?.phone ?? '';
      _isAccountEnabled = employee.isActive ?? false;
      _selectedPermissions.addAll((employee.permissionIds ?? []).map((e) => int.tryParse('$e')).whereType<int>());
    }
    getIt<ProfileBloc>().add(FetchEmployeesPermissionsEvent(params: FetchEmployeesPermissionsParams()));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validate(BuildContext context) {
    if (_nameController.text.trim().isEmpty) {
      AppToast.showToast(context: context, message: 'أدخل اسم الموظف', type: ToastificationType.error);
      return false;
    }
    if (_phoneController.text.trim().isEmpty) {
      AppToast.showToast(context: context, message: 'أدخل رقم الموظف', type: ToastificationType.error);
      return false;
    }
    if (widget.params.employee == null && _passwordController.text.trim().isEmpty) {
      AppToast.showToast(context: context, message: 'أدخل كلمة مرور الموظف', type: ToastificationType.error);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AddEmployeeAppBar(),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CreateOfferStepCard(
                      number: 1,
                      title: 'البيانات الأساسية',
                      trailing: _squareIcon(const Color(0x1A065F46), Icons.person, const Color(0xFF065F46)),
                      child: AddEmployeeBasicInfoCard(
                        nameController: _nameController,
                        phoneController: _phoneController,
                        pickedImagePath: _pickedImagePath,
                        passwordController: _passwordController,
                        onPickImageTap: (image) {
                          setState(() => _pickedImagePath = image);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    CreateOfferStepCard(
                      number: 2,
                      title: 'تحديد صلاحيات الموظف',
                      trailing: _squareIcon(const Color(0x1AF59E0B), Icons.shield_outlined, const Color(0xFFD97706)),
                      child: AddEmployeePermissionsCard(
                        selectedPermissionIds: _selectedPermissions,
                        onPermissionToggle: (id, isSelected) {
                          setState(() {
                            if (isSelected) {
                              _selectedPermissions.add(id);
                            } else {
                              _selectedPermissions.remove(id);
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    CreateOfferStepCard(
                      number: 3,
                      title: 'حالة الحساب',
                      trailing: _squareIcon(const Color(0x1A10B981), Icons.toggle_on, const Color(0xFF10B981)),
                      child: AddEmployeeAccountStatusCard(
                        isEnabled: _isAccountEnabled,
                        onToggle: (value) => setState(() => _isAccountEnabled = value),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: BlocConsumer<ProfileBloc, ProfileState>(
                      listener: (context, state) {
                        switch (state.addEmployeeStatus) {
                          case BlocStatus.failed:
                            Loading.close();
                            AppToast.showToast(context: context, message: state.errorMessage ?? 'خطأ في حفظ الموظف', type: ToastificationType.error);
                            break;
                          case BlocStatus.success:
                            Loading.close();
                            context.read<ProfileBloc>().add(FetchEmployeesEvent(params: FetchEmployeesParams()));
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
                        final isLoading = state.addEmployeeStatus == BlocStatus.loading;
                        return AppButton(
                          title: 'حفظ وتفعيل',
                          onTap: isLoading
                              ? null
                              : () {
                                  if (!_validate(context)) return;
                                  context.read<ProfileBloc>().add(
                                        AddEmployeeEvent(
                                          context: context,
                                          params: AddEmployeeParams(
                                            name: _nameController.text.trim(),
                                            phone: _phoneController.text.trim(),
                                            image: _pickedImagePath,
                                            permissions: _selectedPermissions.toList(),
                                            password: _passwordController.text.trim().isEmpty ? null : _passwordController.text.trim(),
                                            isActive: _isAccountEnabled,
                                            isAddNew: widget.params.employee == null,
                                            id: widget.params.employee?.id,
                                          ),
                                        ),
                                      );
                                },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  AppOutlinedButton(title: 'إلغاء', color: const Color(0xFFFF4C51), onTap: () => context.pop()),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _squareIcon(Color background, IconData icon, Color color) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(10)),
      child: Icon(icon, color: color, size: 18),
    );
  }
}

class AddEmployeeScreenParams {
  final FetchEmployeesModelDataItem? employee;

  AddEmployeeScreenParams({this.employee});
}
