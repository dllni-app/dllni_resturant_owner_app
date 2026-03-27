import 'dart:io';

import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/products/domain/usecases/generate_ai_product_data_from_menu_use_case.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

import '../../../../generated/assets.dart';
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
      create: (context) => getIt<ProductsBloc>(),
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
                          if (state.generateAiProductDataFromMenuStatus == BlocStatus.success) {
                            return state.generateAiProductDataFromMenu?.data?.items?.isNotEmpty == true
                                ? Column(
                                    children: [
                                      const SizedBox(height: 16),
                                      ListView.separated(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: state.generateAiProductDataFromMenu!.data!.items!.length,
                                        padding: EdgeInsets.zero,
                                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                                        itemBuilder: (context, index) => _NewProductCard(state.generateAiProductDataFromMenu!.data!.items![index]),
                                      ),
                                    ],
                                  )
                                : Center(child: AppText.labelLarge('لم يتم العثور على نتائج', fontWeight: FontWeight.bold));
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
                  if (state.generateAiProductDataFromMenuStatus == BlocStatus.success) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              Expanded(
                                child: AppButton(title: 'إضافة للقائمة', onTap: () {}),
                              ),
                              const SizedBox(width: 12),
                              AppOutlinedButton(
                                title: 'إلغاء',
                                color: const Color(0xFFFF4C51),
                                onTap: () {
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
    );
  }

  Widget _buildUploaderCard() {
    return Container(
      padding: const EdgeInsetsDirectional.all(16),
      decoration: const BoxDecoration(
        color: ProductsStyleTokens.cardBackground,
        borderRadius: ProductsStyleTokens.cardRadius16,
        border: Border.fromBorderSide(BorderSide(color: ProductsStyleTokens.lineCard)),
        boxShadow: [ProductsStyleTokens.softShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'رفع صورة المنيو',
            style: TextStyle(color: ProductsStyleTokens.textHigh, fontSize: 24 / 1.4, fontWeight: FontWeight.w700, height: 1.3),
          ),
          const SizedBox(height: 4),
          const Text(
            'قم برفع صورة المنيو ليتم استخراج المنتجات تلقائياً',
            style: TextStyle(color: ProductsStyleTokens.textHint, fontSize: 12, fontWeight: FontWeight.w500, height: 1.4),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _uploadTile()),
              if (imagePath != null) ...[
                const SizedBox(width: 10),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Image.file(File(imagePath!), width: 130, height: 190, fit: BoxFit.cover),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              return GradientButton(
                title: 'تحليل الصورة',
                icon: const Icon(Icons.auto_awesome_rounded),
                onTap: () {
                  if (imagePath == null) {
                    AppToast.showToast(context: context, message: 'اختر صورة مناسبة', type: ToastificationType.error);
                    return;
                  }
                  context.read<ProductsBloc>().add(
                    GenerateAiProductDataFromMenuEvent(params: GenerateAiProductDataFromMenuParams(image: File(imagePath!))),
                  );
                },
              );
            },
          ),
        ],
      ),
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
          decoration: const BoxDecoration(color: ProductsStyleTokens.fieldBackground, borderRadius: BorderRadius.all(Radius.circular(16))),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt_rounded, size: 22, color: ProductsStyleTokens.textHint),
              SizedBox(height: 8),
              Text(
                'اضغط لرفع صورة',
                style: TextStyle(color: ProductsStyleTokens.textLow, fontSize: 12, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Text(
                'PNG, JPG حتى 5MB',
                style: TextStyle(color: ProductsStyleTokens.textHint, fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      imagePath = pickedImage.path;
    });
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
        border: Border.fromBorderSide(BorderSide(color: ProductsStyleTokens.lineCard)),
        boxShadow: [ProductsStyleTokens.softShadow],
      ),
      child: Column(
        children: [
          Row(
            children: [
              AppImage.asset(
                Assets.imagesTestBurger,
                width: 78,
                height: 78,
                fit: BoxFit.cover,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: ProductTextField(title: 'اسم المنتج', hintText: 'برجر دجاج كلاسيك'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const ProductTextField(
            maxLines: 3,
            title: 'وصف المنتج',
            hintText:
                'شريحة دجاج طازجة متبلة بخلطتنا الخاصة، مقلية حتى القرمشة الذهبية، تقدم مع الخس الطازج، الطماطم، وجبنة الشيدر الذائبة في خبز البريوش الطري.',
          ),
        ],
      ),
    );
  }
}
