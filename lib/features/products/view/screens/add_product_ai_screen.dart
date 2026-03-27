import 'dart:convert';
import 'dart:io';

import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/products/domain/usecases/generate_ai_product_data_from_image_use_case.dart';
import 'package:dllni_resturant_owner_app/features/products/domain/usecases/generate_ai_product_image_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/assets.dart';
import '../manager/bloc/products_bloc.dart';
import '../widgets/add_new_product_app_bar.dart';
import '../widgets/app_buttons.dart';
import '../widgets/expanded_product_card.dart';
import '../widgets/gradient_button.dart';
import '../widgets/product_image_field.dart';
import '../widgets/product_text_field.dart';
import '../widgets/products_style_tokens.dart';
import 'add_product_details_screen.dart';

@AutoRoutePage(path: '/products/new_product/ai')
class AddProductAIScreen extends StatefulWidget {
  const AddProductAIScreen({super.key});

  @override
  State<AddProductAIScreen> createState() => _AddProductAIScreenState();
}

class _AddProductAIScreenState extends State<AddProductAIScreen> {
  late final TextEditingController productNameController;
  late final TextEditingController productDescriptionController;
  late final TextEditingController suggestedNameController;
  late final TextEditingController suggestedDescriptionController;

  bool showGeneratedPreview = false;
  bool showGeneratedSuggestions = false;
  String? uploadedImagePath;

  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController();
    productDescriptionController = TextEditingController();
    suggestedNameController = TextEditingController();
    suggestedDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    productNameController.dispose();
    productDescriptionController.dispose();
    suggestedNameController.dispose();
    suggestedDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsBloc>(
      create: (context) => getIt<ProductsBloc>(),
      child: Scaffold(
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
                      ExpandedProductCard(
                        backgroundColor: const Color(0xFFEFEBFF),
                        foregroundColor: const Color(0xFF7C5CFF),
                        title: 'توليد الصورة من الاسم',
                        subtitle: 'اكتب اسم ووصف الوجبة وسيتم اقتراح الصورة والوصف تلقائياً',
                        icon: Icons.perm_media_rounded,
                        expandedWidget: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ProductTextField(title: 'اسم المنتج', hintText: 'مثال: برجر دجاج كلاسيك', controller: productNameController),
                            const SizedBox(height: 10),
                            ProductTextField(
                              title: 'وصف المنتج',
                              hintText: 'وصف مكونات المنتج ومميزاته...',
                              controller: productDescriptionController,
                              maxLines: 4,
                            ),
                            const SizedBox(height: 14),
                            BlocBuilder<ProductsBloc, ProductsState>(
                              builder: (context, state) {
                                return GradientButton(
                                  title: 'توليد الصورة',
                                  icon: const Icon(Icons.auto_awesome_rounded),
                                  onTap: () {
                                    context.read<ProductsBloc>().add(
                                      GenerateAiProductImageEvent(
                                        params: GenerateAiProductImageParams(
                                          name: productNameController.text,
                                          description: productDescriptionController.text,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            BlocBuilder<ProductsBloc, ProductsState>(
                              builder: (context, state) {
                                if (state.generateAiProductImageStatus == BlocStatus.success) {
                                  return Column(
                                    children: [
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                AppOutlinedButton(color: const Color(0xFF00A7BC), title: 'عرض الصورة', onTap: () {}),
                                                const SizedBox(height: 8),
                                                AppButton(
                                                  withShadow: false,
                                                  title: 'الموافقة والاستمرار',
                                                  onTap: () => context.pushRoute(
                                                    '/products/new_product/details',
                                                    arguments: AddProductDetailsScreenParams(image: state.generateAiProductImage?.data?.imageBase64),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          state.generateAiProductImage?.data?.imageBase64 == null
                                              ? AppImage.asset(
                                                  Assets.imagesTestBurger,
                                                  width: 92,
                                                  height: 92,
                                                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                                                  fit: BoxFit.cover,
                                                )
                                              : ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                                  child: Image.memory(
                                                    base64Decode(state.generateAiProductImage!.data!.imageBase64!),
                                                    width: 92,
                                                    height: 92,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ],
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ExpandedProductCard(
                        backgroundColor: const Color(0xFFFFF3E6),
                        foregroundColor: const Color(0xFFEF7A00),
                        title: 'توليد الاسم من الصورة',
                        subtitle: 'قم برفع صورة لمنتجك وسيتم اقتراح اسم ووصف المنتج تلقائياً',
                        icon: Icons.text_fields_rounded,
                        expandedWidget: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ProductImageField(
                              onPickImage: (imagePath) {
                                setState(() {
                                  uploadedImagePath = imagePath;
                                });
                              },
                            ),
                            const SizedBox(height: 14),
                            BlocBuilder<ProductsBloc, ProductsState>(
                              builder: (context, state) {
                                return GradientButton(
                                  title: 'توليد الاقتراحات',
                                  icon: const Icon(Icons.auto_awesome_rounded),
                                  onTap: () {
                                    context.read<ProductsBloc>().add(
                                      GenerateAiProductDataFromImageEvent(
                                        params: GenerateAiProductDataFromImageParams(image: File(uploadedImagePath!)),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            if (uploadedImagePath != null) ...[
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'تم رفع الصورة بنجاح',
                                      style: const TextStyle(color: ProductsStyleTokens.textLow, fontSize: 12, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    child: Image.file(File(uploadedImagePath!), width: 74, height: 74, fit: BoxFit.cover),
                                  ),
                                ],
                              ),
                            ],
                            BlocBuilder<ProductsBloc, ProductsState>(
                              builder: (context, state) {
                                if (state.generateAiProductDataFromImageStatus == BlocStatus.success) {
                                  suggestedNameController.text = state.generateAiProductDataFromImage?.data?.title ?? '';
                                  suggestedDescriptionController.text = state.generateAiProductDataFromImage?.data?.description ?? '';
                                  return Column(
                                    children: [
                                      const SizedBox(height: 14),
                                      ProductTextField(title: 'اسم المنتج', controller: suggestedNameController),
                                      const SizedBox(height: 10),
                                      ProductTextField(title: 'وصف المنتج', maxLines: 5, controller: suggestedDescriptionController),
                                      const SizedBox(height: 14),
                                      AppButton(
                                        withShadow: false,
                                        title: 'الموافقة والاستمرار',
                                        onTap: () => context.pushRoute(
                                          '/products/new_product/details',
                                          arguments: AddProductDetailsScreenParams(
                                            title: state.generateAiProductDataFromImage?.data?.title,
                                            desc: state.generateAiProductDataFromImage?.data?.description,
                                          ),
                                        ),
                                      ),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
