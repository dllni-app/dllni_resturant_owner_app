import 'dart:convert';
import 'dart:io';

import 'package:common_package/common_package.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'products_style_tokens.dart';

class ProductPickMainImage extends StatefulWidget {
  const ProductPickMainImage({super.key, required this.onPickImage, this.image64});

  final void Function(String imagePath) onPickImage;

  final String? image64;

  @override
  State<ProductPickMainImage> createState() => _ProductPickMainImageState();
}

class _ProductPickMainImageState extends State<ProductPickMainImage> {
  String? imagePath;

  String? image64;

  @override
  void initState() {
    super.initState();
    image64 = widget.image64;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'صورة رئيسية',
          textAlign: TextAlign.start,
          style: TextStyle(color: ProductsStyleTokens.textMid, fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        if (image64 == null) ...{
          if (imagePath != null)
            InkWell(
              onTap: _pickImage,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Image.file(File(imagePath!), width: double.infinity, height: 188, fit: BoxFit.cover),
              ),
            )
          else
            InkWell(
              onTap: _pickImage,
              child: DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  dashPattern: const [8, 8],
                  strokeWidth: 1.5,
                  color: const Color(0x332F2B3D),
                  radius: const Radius.circular(16),
                ),
                child: Container(
                  width: double.infinity,
                  height: 190,
                  decoration: const BoxDecoration(color: ProductsStyleTokens.fieldBackground, borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined, size: 20, color: ProductsStyleTokens.textHint),
                      const SizedBox(height: 8),
                      AppText(
                        'اضغط لرفع صورة',
                        style: TextStyle(color: ProductsStyleTokens.textLow, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      AppText('PNG, JPG حتى 5MB', style: TextStyle(color: ProductsStyleTokens.textHint, fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ),
        } else ...{
          InkWell(
            onTap: _pickImage,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Image.memory(base64Decode(image64!), width: double.infinity, height: 188, fit: BoxFit.cover),
            ),
          ),
        },
      ],
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      imagePath = pickedImage.path;
    });
    widget.onPickImage(pickedImage.path);
  }
}

class ProductPickAdditionalImages extends StatefulWidget {
  const ProductPickAdditionalImages({super.key, required this.onPickImage, required this.numOfImages});

  final void Function(List<String> imagesPath) onPickImage;
  final int numOfImages;

  @override
  State<ProductPickAdditionalImages> createState() => _ProductPickAdditionalImagesState();
}

class _ProductPickAdditionalImagesState extends State<ProductPickAdditionalImages> {
  final List<String> imagesPath = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'معرض صور إضافية',
          textAlign: TextAlign.start,
          style: TextStyle(color: ProductsStyleTokens.textMid, fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
          itemCount: widget.numOfImages,
          itemBuilder: (_, index) {
            if (index < imagesPath.length) {
              return InkWell(
                onTap: () => _replaceImage(index),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Image.file(File(imagesPath[index]), fit: BoxFit.cover),
                ),
              );
            }

            if (index == imagesPath.length) {
              return InkWell(
                onTap: _addImage,
                child: DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    dashPattern: const [6, 6],
                    strokeWidth: 1.2,
                    color: const Color(0x332F2B3D),
                    radius: const Radius.circular(12),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(color: ProductsStyleTokens.fieldBackground, borderRadius: BorderRadius.all(Radius.circular(12))),
                    alignment: Alignment.center,
                    child: const Icon(Icons.add_rounded, color: ProductsStyleTokens.textLow),
                  ),
                ),
              );
            }

            return Container(
              decoration: BoxDecoration(
                color: ProductsStyleTokens.fieldBackground,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: ProductsStyleTokens.lineLight),
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> _addImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      imagesPath.add(pickedImage.path);
    });
    widget.onPickImage(imagesPath);
  }

  Future<void> _replaceImage(int index) async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      imagesPath[index] = pickedImage.path;
    });
    widget.onPickImage(imagesPath);
  }
}
