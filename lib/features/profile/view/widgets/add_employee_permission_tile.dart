import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../data/models/fetch_employees_permissions_model.dart';

class AddEmployeePermissionTile extends StatelessWidget {
  const AddEmployeePermissionTile({super.key, required this.item, required this.isSelected, required this.onChanged});

  final FetchEmployeesPermissionsModelDataPermissionsItem item;
  final bool isSelected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color(0xFFF9FAFB)),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 0, vertical: 12),
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: (value) {
              onChanged(value ?? false);
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            side: const BorderSide(color: Color(0xFFD1D5DB)),
            activeColor: context.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Icon(item.icon, color: item.iconColor, size: 18),
                    // SizedBox(width: 4),
                    Expanded(
                      child: AppText.bodyMedium(item.slug!, fontWeight: FontWeight.w700, color: const Color(0xFF111827), textAlign: TextAlign.start),
                    ),
                  ],
                ),
                AppText.labelLarge('${item.desc}', fontWeight: FontWeight.w500, color: const Color(0xFF6B7280), textAlign: TextAlign.start,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
