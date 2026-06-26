import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

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
    final stockQuantity = widget.product.stockQuantity ?? 0;
    final price = widget.product.discountedPrice ?? widget.product.price ?? 0;

    return Opacity(
      opacity: !enabled ? 0.65 : 1,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ProductsStyleTokens.cardBackground,
          borderRadius: ProductsStyleTokens.cardRadius24,
          boxShadow: const [ProductsStyleTokens.cardShadow],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProductImage(
              imageUrl: widget.product.primaryImage ?? '',
              unavailable: !enabled,
              limited: enabled && stockQuantity <= (widget.product.lowStockThreshold ?? 5),
              quantity: stockQuantity,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 96),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppText(
                            widget.product.name ?? '-',
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
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
                    AvailabilityChip(isAvailable: enabled),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        AppText(
                          _formatPrice(price),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: ProductsStyleTokens.primaryAction,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(width: 4),
                         AppText(
                          'ل.س',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: ProductsStyleTokens.textHint,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        AppSwitch(
                          value: enabled,
                          onChanged: (value) {
                            setState(() => enabled = value);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(num price) {
    if (price % 1 == 0) return price.toInt().toString();
    return price.toStringAsFixed(2);
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({
    required this.imageUrl,
    required this.unavailable,
    required this.limited,
    required this.quantity,
  });

  final String imageUrl;
  final bool unavailable;
  final bool limited;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl.trim().isNotEmpty;

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      child: Container(
        width: 96,
        height: 96,
        child: Stack(
          children: [
            if (hasImage)
              Center(
                child: AppImage.network(
                  imageUrl,
                  loadingBuilder: (context) => const Center(child: CircularProgressIndicator()),
                  failedBuilder: (context) => const Center(child: Icon(Icons.image_outlined, color: Color(0xFF9CA3AF))),
                  fit: BoxFit.cover,
                  height: 96,
                  width: 96,
                ),
              )
            else
              Container(
                color: const Color(0xFFF3F4F6),
                alignment: Alignment.center,
                child: const Icon(Icons.image_outlined, color: Color(0xFF9CA3AF)),
              ),
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
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
