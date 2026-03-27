import 'package:flutter/material.dart';

import 'products_style_tokens.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        alignment: Alignment.center,
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: ProductsStyleTokens.titleColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: const Icon(Icons.tune_rounded, color: Colors.white, size: 22),
      ),
    );
  }
}
