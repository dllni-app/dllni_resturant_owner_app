import 'package:flutter/material.dart';

import 'products_style_tokens.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onTap,
    required this.title,
    this.withShadow = true,
  });

  final VoidCallback? onTap;
  final String title;
  final bool withShadow;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onTap != null;
    return InkWell(
      onTap: onTap,
      borderRadius: ProductsStyleTokens.buttonRadius,
      child: Container(
        alignment: Alignment.center,
        height: 44,
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: ProductsStyleTokens.buttonRadius,
          color: enabled
              ? ProductsStyleTokens.primaryActionDark
              : const Color(0x662F2B3D),
          boxShadow: enabled && withShadow
              ? const [
                  BoxShadow(
                    color: Color(0x291E2A78),
                    offset: Offset(0, 4),
                    blurRadius: 16,
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    this.onTap,
    required this.title,
    required this.color,
    this.icon,
    this.withBackground = true,
    this.height = 44,
  });

  final VoidCallback? onTap;
  final String title;
  final bool withBackground;
  final Color color;
  final IconData? icon;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: ProductsStyleTokens.buttonRadius,
      child: Container(
        alignment: Alignment.center,
        height: height,
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: ProductsStyleTokens.buttonRadius,
          color: withBackground ? color.withAlpha(18) : Colors.transparent,
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 6),
              Icon(icon, size: 12, color: color),
            ],
          ],
        ),
      ),
    );
  }
}
