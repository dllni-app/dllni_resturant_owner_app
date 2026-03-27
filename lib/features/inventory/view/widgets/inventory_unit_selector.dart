import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class InventoryUnitSelector extends StatelessWidget {
  const InventoryUnitSelector({super.key, required this.selectedUnit, required this.onUnitChanged, required this.customUnitController});

  final String selectedUnit;
  final ValueChanged<String> onUnitChanged;
  final TextEditingController customUnitController;

  static const List<String> _units = ['كغ', 'لتر', 'قطعة'];

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'وحدة القياس',
          style: TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500, height: 1.42),
        ),
        Row(
          children: _units.map((unit) {
            final isSelected = selectedUnit == unit;
            return Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(end: unit == _units.last ? 0 : 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () => onUnitChanged(unit),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [context.primary.withAlpha(127), context.primary],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                            )
                          : null,
                      color: isSelected ? null : const Color(0xFFFFFFFF),
                    ),
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
                    child: AppText.labelLarge(
                      unit,
                      textAlign: TextAlign.center,
                      color: isSelected ? context.onPrimary : const Color(0xFF374151),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        TextFormField(
          controller: customUnitController,
          style: const TextStyle(color: Color(0xB22F2B3D), fontSize: 14),
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color(0xFFF9FAFB),
            hintText: 'أو اكتب وحدة مخصصة',
            hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
      ],
    );
  }
}
