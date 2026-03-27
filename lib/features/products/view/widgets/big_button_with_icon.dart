import 'package:flutter/material.dart';

import 'products_style_tokens.dart';

class BigButtonWithIcon extends StatelessWidget {
  const BigButtonWithIcon({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final Widget icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null;
    return InkWell(
      onTap: onPressed,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Opacity(
        opacity: enabled ? 1 : 0.6,
        child: Container(
          height: 52,
          decoration: const BoxDecoration(
            color: ProductsStyleTokens.primaryAction,
            borderRadius: BorderRadius.all(Radius.circular(999)),
            boxShadow: [ProductsStyleTokens.softShadow],
          ),
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconTheme(
                  data: const IconThemeData(
                    size: 16,
                    color: ProductsStyleTokens.primaryAction,
                  ),
                  child: icon,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
