import 'dart:io';

import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/products/domain/usecases/fetch_categories_use_case.dart';
import 'package:dllni_resturant_owner_app/features/products/domain/usecases/generate_ai_product_data_from_menu_use_case.dart';
import 'package:dllni_resturant_owner_app/features/products/domain/usecases/post_products_from_menu_use_case.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

import '../../data/models/generate_ai_product_data_from_menu_model.dart';
import '../manager/bloc/products_bloc.dart';
import '../widgets/add_new_product_app_bar.dart';
import '../widgets/app_buttons.dart';
import '../widgets/gradient_button.dart';
import '../widgets/product_text_field.dart';
import '../widgets/products_style_tokens.dart';

@AutoRoutePage(path: '/products/new_product/menu')
class AddProductMenuScreen extends StatefulWidget {
  const AddProductMenuScreen({super.key});

  @override
  State<AddProductMenuScreen> createState() => _AddProductMenuScreenState();
}

class _AddProductMenuScreenState extends State<AddProductMenuScreen> {
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsBloc>(
      create: (context) => getIt<ProductsBloc>()
        ..add(
          FetchCategoriesEvent(
            params: FetchCategoriesParams(page: 1),
            isReload: true,
          ),
        ),
      child: BlocListener<ProductsBloc, ProductsState>(
        listenWhen: (previous, current) =>
            previous.generateAiProductDataFromMenuStatus !=
                current.generateAiProductDataFromMenuStatus ||
            previous.postProductsFromMenuStatus !=
                current.postProductsFromMenuStatus,
        listener: (context, state) {
          if (state.generateAiProductDataFromMenuStatus == BlocStatus.failed) {
            AppToast.showToast(
              context: context,
              message: state.errorMessage ?? 'حدث خطأ أثناء تحليل الصورة',
              type: ToastificationType.error,
            );
          }

          if (state.postProductsFromMenuStatus == BlocStatus.failed) {
            AppToast.showToast(
              context: context,
              message: state.errorMessage ?? 'حدث خطأ أثناء إضافة المنتجات',
              type: ToastificationType.error,
            );
          }

          if (state.postProductsFromMenuStatus == BlocStatus.success) {
            final createdCount = state.postProductsFromMenuResult?.createdCount;
            AppToast.showToast(
              context: context,
              message: createdCount == null
                  ? 'تمت إضافة المنتجات للقائمة بنجاح'
                  : 'تمت إضافة $createdCount منتجات للقائمة بنجاح',
              type: ToastificationType.success,
            );
            context.pushRouteAndRemoveUntil('/main', arguments: 2);
          }
        },
        child: Scaffold(
          backgroundColor: ProductsStyleTokens.pageBackground,
          body: SafeArea(
            child: Column(
              children: [
                const AddNewProductAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsetsDirectional.only(start: 24, end: 24),
                    child: Column(
                      children: [
                        _buildUploaderCard(),
                        BlocBuilder<ProductsBloc, ProductsState>(
                          builder: (context, state) {
                            if (state.generateAiProductDataFromMenuStatus ==
                                BlocStatus.success) {
                              return state
                                          .generateAiProductDataFromMenu
                                          ?.data
                                          ?.items
                                          ?.isNotEmpty ==
                                      true
                                  ? Column(
                                      children: [
                                        const SizedBox(height: 16),
                                        ListView.separated(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: state
                                              .generateAiProductDataFromMenu!
                                              .data!
                                              .items!
                                              .length,
                                          padding: EdgeInsets.zero,
                                          separatorBuilder: (_, _) =>
                                              const SizedBox(height: 12),
                                          itemBuilder: (context, index) =>
                                              _NewProductCard(
                                                state
                                                    .generateAiProductDataFromMenu!
                                                    .data!
                                                    .items![index],
                                              ),
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: AppText.labelLarge(
                                        'لم يتم العثور على منتجات، يمكنك إضافة المنتجات يدوياً',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    if (state.generateAiProductDataFromMenuStatus ==
                        BlocStatus.success) {
                      final isSubmitting =
                          state.postProductsFromMenuStatus == BlocStatus.loading;
                      return Column(
                        children: [
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 24,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: AppButton(
                                    title: isSubmitting
                                        ? 'جاري الإضافة...'
                                        : 'إضافة للقائمة',
                                    isLoading: isSubmitting,
                                    onTap: isSubmitting
                                        ? null
                                        : () => _submitProductsFromMenu(
                                              context,
                                              state,
                                            ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                AppOutlinedButton(
                                  title: 'إلغاء',
                                  color: const Color(0xFFFF4C51),
                                  onTap: isSubmitting
                                      ? null
                                      : () {
                                          context.pop();
                                        },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploaderCard() {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'رفع صورة المنيو',
                style: TextStyle(
                  color: ProductsStyleTokens.textHigh,
                  fontSize: 24 / 1.4,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'قم برفع صورة المنيو ليتم استخراج المنتجات تلقائياً',
                style: TextStyle(
                  color: ProductsStyleTokens.textHint,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(child: _uploadTile()),
                  if (imagePath != null) ...[
                    const SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: Image.file(
                        File(imagePath!),
                        width: 130,
                        height: 190,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  final isAnalyzing =
                      state.generateAiProductDataFromMenuStatus ==
                      BlocStatus.loading;
                  return GradientButton(
                    title: isAnalyzing ? 'جاري تحليل الصورة...' : 'تحليل الصورة',
                    icon: isAnalyzing
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Icon(Icons.auto_awesome_rounded),
                    onTap: isAnalyzing
                        ? null
                        : () {
                            if (imagePath == null) {
                              AppToast.showToast(
                                context: context,
                                message: 'اختر صورة مناسبة',
                                type: ToastificationType.error,
                              );
                              return;
                            }
                            context.read<ProductsBloc>().add(
                                  GenerateAiProductDataFromMenuEvent(
                                    params:
                                        GenerateAiProductDataFromMenuParams(
                                      image: File(imagePath!),
                                      locale: _resolveAiLocale(context),
                                    ),
                                  ),
                                );
                          },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _uploadTile() {
    return InkWell(
      onTap: _pickImage,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: const [8, 8],
          strokeWidth: 1.5,
          color: const Color(0x332F2B3D),
          radius: const Radius.circular(16),
        ),
        child: Container(
          height: 190,
          width: context.width,
          decoration: const BoxDecoration(
            color: ProductsStyleTokens.fieldBackground,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt_rounded,
                size: 22,
                color: ProductsStyleTokens.textHint,
              ),
              SizedBox(height: 8),
              Text(
                'اضغط لرفع صورة',
                style: TextStyle(
                  color: ProductsStyleTokens.textLow,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'PNG, JPG حتى 5MB',
                style: TextStyle(
                  color: ProductsStyleTokens.textHint,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) return;
    setState(() {
      imagePath = pickedImage.path;
    });
  }

  void _submitProductsFromMenu(BuildContext context, ProductsState state) {
    final currentImagePath = imagePath;
    if (currentImagePath == null) {
      AppToast.showToast(
        context: context,
        message: 'اختر صورة مناسبة',
        type: ToastificationType.error,
      );
      return;
    }

    final categoriesState = state.categories;
    if (categoriesState?.isLoading == true) {
      AppToast.showToast(
        context: context,
        message: 'جاري تحميل التصنيفات، يرجى الانتظار',
        type: ToastificationType.warning,
      );
      return;
    }

    final categoryId = categoriesState?.list
        .where((category) => category.id != null)
        .map((category) => category.id!)
        .firstOrNull;

    if (categoryId == null) {
      AppToast.showToast(
        context: context,
        message: 'لا توجد تصنيفات متاحة لإضافة المنتجات',
        type: ToastificationType.error,
      );
      return;
    }

    final extractedItems =
        state.generateAiProductDataFromMenu?.data?.items ?? const [];
    final products = <PostProductFromMenuParams>[];

    for (final product in extractedItems) {
      final title = (product.title ?? '').trim();
      if (title.isEmpty) continue;
      products.add(
        PostProductFromMenuParams(
          title: title,
          description: (product.description ?? '').trim(),
        ),
      );
    }

    if (products.isEmpty) {
      AppToast.showToast(
        context: context,
        message: 'لم يتم العثور على منتجات صالحة للإضافة',
        type: ToastificationType.error,
      );
      return;
    }

    context.read<ProductsBloc>().add(
          PostProductsFromMenuEvent(
            params: PostProductsFromMenuParams(
              categoryId: categoryId,
              image: File(currentImagePath),
              products: products,
            ),
          ),
        );
  }

  String? _resolveAiLocale(BuildContext context) {
    final languageCode = Localizations.localeOf(
      context,
    ).languageCode.toLowerCase();
    if (languageCode == 'ar' || languageCode == 'en') {
      return languageCode;
    }
    return null;
  }
}

class _NewProductCard extends StatelessWidget {
  const _NewProductCard(this.product);

  final GenerateAiProductDataFromMenuModelDataItemsItem product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(14),
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
          Row(
            children: [
              Expanded(
                child: ProductTextField(
                  title: 'اسم المنتج',
                  hintText: product.title,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ProductTextField(
            maxLines: 3,
            title: 'وصف المنتج',
            hintText: product.description,
          ),
        ],
      ),
    );
  }
}
