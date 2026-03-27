import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import 'products_style_tokens.dart';

class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: context.pop,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: ProductsStyleTokens.fieldBackground,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(
            color: ProductsStyleTokens.titleColor.withAlpha(32),
          ),
        ),
        child: const Icon(
          Icons.arrow_forward_rounded,
          color: ProductsStyleTokens.titleColor,
          size: 22,
        ),
      ),
    );
  }
}
