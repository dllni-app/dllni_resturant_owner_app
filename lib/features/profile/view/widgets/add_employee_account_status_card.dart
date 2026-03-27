import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/products/view/widgets/app_switch.dart';
import 'package:flutter/material.dart';

class AddEmployeeAccountStatusCard extends StatelessWidget {
  const AddEmployeeAccountStatusCard({super.key, required this.isEnabled, required this.onToggle});

  final bool isEnabled;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color(0xFFF9FAFB)),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            children: [
              AppSwitch(value: isEnabled, onChanged: onToggle, inactiveColor: const Color(0xFFD1D5DB)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.bodyMedium('تفعيل الحساب', fontWeight: FontWeight.w700, color: const Color(0xFF111827)),
                    AppText.labelLarge('السماح للموظف بالدخول للنظام', color: const Color(0xFF6B7280), fontWeight: FontWeight.w500),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: isEnabled ? const Color(0xFF86EFAC) : const Color(0xFFFCA5A5)),
            color: isEnabled ? const Color(0xFFF0FDF4) : const Color(0xFFFEF2F2),
          ),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(
                isEnabled ? Icons.check_circle : Icons.info_rounded,
                color: isEnabled ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppText.labelLarge(
                  isEnabled ? 'الحساب نشط - سيتمكن الموظف من تسجيل الدخول فور الحفظ' : 'الحساب معطل - لن يتمكن الموظف من تسجيل الدخول',
                  color: isEnabled ? const Color(0xFF166534) : const Color(0xFF991B1B),
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
