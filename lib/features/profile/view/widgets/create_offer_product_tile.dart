import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class CreateOfferProductTile extends StatelessWidget {
  const CreateOfferProductTile({
    super.key,
    required this.name,
    required this.category,
    required this.isSelected,
    required this.onChanged,
    this.imageAsset,
  });

  final String name;
  final String category;
  final bool isSelected;
  final ValueChanged<bool> onChanged;
  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!isSelected);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: context.onPrimary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (value) {
                onChanged(value ?? false);
              },
              activeColor: context.primary,
              side: const BorderSide(color: Color(0xFFD1D5DB)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText.bodyMedium(name, fontWeight: FontWeight.w700, color: const Color(0xFF111827)),
                  AppText.labelLarge(category, fontWeight: FontWeight.w500, color: const Color(0xFF6B7280)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
              child: imageAsset == null
                  ? const Icon(Icons.fastfood_outlined, color: Color(0xFF9CA3AF), size: 20)
                  : Center(child: AppImage.asset(imageAsset!, size: 26)),
            ),
          ],
        ),
      ),
    );
  }
}
