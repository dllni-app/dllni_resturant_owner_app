import 'dart:io';

import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/products/data/models/fetch_products_model.dart';
import 'package:dllni_resturant_owner_app/features/products/domain/usecases/fetch_categories_use_case.dart';
import 'package:dllni_resturant_owner_app/features/products/domain/usecases/fetch_products_use_case.dart';
import 'package:dllni_resturant_owner_app/features/products/domain/usecases/post_new_product_use_case.dart';
import 'package:dllni_resturant_owner_app/features/products/domain/usecases/update_product_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../manager/bloc/products_bloc.dart';
import '../widgets/add_new_product_app_bar.dart';
import '../widgets/app_buttons.dart';
import '../widgets/product_pick_images.dart';
import '../widgets/product_text_field.dart';
import '../widgets/products_style_tokens.dart';

@AutoRoutePage(path: '/products/new_product/details')
class AddProductDetailsScreen extends StatelessWidget {
  const AddProductDetailsScreen({super.key, required this.params});

  final AddProductDetailsScreenParams params;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsBloc>(
      create: (context) => getIt<ProductsBloc>()..add(FetchCategoriesEvent(params: FetchCategoriesParams(page: 1), isReload: true)),
      child: _AddProductDetailsBody(params: params),
    );
  }
}

class _AddProductDetailsBody extends StatefulWidget {
  const _AddProductDetailsBody({required this.params});

  final AddProductDetailsScreenParams params;

  @override
  State<_AddProductDetailsBody> createState() => _AddProductDetailsBodyState();
}

class _AddProductDetailsBodyState extends State<_AddProductDetailsBody> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _discountedPriceController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _preparationTimeController = TextEditingController();
  final TextEditingController _lowStockController = TextEditingController();
  int? _selectedCategoryId;
  String? _existingPrimaryImageUrl;

  List<File> images = [];
  File? primaryImage;

  bool get _isEditMode => widget.params.existingProduct != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.params.existingProduct;
    _nameController.text = widget.params.title ?? existing?.name ?? '';
    _descriptionController.text = widget.params.desc ?? existing?.description ?? '';
    _priceController.text = _formatNum(existing?.price);
    _discountedPriceController.text = _formatNum(existing?.discountedPrice);
    _preparationTimeController.text = _formatNum(existing?.preparationTime);
    _lowStockController.text = _formatNum(existing?.lowStockThreshold);
    _selectedCategoryId = existing?.categoryId;
    _existingPrimaryImageUrl = widget.params.existingImageUrl ?? existing?.primaryImage;
  }

  String _formatNum(num? value) {
    if (value == null) return '';
    final asDouble = value.toDouble();
    if (asDouble == asDouble.toInt()) return asDouble.toInt().toString();
    return asDouble.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _discountedPriceController.dispose();
    _priceController.dispose();
    _preparationTimeController.dispose();
    _lowStockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProductsStyleTokens.pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            const AddNewProductAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 24),
                child: Column(
                  children: [
                    _ProductStepDetails(
                      number: 1,
                      title: 'المعلومات الأساسية',
                      child: Column(
                        children: [
                          ProductTextField(title: 'اسم المنتج', hintText: 'مثال: برجر دجاج كلاسيك', controller: _nameController),
                          const SizedBox(height: 16),
                          ProductTextField(
                            title: 'وصف المنتج',
                            hintText: 'وصف مكونات المنتج ومميزاته...',
                            maxLines: 4,
                            controller: _descriptionController,
                          ),
                          const SizedBox(height: 16),
                          BlocBuilder<ProductsBloc, ProductsState>(
                            builder: (context, state) {
                              final categoriesState = state.categories!;
                              final categories = categoriesState.list.where((item) => item.id != null).toList();
                              final isLoading = categoriesState.isLoading;
                              final isFailed = categoriesState.isFailed;
                              final isEmpty = categoriesState.isEmpty;

                              final items = categories.map((item) => DropdownMenuItem<int>(value: item.id!, child: Text(item.name ?? ''))).toList();
                              final canSelect = items.isNotEmpty;
                              final selectedCategoryValue = items.any((item) => item.value == _selectedCategoryId) ? _selectedCategoryId : null;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProductMenuField<int>(
                                    title: 'التصنيف',
                                    value: selectedCategoryValue,
                                    hintText: isLoading
                                        ? 'جاري تحميل التصنيفات...'
                                        : isEmpty
                                        ? 'لا توجد تصنيفات'
                                        : 'اختر تصنيف...',
                                    onChanged: canSelect
                                        ? (value) {
                                            setState(() {
                                              _selectedCategoryId = value;
                                            });
                                          }
                                        : null,
                                    items: canSelect
                                        ? items
                                        : [
                                            DropdownMenuItem<int>(
                                              enabled: false,
                                              child: Text(
                                                isLoading
                                                    ? 'جاري التحميل...'
                                                    : isFailed
                                                    ? 'تعذر تحميل التصنيفات'
                                                    : 'لا توجد تصنيفات حالياً',
                                              ),
                                            ),
                                          ],
                                  ),
                                  if (isFailed)
                                    Align(
                                      alignment: AlignmentDirectional.centerStart,
                                      child: TextButton(
                                        onPressed: () {
                                          context.read<ProductsBloc>().add(
                                            FetchCategoriesEvent(params: FetchCategoriesParams(page: 1), isReload: true),
                                          );
                                        },
                                        child: const Text('إعادة المحاولة'),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          ProductPickMainImage(
                            onPickImage: (imagePath) {
                              primaryImage = File(imagePath);
                              _existingPrimaryImageUrl = null;
                            },
                            image64: widget.params.image,
                            existingImageUrl: _existingPrimaryImageUrl,
                          ),
                          const SizedBox(height: 12),
                          ProductPickAdditionalImages(
                            numOfImages: 6,
                            onPickImage: (imagesPath) {
                              images = List.from(imagesPath.map((e) => File(e)));
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _ProductStepDetails(
                      number: 2,
                      title: 'التسعير',
                      child: Column(
                        children: [
                          ProductTextField(
                            title: 'السعر الأساسي',
                            hintText: '0.00',
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            suffixIcon: const Padding(
                              padding: EdgeInsetsDirectional.only(end: 12, top: 14),
                              child: Text(
                                'ل.س',
                                style: TextStyle(color: ProductsStyleTokens.textHint, fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          ProductTextField(
                            title: 'السعر بعد الحسم',
                            hintText: '0.00',
                            controller: _discountedPriceController,
                            keyboardType: TextInputType.number,
                            suffixIcon: const Padding(
                              padding: EdgeInsetsDirectional.only(end: 12, top: 14),
                              child: Text(
                                'ل.س',
                                style: TextStyle(color: ProductsStyleTokens.textHint, fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    /*_ProductStepDetails(
                      number: 3,
                      title: 'الربط بالمخزون',
                      child: Column(
                        children: const [
                          ProductTextField(
                            title: 'اسم الصنف',
                            hintText: 'ابحث في المخزون...',
                            suffixIcon: Icon(Icons.search_rounded, color: ProductsStyleTokens.textHint, size: 20),
                          ),
                          SizedBox(height: 16),
                          _InfoAlert(),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ProductTextField(title: 'الكمية المخصومة', hintText: '1', keyboardType: TextInputType.number),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ProductTextField(title: 'الوحدة', hintText: 'قطعة'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),*/
                    _ProductStepDetails(
                      number: 3,
                      title: 'تفاصيل أخرى',
                      child: Column(
                        children: [
                          ProductTextField(
                            title: 'الوقت المتوقع للتحضير',
                            hintText: '15',
                            controller: _preparationTimeController,
                            keyboardType: TextInputType.number,
                            suffixIcon: const Padding(
                              padding: EdgeInsetsDirectional.only(end: 12, top: 14),
                              child: Text(
                                'دقيقة',
                                style: TextStyle(color: ProductsStyleTokens.textHint, fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ProductTextField(
                            title: 'الحد الأدنى للطلب',
                            hintText: '1',
                            controller: _lowStockController,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: AppOutlinedButton(title: 'إلغاء', color: ProductsStyleTokens.warning, onTap: () => context.pop()),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: BlocConsumer<ProductsBloc, ProductsState>(
                            listener: (context, state) {
                              final activeStatus = _isEditMode ? state.updateProductStatus : state.newProductStatus;
                              switch (activeStatus) {
                                case null:
                                  Loading.close();
                                  break;
                                case BlocStatus.failed:
                                  Loading.close();
                                  AppToast.showToast(
                                    context: context,
                                    message: state.errorMessage ?? (_isEditMode ? 'خطا في تحديث المنتج' : 'خطا في اضافة المنتج'),
                                    type: ToastificationType.error,
                                  );
                                  break;
                                case BlocStatus.success:
                                  Loading.close();
                                  if (_isEditMode) {
                                    context.pop(true);
                                  } else {
                                    context.pushRouteAndRemoveUntil('/main', arguments: 2);
                                  }
                                  break;
                                case BlocStatus.loading:
                                  Loading.show(context);
                                  break;
                                case BlocStatus.init:
                                  Loading.close();
                                  break;
                              }
                            },
                            builder: (context, state) {
                              return AppButton(
                                title: _isEditMode ? 'تحديث المنتج' : 'نشر المنتج',
                                withShadow: false,
                                onTap: () {
                                  final categories = context.read<ProductsBloc>().state.categories?.list ?? const [];
                                  final hasPrimaryImage = primaryImage != null || ((_existingPrimaryImageUrl ?? '').trim().isNotEmpty);
                                  int? effectiveCategoryId = _selectedCategoryId;
                                  if (effectiveCategoryId == null) {
                                    for (final item in categories) {
                                      if (item.id != null) {
                                        effectiveCategoryId = item.id;
                                        break;
                                      }
                                    }
                                  }
                                  if (effectiveCategoryId == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يرجى اختيار تصنيف المنتج')));
                                    return;
                                  }
                                  if (!hasPrimaryImage) {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يرجى اختيار الصورة الرئيسية')));
                                    return;
                                  }
                                  if (_isEditMode) {
                                    final existing = widget.params.existingProduct;
                                    if (existing?.id == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تعذر تحديد المنتج المراد تحديثه')));
                                      return;
                                    }
                                    context.read<ProductsBloc>().add(
                                      UpdateProductEvent(
                                        params: UpdateProductParams(
                                          id: existing!.id!,
                                          categoryId: effectiveCategoryId,
                                          name: _nameController.text.trim(),
                                          description: _descriptionController.text,
                                          price: _priceController.text.trim(),
                                          discountedPrice: _discountedPriceController.text,
                                          isAvailable: existing.isAvailable,
                                          stockQuantity: existing.stockQuantity?.toString(),
                                          lowStockThreshold: _lowStockController.text,
                                          preparationTime: _preparationTimeController.text,
                                          isFeatured: existing.isFeatured,
                                          primaryImage: primaryImage,
                                          images: images,
                                        ),
                                        refreshParams: FetchProductsParams(
                                          categoryId: effectiveCategoryId,
                                          page: 1,
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                  context.read<ProductsBloc>().add(
                                    PostNewProductEvent(
                                      params: PostNewProductParams(
                                        name: _nameController.text,
                                        desc: _descriptionController.text,
                                        discountedPrice: _discountedPriceController.text,
                                        price: _priceController.text,
                                        preparationTime: _preparationTimeController.text,
                                        lowStock: _lowStockController.text,
                                        primaryImage: primaryImage!,
                                        images: images,
                                        categoryId: effectiveCategoryId,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
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
}

class _ProductStepDetails extends StatelessWidget {
  const _ProductStepDetails({required this.number, required this.title, required this.child});

  final int number;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(16),
      decoration: const BoxDecoration(
        color: ProductsStyleTokens.cardBackground,
        borderRadius: BorderRadius.all(Radius.circular(18)),
        border: Border.fromBorderSide(BorderSide(color: ProductsStyleTokens.lineCard)),
        boxShadow: [ProductsStyleTokens.softShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: ProductsStyleTokens.primaryAction,
                child: Text(
                  '$number',
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(color: ProductsStyleTokens.primaryAction, fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class AddProductDetailsScreenParams {
  final String? image;
  final String? title;
  final String? desc;
  final String? existingImageUrl;
  final FetchProductsModelDataItem? existingProduct;

  AddProductDetailsScreenParams({
    this.image,
    this.title,
    this.desc,
    this.existingImageUrl,
    this.existingProduct,
  });

  factory AddProductDetailsScreenParams.fromProduct(
    FetchProductsModelDataItem product,
  ) {
    return AddProductDetailsScreenParams(
      title: product.name,
      desc: product.description,
      existingImageUrl: product.primaryImage,
      existingProduct: product,
    );
  }
}
