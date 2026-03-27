import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class CreateOfferDiscountCard extends StatefulWidget {
  const CreateOfferDiscountCard({super.key, required this.offerValueController, required this.offerTypeChanges, required this.offerType});

  final TextEditingController offerValueController;
  final Function(String value) offerTypeChanges;

  final String offerType;

  @override
  State<CreateOfferDiscountCard> createState() => _CreateOfferDiscountCardState();
}

class _CreateOfferDiscountCardState extends State<CreateOfferDiscountCard> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildDiscountTypeButton(
                context: context,
                title: 'نسبة مئوية',
                isSelected: widget.offerType == 'percentage',
                onTap: () {
                  setState(() {
                    widget.offerTypeChanges('percentage');
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildDiscountTypeButton(
                context: context,
                title: 'مبلغ ثابت',
                isSelected: widget.offerType != 'percentage',
                onTap: () {
                  setState(() {
                    widget.offerTypeChanges('fixed_amount');
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.offerType == 'percentage' ? 'قيمة الخصم %' : 'قيمة الخصم',
              style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500, height: 1.42),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: widget.offerValueController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              style: const TextStyle(color: Color(0xB22F2B3D), fontSize: 14),
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(widget.offerType == 'percentage' ? '%' : 'ل.س', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14)),
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
        ),
      ],
    );
  }

  Widget _buildDiscountTypeButton({required BuildContext context, required String title, required bool isSelected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected ? LinearGradient(colors: [context.primary, const Color(0xFF4F46E5)]) : null,
          color: isSelected ? null : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isSelected ? Colors.transparent : const Color(0xFFE5E7EB)),
        ),
        child: AppText.bodyMedium(
          title,
          textAlign: TextAlign.center,
          color: isSelected ? context.onPrimary : const Color(0xFF6B7280),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
