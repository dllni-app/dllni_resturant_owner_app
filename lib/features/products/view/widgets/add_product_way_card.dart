import 'package:flutter/material.dart';

import 'products_style_tokens.dart';

class AddProductWayCard extends StatelessWidget {
  const AddProductWayCard({
    super.key,
    required this.onTap,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.hint,
  });

  final VoidCallback onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final String title;
  final String subtitle;
  final IconData icon;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: ProductsStyleTokens.cardRadius16,
      child: Container(
        padding: const EdgeInsetsDirectional.all(18),
        decoration: const BoxDecoration(
          color: ProductsStyleTokens.cardBackground,
          borderRadius: ProductsStyleTokens.cardRadius16,
          border: Border.fromBorderSide(
            BorderSide(color: ProductsStyleTokens.lineCard),
          ),
          boxShadow: [ProductsStyleTokens.softShadow],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(14)),
              ),
              child: Icon(icon, size: 22, color: foregroundColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: ProductsStyleTokens.textHigh,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                          ),
                        ),
                      ),
                      if (hint != null)
                        Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(999),
                            ),
                          ),
                          child: Text(
                            hint!,
                            style: TextStyle(
                              color: foregroundColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: ProductsStyleTokens.textLow,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFD1D5DB),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
