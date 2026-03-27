import 'package:flutter/material.dart';

import 'products_style_tokens.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.title,
    this.icon,
    this.spacing = 8,
    this.onTap,
  });

  final String title;
  final Widget? icon;
  final double spacing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onTap != null;
    return InkWell(
      onTap: onTap,
      borderRadius: ProductsStyleTokens.buttonRadius,
      child: Opacity(
        opacity: enabled ? 1 : 0.7,
        child: Container(
          width: double.infinity,
          height: 44,
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            borderRadius: ProductsStyleTokens.buttonRadius,
            gradient: ProductsStyleTokens.actionGradient,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                IconTheme(
                  data: const IconThemeData(color: Colors.white, size: 16),
                  child: icon!,
                ),
                SizedBox(width: spacing),
              ],
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18 / 1.3,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
