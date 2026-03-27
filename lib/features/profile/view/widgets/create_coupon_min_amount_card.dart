import 'package:flutter/material.dart';

class CreateCouponMinAmountCard extends StatelessWidget {
  const CreateCouponMinAmountCard({super.key, required this.minAmountController});

  final TextEditingController minAmountController;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'الحد الأدنى لمبلغ الشراء',
          style: TextStyle(
            color: Color(0xFF374151),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.42,
          ),
        ),
        TextFormField(
          controller: minAmountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          style: const TextStyle(color: Color(0xB22F2B3D), fontSize: 14),
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: const Text('ل.س', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14)),
            ),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            hintText: '0',
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
      ],
    );
  }
}

