import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class ActivityLogFilterChips extends StatelessWidget {
  const ActivityLogFilterChips({super.key, required this.selectedLogName, required this.onChanged});

  final String? selectedLogName;
  final ValueChanged<String?> onChanged;

  static const List<({String label, String? value})> _filters = [
    (label: 'الكل', value: null),
    (label: 'الطلبات', value: 'orders'),
    (label: 'المخزون', value: 'products'),
    (label: 'العروض', value: 'offers'),
    (label: 'النظام', value: 'system'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
        itemBuilder: (context, index) {
          final item = _filters[index];
          final isSelected = item.value == selectedLogName;
          return InkWell(
            onTap: () => onChanged(item.value),
            borderRadius: BorderRadius.circular(50),
            child: Container(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? context.primary : context.onPrimary,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: isSelected ? context.primary : const Color(0xffE5E7EB)),
              ),
              child: AppText.labelLarge(item.label, color: isSelected ? context.onPrimary : const Color(0xff374151), fontWeight: FontWeight.bold),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: _filters.length,
      ),
    );
  }
}
