import 'package:flutter/material.dart';

import 'products_style_tokens.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.onChanged,
    required this.hintText,
  });

  final void Function(String value) onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ProductsStyleTokens.textMid,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: ProductsStyleTokens.textHint,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: ProductsStyleTokens.textHint,
            size: 20,
          ),
          contentPadding: const EdgeInsetsDirectional.fromSTEB(14, 12, 14, 12),
          filled: true,
          fillColor: ProductsStyleTokens.fieldBackground,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            borderSide: BorderSide(color: ProductsStyleTokens.lineLight),
          ),
        ),
      ),
    );
  }
}
