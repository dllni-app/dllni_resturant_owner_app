import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/add_employee_use_case.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/manager/bloc/profile_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/fetch_employees_model.dart';
import '../screens/add_employee_screen.dart';

enum _EmployeeAction { update, delete }

class EmployeeManagementCard extends StatelessWidget {
  const EmployeeManagementCard({super.key, required this.item});

  final FetchEmployeesModelDataItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffF3F4F6), width: 1),
        color: context.onPrimary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), offset: const Offset(0, 1), blurRadius: 2)],
      ),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFFF3F4F6),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: item.user?.profileImageUrl != null
                    ? ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.network(item.user!.profileImageUrl!, width: 30, height: 30))
                    : const Icon(Icons.person, color: Color(0xFF6B7280), size: 30),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.titleMedium(item.user?.name ?? '-', fontWeight: FontWeight.bold, textAlign: TextAlign.start),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: item.isActive == true ? const Color(0x1A10B981) : const Color(0x1AEF4444),
                          ),
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 2),
                          child: Row(
                            children: [
                              CircleAvatar(radius: 3, backgroundColor: item.isActive == true ? const Color(0xFF10B981) : const Color(0xFFEF4444)),
                              const SizedBox(width: 6),
                              AppText.labelLarge(
                                item.isActive == true ? 'نشط' : 'معطل',
                                color: item.isActive == true ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.phone, color: Color(0xFF6B7280), size: 14),
                        const SizedBox(width: 4),
                        Expanded(
                          child: AppText.labelLarge(
                            item.user?.phone ?? '-',
                            color: const Color(0xFF6B7280),
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              PopupMenuButton<_EmployeeAction>(
                icon: const Icon(Icons.more_vert, color: Color(0xFF6B7280)),
                onSelected: (value) {
                  if (value == _EmployeeAction.update) {
                    context.pushRoute('/employeesmanagement/new', arguments: AddEmployeeScreenParams(employee: item));
                    return;
                  } else {
                    context.read<ProfileBloc>().add(
                      AddEmployeeEvent(
                        params: AddEmployeeParams(isDelete: true, id: item.id!),
                        context: context,
                      ),
                    );
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<_EmployeeAction>(
                    value: _EmployeeAction.update,
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined, size: 18, color: Color(0xFF065F46)),
                        SizedBox(width: 8),
                        AppText.labelLarge('تعديل'),
                      ],
                    ),
                  ),
                  PopupMenuItem<_EmployeeAction>(
                    value: _EmployeeAction.delete,
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, size: 18, color: Color(0xFFEF4444)),
                        SizedBox(width: 8),
                        AppText.labelLarge('حذف'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: const Color(0xffF9FAFB)),
            padding: const EdgeInsetsDirectional.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.labelLarge('تاريخ الانضمام', color: const Color(0xFF6B7280), fontWeight: FontWeight.w500),
                    const SizedBox(height: 4),
                    AppText.bodyMedium(
                      item.createdAt == null ? '-' : DateFormat('yyyy-MM-dd').format(DateTime.parse(item.createdAt!)),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111827),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.labelLarge('الصلاحيات', color: const Color(0xFF6B7280), fontWeight: FontWeight.w500),
                    const SizedBox(height: 4),
                    ...item.permissionIds!.map(
                      (permission) =>
                          AppText.labelLarge('$permission', color: const Color(0xFF065F46), fontWeight: FontWeight.w700, textAlign: TextAlign.end),
                    ),
                  ],
                ),
              ],
            ),
          ),
          /* const SizedBox(height: 14),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: context.width,
              decoration: BoxDecoration(color: const Color(0xFF065F46), borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.visibility, size: 16, color: Colors.white),
                  const SizedBox(width: 8),
                  AppText.bodyMedium('عرض التفاصيل', color: Colors.white, fontWeight: FontWeight.bold),
                ],
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
