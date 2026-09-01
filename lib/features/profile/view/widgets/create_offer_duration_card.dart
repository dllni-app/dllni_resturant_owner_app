import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  DateTime? _parse(String raw) => raw.trim().isEmpty ? null : DateTime.tryParse(raw.trim())?.toLocal();

  String _formatForController(DateTime value) => value.toUtc().toIso8601String();

  String _displayValue(String raw) {
    final value = _parse(raw);
    if (value == null) return '';
    return DateFormat('yyyy/MM/dd - HH:mm').format(value);
  }

  Future<void> _pickDateTime(TextEditingController controller) async {
    final initial = _parse(controller.text) ?? DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return;

    controller.text = _formatForController(DateTime(date.year, date.month, date.day, time.hour, time.minute));
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
                  if (value) {
                    widget.startsAtController.text = DateTime.now().toUtc().toIso8601String();
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
          title: 'تاريخ ووقت البداية',
          controller: widget.startsAtController,
          isEnabled: !widget.isImmediate,
          onTap: () => _pickDateTime(widget.startsAtController),
        ),
        const SizedBox(height: 16),
        _buildDateField(
          title: 'تاريخ ووقت النهاية',
          controller: widget.endsAtController,
          isEnabled: true,
          onTap: () => _pickDateTime(widget.endsAtController),
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
          readOnly: true,
          enabled: isEnabled,
          onTap: onTap,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          style: const TextStyle(color: Color(0xB22F2B3D), fontSize: 14),
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.event_rounded, size: 18, color: Color(0xFF9CA3AF)),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            hintText: 'yyyy/mm/dd - hh:mm',
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            border: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E7EB)), borderRadius: BorderRadius.all(Radius.circular(16))),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E7EB)), borderRadius: BorderRadius.all(Radius.circular(16))),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E7EB)), borderRadius: BorderRadius.all(Radius.circular(16))),
            disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E7EB)), borderRadius: BorderRadius.all(Radius.circular(16))),
            labelText: _displayValue(controller.text).isEmpty ? null : _displayValue(controller.text),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ],
    );
  }
}
