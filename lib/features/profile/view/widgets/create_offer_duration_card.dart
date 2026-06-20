import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/widgets/app_pickers.dart';
import 'package:flutter/material.dart';

import '../../../products/view/widgets/app_switch.dart';

class CreateOfferDurationCard extends StatefulWidget {
  const CreateOfferDurationCard({super.key, required this.startsAtController, required this.endsAtController, required this.isImmediate, required this.changeIsImmediate});

  final TextEditingController startsAtController;
  final TextEditingController endsAtController;
  final bool isImmediate;
  final Function(bool val) changeIsImmediate;

  @override
  State<CreateOfferDurationCard> createState() => _CreateOfferDurationCardState();
}

class _CreateOfferDurationCardState extends State<CreateOfferDurationCard> {
  Future<void> _pickDate(TextEditingController controller) async {
    final value = await AppPickers.showAppDatePicker(context: context);
    if (value.trim().isEmpty) return;
    controller.text = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDF4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD1FAE5)),
          ),
          child: Row(
            children: [
              const Icon(Icons.bolt, color: Color(0xFF065F46), size: 18),
              const SizedBox(width: 6),
              AppText.bodyMedium('تفعيل فوري', fontWeight: FontWeight.w700, color: const Color(0xFF065F46)),
              const Spacer(),
              AppSwitch(
                value: widget.isImmediate,
                onChanged: (value) {
                  widget.changeIsImmediate(value);
                  if (value && widget.startsAtController.text.trim().isEmpty) {
                    widget.startsAtController.text = DateTime.now().toIso8601String().split('T').first;
                  }
                  setState(() {});
                },
                inactiveColor: const Color(0xFFD1D5DB),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildDateField(
          title: 'تاريخ البداية',
          controller: widget.startsAtController,
          isEnabled: true,
          onTap: () => _pickDate(widget.startsAtController),
        ),
        const SizedBox(height: 16),
        _buildDateField(
          title: 'تاريخ النهاية',
          controller: widget.endsAtController,
          isEnabled: true,
          onTap: () => _pickDate(widget.endsAtController),
        ),
      ],
    );
  }

  Widget _buildDateField({required String title, required TextEditingController controller, required bool isEnabled, required VoidCallback onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.bodyMedium(title, fontWeight: FontWeight.w500, color: const Color(0xFF374151)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: true,
          enabled: isEnabled,
          onTap: onTap,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          style: const TextStyle(color: Color(0xB22F2B3D), fontSize: 14),
          decoration: const InputDecoration(
            suffixIcon: Icon(Icons.calendar_today_outlined, size: 18, color: Color(0xFF9CA3AF)),
            filled: true,
            fillColor: Color(0xFFF9FAFB),
            hintText: 'yyyy / mm / dd',
            hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E7EB)), borderRadius: BorderRadius.all(Radius.circular(16))),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E7EB)), borderRadius: BorderRadius.all(Radius.circular(16))),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E7EB)), borderRadius: BorderRadius.all(Radius.circular(16))),
            disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E7EB)), borderRadius: BorderRadius.all(Radius.circular(16))),
          ),
        ),
      ],
    );
  }
}
