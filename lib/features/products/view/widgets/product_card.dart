import 'dart:math';
import 'dart:ui';

import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';
import '../../data/models/fetch_products_model.dart';
import 'app_switch.dart';
import 'products_style_tokens.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});

  final FetchProductsModelDataItem product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late bool enabled;

  @override
  void initState() {
    super.initState();
    enabled = widget.product.isAvailable ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: !enabled ? 0.65 : 1,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ProductsStyleTokens.cardBackground,
          borderRadius: ProductsStyleTokens.cardRadius24,
          // border: Border.all(color: limited ? ProductsStyleTokens.warning : ProductsStyleTokens.lineCard, width: limited ? 1.2 : 1),
          boxShadow: const [ProductsStyleTokens.cardShadow],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProductImage(unavailable: !enabled, limited: !enabled, quantity: widget.product.stockQuantity!),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 96,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(top: 2, bottom: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppText(
                              widget.product.name ?? '-',
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 28 / 2,
                                fontWeight: FontWeight.w700,
                                color: ProductsStyleTokens.textHigh,
                                height: 1.25,
                              ),
                            ),
                          ),
                          const Icon(Icons.more_vert, size: 18, color: Color(0xFFCACACA)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      if (enabled) AvailabilityChip(isAvailable: enabled) else const SizedBox(height: 18),
                      const Spacer(),
                      Row(
                        children: [
                          AppText(
                            widget.product.price.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: ProductsStyleTokens.primaryAction,
                              fontSize: 26 / 2,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(width: 4),
                          AppText(
                            'ل.س',
                            textAlign: TextAlign.start,
                            style: TextStyle(color: ProductsStyleTokens.textHint, fontSize: 11, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          AppSwitch(
                            value: enabled,
                            onChanged: (value) {
                              setState(() {
                                enabled = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.unavailable, required this.limited, required this.quantity});

  final bool unavailable;
  final bool limited;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      child: SizedBox(
        width: 96,
        height: 96,
        child: Stack(
          children: [
            AppImage.asset(Assets.imagesTestBurger, fit: BoxFit.cover),
            if (unavailable)
              Container(
                alignment: Alignment.center,
                color: const Color(0x99000000),
                child: const Text(
                  'غير متوفر',
                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ),
            if (limited)
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 96,
                    height: 20,
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 2),
                    color: const Color(0xCCFF4C51),
                    alignment: Alignment.center,
                    child: Text(
                      'باقي $quantity فقط',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700, height: 1.5),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class AvailabilityChip extends StatelessWidget {
  const AvailabilityChip({super.key, required this.isAvailable});

  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isAvailable ? ProductsStyleTokens.successSoft : const Color(0x292F2B3D),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Text(
        isAvailable ? 'متوفر' : 'غير متوفر',
        style: TextStyle(
          color: isAvailable ? ProductsStyleTokens.success : const Color(0xFF6B7280),
          fontSize: 10,
          fontWeight: FontWeight.w700,
          height: 1.5,
        ),
      ),
    );
  }
}
