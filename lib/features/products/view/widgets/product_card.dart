import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../data/models/fetch_products_model.dart';
import '../../domain/usecases/delete_product_use_case.dart';
import '../../domain/usecases/fetch_products_use_case.dart';
import '../manager/bloc/products_bloc.dart';
import '../screens/add_new_product_screen.dart';
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

  Future<void> _showDeleteWarningDialog() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('سيتم حذف هذا المنتج. هل أنت متأكد؟'),
          actions: [
            TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('إلغاء')),
            TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: const Text('حذف')),
          ],
        );
      },
    );

    if (shouldDelete == true && mounted) {
      await _deleteProduct();
    }
  }

  Future<void> _deleteProduct() async {
    final productId = widget.product.id;
    if (productId == null) {
      AppToast.showToast(
        context: context,
        message: 'تعذر تحديد المنتج المراد حذفه',
        type: ToastificationType.error,
      );
      return;
    }

    final bloc = context.read<ProductsBloc>();
    Loading.show(context);
    bloc.add(
      DeleteProductEvent(
        params: DeleteProductParams(id: productId),
        refreshParams: FetchProductsParams(
          categoryId: widget.product.categoryId,
          page: 1,
        ),
      ),
    );

    final nextState = await bloc.stream.firstWhere(
      (state) =>
          state.deleteProductStatus == BlocStatus.success ||
          state.deleteProductStatus == BlocStatus.failed,
    );

    Loading.close();
    if (!mounted) return;

    if (nextState.deleteProductStatus == BlocStatus.success) {
      AppToast.showToast(
        context: context,
        message: 'تم حذف المنتج بنجاح',
        type: ToastificationType.success,
      );
      return;
    }

    AppToast.showToast(
      context: context,
      message: nextState.errorMessage ?? 'تعذر حذف المنتج',
      type: ToastificationType.error,
    );
  }

  Future<void> _onMenuActionSelected(_ProductCardMenuAction action) async {
    switch (action) {
      case _ProductCardMenuAction.edit:
        final isUpdated = await context.pushRoute<bool>(
          '/products/new_product',
          arguments: AddNewProductScreenParams(productForEdit: widget.product),
        );
        if (isUpdated == true && mounted) {
          context.read<ProductsBloc>().add(
            FetchProductsEvent(
              params: FetchProductsParams(
                categoryId: widget.product.categoryId,
                page: 1,
              ),
              isReload: true,
            ),
          );
        }
        return;
      case _ProductCardMenuAction.delete:
        await _showDeleteWarningDialog();
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: !enabled ? 0.65 : 1,
      child: Container(
        width: double.infinity,
        padding: EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: ProductsStyleTokens.cardBackground,
          borderRadius: ProductsStyleTokens.cardRadius24,
          boxShadow: const [ProductsStyleTokens.cardShadow],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProductImage(imageUrl: widget.product.primaryImage, unavailable: !enabled, limited: !enabled, quantity: widget.product.stockQuantity!),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
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
                      /*PopupMenuButton<_ProductCardMenuAction>(
                        tooltip: 'المزيد',
                        icon: const Icon(Icons.more_vert, size: 18, color: Color(0xFFCACACA)),
                        onSelected: _onMenuActionSelected,
                        itemBuilder: (context) => const [
                          PopupMenuItem<_ProductCardMenuAction>(value: _ProductCardMenuAction.edit, child: Text('تعديل')),
                          PopupMenuItem<_ProductCardMenuAction>(value: _ProductCardMenuAction.delete, child: Text('حذف')),
                        ],
                      ),*/
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (enabled) AvailabilityChip(isAvailable: enabled) else const SizedBox(height: 18),
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
          ],
        ),
      ),
    );
  }
}

enum _ProductCardMenuAction { edit, delete }

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.imageUrl, required this.unavailable, required this.limited, required this.quantity});

  final String? imageUrl;
  final bool unavailable;
  final bool limited;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final trimmed = imageUrl?.trim();
    final hasImage = trimmed != null && trimmed.isNotEmpty;

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      child: SizedBox(
        width: 96,
        height: 96,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: hasImage
                  ? AppImage.network(trimmed, fit: BoxFit.cover, width: 96, height: 96, errorWidget: const _ProductImagePlaceholder())
                  : const _ProductImagePlaceholder(),
            ),
            if (unavailable)
              Positioned.fill(
                child: Container(
                  alignment: Alignment.center,
                  color: const Color(0x99000000),
                  child: const Text(
                    'غير متوفر',
                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            if (limited)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
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

/// Light gray background with a neutral icon when there is no URL or loading fails.
class _ProductImagePlaceholder extends StatelessWidget {
  const _ProductImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFFECEFF3),
      child: Center(child: Icon(Icons.restaurant_rounded, size: 36, color: Color(0xFF9CA3AF))),
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
