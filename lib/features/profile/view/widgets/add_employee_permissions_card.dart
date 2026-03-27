import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/bloc/profile_bloc.dart';
import 'add_employee_permission_tile.dart';

class AddEmployeePermissionsCard extends StatelessWidget {
  const AddEmployeePermissionsCard({super.key, required this.selectedPermissionIds, required this.onPermissionToggle});

  final Set<int> selectedPermissionIds;
  final void Function(int id, bool isSelected) onPermissionToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText.bodyMedium('اختر الصلاحيات المناسبة لدور الموظف', color: const Color(0xFF6B7280), fontWeight: FontWeight.w500),
        const SizedBox(height: 16),
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            switch (state.employeesPermissionsStatus) {
              case null:
                return const SizedBox.shrink();
              case BlocStatus.failed:
                return Center(
                  child: AppText.labelLarge(state.errorMessage ?? 'حدث خطا ما', color: context.error, fontWeight: FontWeight.bold),
                );
              case BlocStatus.success:
                return Column(
                  spacing: 10,
                  children: List.generate(
                    state.employeesPermissions!.data!.permissions!.length,
                    (i) => AddEmployeePermissionTile(
                      item: state.employeesPermissions!.data!.permissions![i],
                      isSelected: selectedPermissionIds.contains(state.employeesPermissions!.data!.permissions![i].id!),
                      onChanged: (value) {
                        onPermissionToggle(state.employeesPermissions!.data!.permissions![i].id!, value);
                      },
                    ),
                  ),
                );
              case BlocStatus.loading:
                return Center(child: CircularProgressIndicator.adaptive());
              case BlocStatus.init:
                return Center(child: CircularProgressIndicator.adaptive());
            }
          },
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFB7E4D8)),
            color: const Color(0xFFF0FDF4),
          ),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              const Icon(Icons.lightbulb, color: Color(0xFF065F46), size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: AppText.labelLarge(
                  'يمكنك تعديل صلاحيات الموظف في أي وقت من صفحة إدارة الموظفين',
                  color: const Color(0xFF065F46),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
