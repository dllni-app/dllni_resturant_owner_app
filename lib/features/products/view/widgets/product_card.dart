import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/fetch_products_model.dart';
import '../../domain/usecases/delete_product_use_case.dart';
import '../../domain/usecases/fetch_products_use_case.dart';
import '../manager/bloc/products_bloc.dart';
import '../screens/add_product_details_screen.dart';
import 'app_switch.dart';
import 'products_style_tokens.dart';

enum _ProductAction { edit, delete }

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.refreshParams,
  });

  final FetchProductsModelDataItem product;
  final FetchProductsParams refreshParams;

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
  void didUpdateWidget(covariant ProductCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.product.id != widget.product.id ||
        oldWidget.product.isAvailable != widget.product.isAvailable) {
      enabled = widget.product.isAvailable ?? false;
    }
  }

  Future<void> _openEdit(BuildContext context) async {
    final didUpdate = await context.pushRoute(
      '/products/new_product/details',
      arguments: AddProductDetailsScreenParams.fromProduct(widget.product),
    );

    if (!context.mounted || didUpdate != true) return;

    context.read<ProductsBloc>().add(
      FetchProductsEvent(
        params: widget.refreshParams,
        isReload: true,
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final productId = widget.product.id;
    if (productId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر تحديد المنتج المراد حذفه')),
      );
      return;
    }

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: AppText.titleLarge('حذف المنتج', fontWeight: FontWeight.bold),
        content: AppText.bodyMedium(
          'هل أنت متأكد من حذف هذا المنتج؟ لا يمكن التراجع عن هذه العملية.',
          textAlign: TextAlign.start,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: AppText.labelLarge('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: AppText.labelLarge(
              'حذف',
              color: context.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

    if (shouldDelete != true || !context.mounted) return;

    context.read<ProductsBloc>().add(
      DeleteProductEvent(
        params: DeleteProductParams(id: productId),
        refreshParams: widget.refreshParams,
      ),
    );
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
                        PopupMenuButton<_ProductAction>(
                          icon: const Icon(
                            Icons.more_vert,
                            size: 18,
                            color: Color(0xFF6B7280),
                          ),
                          onSelected: (action) {
                            switch (action) {
                              case _ProductAction.edit:
                                _openEdit(context);
                                break;
                              case _ProductAction.delete:
                                _confirmDelete(context);
                                break;
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem<_ProductAction>(
                              value: _ProductAction.edit,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.edit_outlined,
                                    size: 18,
                                    color: Color(0xFF065F46),
                                  ),
                                  const SizedBox(width: 8),
                                  AppText.labelLarge('تعديل'),
                                ],
                              ),
                            ),
                            PopupMenuItem<_ProductAction>(
                              value: _ProductAction.delete,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.delete_outline,
                                    size: 18,
                                    color: Color(0xFFEF4444),
                                  ),
                                  const SizedBox(width: 8),
                                  AppText.labelLarge('حذف'),
                                ],
                              ),
                            ),
                          ],
                        ),
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
