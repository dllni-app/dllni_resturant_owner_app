import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/fetch_employees_use_case.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/manager/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeManagementFilterCard extends StatelessWidget {
  const EmployeeManagementFilterCard({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: context.onPrimary,
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), offset: const Offset(0, 1), blurRadius: 2)],
        border: Border.all(color: const Color(0xffF3F4F6), width: 1),
      ),
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 24),
      padding: const EdgeInsetsDirectional.all(16),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: (val){
              context.read<ProfileBloc>().add(FetchEmployeesEvent(params: FetchEmployeesParams()));
            },
            style: const TextStyle(color: Color(0xff2F2B3D), fontSize: 14, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF9FAFB),
              suffixIcon: const Icon(Icons.search, color: Color(0xff9CA3AF)),
              hintText: 'ابحث عن موظف...',
              hintStyle: const TextStyle(color: Color(0xff9CA3AF), fontSize: 14, fontWeight: FontWeight.w400),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xffE5E7EB), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xffE5E7EB), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xffE5E7EB), width: 1),
              ),
            ),
          ),
          // const SizedBox(height: 12),
          // Row(
          //   children: [
          //     Expanded(
          //       child: _MenuButton<EmployeeStatusFilter>(
          //         title: 'حسب الحالة',
          //         selectedValueLabel: employeeStatusFilterLabel(statusFilter),
          //         icon: Icons.filter_alt_rounded,
          //         values: const <EmployeeStatusFilter>[EmployeeStatusFilter.all, EmployeeStatusFilter.active, EmployeeStatusFilter.inactive],
          //         labelBuilder: employeeStatusFilterLabel,
          //         onSelected: onStatusChanged,
          //       ),
          //     ),
          //     const SizedBox(width: 8),
          //     Expanded(
          //       child: _MenuButton<EmployeeSortBy>(
          //         title: 'ترتيب',
          //         selectedValueLabel: employeeSortByLabel(sortBy),
          //         icon: Icons.sort,
          //         values: const <EmployeeSortBy>[EmployeeSortBy.latest, EmployeeSortBy.oldest, EmployeeSortBy.nameAsc],
          //         labelBuilder: employeeSortByLabel,
          //         onSelected: onSortChanged,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

/*
class _MenuButton<T> extends StatelessWidget {
  const _MenuButton({
    required this.title,
    required this.selectedValueLabel,
    required this.icon,
    required this.values,
    required this.labelBuilder,
    required this.onSelected,
  });

  final String title;
  final String selectedValueLabel;
  final IconData icon;
  final List<T> values;
  final String Function(T value) labelBuilder;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      onSelected: onSelected,
      padding: EdgeInsets.zero,
      itemBuilder: (context) {
        return values.map((value) => PopupMenuItem<T>(value: value, child: AppText.bodyMedium(labelBuilder(value)))).toList();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xffE5E7EB), width: 1),
          color: const Color(0xFFF9FAFB),
        ),
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xff374151), size: 16),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText.labelLarge(title, color: const Color(0xff374151), fontWeight: FontWeight.bold),
                  AppText.labelSmall(selectedValueLabel, color: const Color(0xff6B7280), fontWeight: FontWeight.w500),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
