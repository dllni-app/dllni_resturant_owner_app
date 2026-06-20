import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/widgets/app_pickers.dart';
import 'package:flutter/material.dart';

class CreateCouponDurationCard extends StatefulWidget {
  const CreateCouponDurationCard({super.key, required this.startsAtController, required this.endsAtController});

  final TextEditingController startsAtController;
  final TextEditingController endsAtController;

  @override
  State<CreateCouponDurationCard> createState() => _CreateCouponDurationCardState();
}

class _CreateCouponDurationCardState extends State<CreateCouponDurationCard> {
  Future<void> _pickDate(TextEditingController controller) async {
    final picked = await AppPickers.showAppDatePicker(context: context);
    if (picked.trim().isEmpty) return;
    controller.text = picked;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFFDE68A))),
          child: Row(
            children: [
              const Icon(Icons.info_outline_rounded, color: Color(0xFF92400E), size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: AppText.bodyMedium('تاريخ البداية والنهاية اختياريان، يمكنك تركهما فارغين', fontWeight: FontWeight.w500, color: const Color(0xFF92400E)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildDateField(
          title: 'تاريخ البداية',
          controller: widget.startsAtController,
          onTap: () => _pickDate(widget.startsAtController),
          onClear: () => setState(() => widget.startsAtController.clear()),
        ),
        const SizedBox(height: 16),
        _buildDateField(
          title: 'تاريخ النهاية',
          controller: widget.endsAtController,
          onTap: () => _pickDate(widget.endsAtController),
          onClear: () => setState(() => widget.endsAtController.clear()),
        ),
      ],
    );
  }

  Widget _buildDateField({required String title, required TextEditingController controller, required VoidCallback onTap, required VoidCallback onClear}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppText.bodyMedium(title, fontWeight: FontWeight.w500, color: const Color(0xFF374151)),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(8)),
              child: AppText.labelSmall('اختياري', color: const Color(0xFF6B7280), fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          style: const TextStyle(color: Color(0xB22F2B3D), fontSize: 14),
          decoration: InputDecoration(
            suffixIcon: controller.text.isEmpty
                ? const Icon(Icons.calendar_today_outlined, size: 18, color: Color(0xFF9CA3AF))
                : IconButton(icon: const Icon(Icons.close_rounded, size: 18, color: Color(0xFF9CA3AF)), onPressed: onClear),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            hintText: 'yyyy / mm / dd',
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            border: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E7EB)), borderRadius: BorderRadius.all(Radius.circular(16))),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E7EB)), borderRadius: BorderRadius.all(Radius.circular(16))),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E7EB)), borderRadius: BorderRadius.all(Radius.circular(16))),
          ),
        ),
      ],
    );
  }
}
