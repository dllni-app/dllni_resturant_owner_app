import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import 'products_style_tokens.dart';

class ProductTextField extends StatelessWidget {
  const ProductTextField({
    super.key,
    required this.title,
    this.hintText,
    this.controller,
    this.readOnly = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
  });

  final String title;
  final String? hintText;
  final int maxLines;
  final bool readOnly;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: ProductsStyleTokens.textMid,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.42,
          ),
        ),
        TextField(
          maxLines: maxLines,
          readOnly: readOnly,
          controller: controller,
          keyboardType: keyboardType,
          textAlign: TextAlign.start,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          style: const TextStyle(
            color: Color(0xE52F2B3D),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: ProductsStyleTokens.fieldBackground,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: ProductsStyleTokens.textHint,
              fontSize: 14,
            ),
            contentPadding: const EdgeInsetsDirectional.fromSTEB(
              14,
              12,
              14,
              12,
            ),
            border: ProductsStyleTokens.fieldBorder(),
            enabledBorder: ProductsStyleTokens.fieldBorder(),
            focusedBorder: ProductsStyleTokens.fieldBorder(),
          ),
        ),
      ],
    );
  }
}

class ProductMenuField<T> extends StatelessWidget {
  const ProductMenuField({
    super.key,
    required this.title,
    this.hintText,
    this.value,
    this.onChanged,
    required this.items,
  });

  final String title;
  final String? hintText;
  final T? value;
  final void Function(T? value)? onChanged;
  final List<DropdownMenuItem<T>> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: ProductsStyleTokens.textMid,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.42,
          ),
        ),
        DropdownButtonFormField<T>(
          initialValue: value,
          items: items,
          onChanged: onChanged,
          style: const TextStyle(
            color: Color(0xE52F2B3D),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          hint: AppText(
            hintText ?? '',
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontFamily: 'Cairo',
              color: ProductsStyleTokens.textHint,
              fontSize: 14,
            ),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: ProductsStyleTokens.fieldBackground,
            contentPadding: const EdgeInsetsDirectional.fromSTEB(
              14,
              10,
              14,
              10,
            ),
            border: ProductsStyleTokens.fieldBorder(),
            enabledBorder: ProductsStyleTokens.fieldBorder(),
            focusedBorder: ProductsStyleTokens.fieldBorder(),
          ),
        ),
      ],
    );
  }
}
