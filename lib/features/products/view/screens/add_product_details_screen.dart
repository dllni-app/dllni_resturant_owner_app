import 'dart:io';

import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/products/domain/usecases/fetch_categories_use_case.dart';
import 'package:dllni_resturant_owner_app/features/products/domain/usecases/post_new_product_use_case.dart';
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

  List<File> images = [];
  File? primaryImage;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.params.title ?? '';
    _descriptionController.text = widget.params.desc ?? '';
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

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProductMenuField<int>(
                                    title: 'التصنيف',
                                    hintText: isLoading
                                        ? 'جاري تحميل التصنيفات...'
                                        : isEmpty
                                        ? 'لا توجد تصنيفات'
                                        : 'اختر تصنيف...',
                                    onChanged: canSelect
                                        ? (value) {
                                            _selectedCategoryId = value;
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
                            },
                            image64: widget.params.image,
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
                              switch (state.newProductStatus) {
                                case null:
                                  Loading.close();
                                  break;
                                case BlocStatus.failed:
                                  Loading.close();
                                  AppToast.showToast(
                                    context: context,
                                    message: state.errorMessage ?? 'خطا في اضافة المنتج',
                                    type: ToastificationType.error,
                                  );
                                  break;
                                case BlocStatus.success:
                                  Loading.close();
                                  context.pushRouteAndRemoveUntil('/main', arguments: 2);
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
                                title: 'نشر المنتج',
                                withShadow: false,
                                onTap: () {
                                  final categories = context.read<ProductsBloc>().state.categories?.list ?? const [];
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
                                  if (primaryImage == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يرجى اختيار الصورة الرئيسية')));
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

  AddProductDetailsScreenParams({this.image, this.title, this.desc});
}
