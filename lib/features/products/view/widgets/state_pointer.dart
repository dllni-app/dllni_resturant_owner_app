import 'package:flutter/material.dart';

import 'products_style_tokens.dart';

class StatePointer extends StatelessWidget {
  const StatePointer({
    super.key,
    required this.title,
    required this.value,
    this.isCritical = false,
  });

  final String title;
  final num value;
  final bool isCritical;

  @override
  Widget build(BuildContext context) {
    final bool showWarning = isCritical && value > 0;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: ProductsStyleTokens.cardBackground,
        borderRadius: BorderRadius.all(Radius.circular(24)),
        border: Border.fromBorderSide(
          BorderSide(color: ProductsStyleTokens.lineCard),
        ),
        boxShadow: [ProductsStyleTokens.cardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: ProductsStyleTokens.textLow,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                value.toString(),
                style: TextStyle(
                  color: showWarning
                      ? ProductsStyleTokens.warning
                      : ProductsStyleTokens.titleColor,
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
              const Spacer(),
              if (showWarning)
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: ProductsStyleTokens.warningSoft,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    size: 16,
                    color: ProductsStyleTokens.warning,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
