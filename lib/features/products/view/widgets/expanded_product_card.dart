import 'package:flutter/material.dart';

import 'products_style_tokens.dart';

class ExpandedProductCard extends StatefulWidget {
  const ExpandedProductCard({
    super.key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.expandedWidget,
    this.initiallyExpanded = false,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget expandedWidget;
  final bool initiallyExpanded;

  @override
  State<ExpandedProductCard> createState() => _ExpandedProductCardState();
}

class _ExpandedProductCardState extends State<ExpandedProductCard> {
  late bool isOpen;

  @override
  void initState() {
    super.initState();
    isOpen = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(16),
      decoration: const BoxDecoration(
        color: ProductsStyleTokens.cardBackground,
        borderRadius: ProductsStyleTokens.cardRadius16,
        border: Border.fromBorderSide(
          BorderSide(color: ProductsStyleTokens.lineCard),
        ),
        boxShadow: [ProductsStyleTokens.softShadow],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
            borderRadius: ProductsStyleTokens.cardRadius16,
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                  ),
                  child: Icon(
                    widget.icon,
                    size: 22,
                    color: widget.foregroundColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: ProductsStyleTokens.textHigh,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          color: ProductsStyleTokens.textLow,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedRotation(
                  turns: isOpen ? 0.5 : 0,
                  duration: const Duration(milliseconds: 220),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color(0xFFD1D5DB),
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsetsDirectional.only(top: 14),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  gradient: ProductsStyleTokens.actionGradient,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 18, 12, 12),
                  decoration: const BoxDecoration(
                    color: ProductsStyleTokens.cardBackground,
                    borderRadius: BorderRadius.all(Radius.circular(28)),
                  ),
                  child: widget.expandedWidget,
                ),
              ),
            ),
            crossFadeState: isOpen
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 240),
          ),
        ],
      ),
    );
  }
}
