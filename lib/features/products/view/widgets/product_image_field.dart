import 'dart:io';

import 'package:common_package/common_package.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'products_style_tokens.dart';

class ProductImageField extends StatefulWidget {
  const ProductImageField({super.key, required this.onPickImage});

  final void Function(String imagePath) onPickImage;

  @override
  State<ProductImageField> createState() => _ProductImageFieldState();
}

class _ProductImageFieldState extends State<ProductImageField> {
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        AppText(
          'صورة المنتج',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: ProductsStyleTokens.textMid,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            if (imagePath != null)
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Image.file(
                  File(imagePath!),
                  width: 98,
                  height: 98,
                  fit: BoxFit.cover,
                ),
              ),
            if (imagePath != null) const SizedBox(width: 8),
            Expanded(
              child: InkWell(
                onTap: _pickImage,
                child: DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    dashPattern: const [8, 8],
                    strokeWidth: 1.5,
                    color: const Color(0x332F2B3D),
                    radius: const Radius.circular(16),
                  ),
                  child: Container(
                    height: 56,
                    decoration: const BoxDecoration(
                      color: ProductsStyleTokens.fieldBackground,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.upload_rounded,
                          size: 16,
                          color: Color(0xFF065F46),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'اضغط لرفع صورة',
                          style: TextStyle(
                            color: ProductsStyleTokens.textLow,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
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
    widget.onPickImage(pickedImage.path);
  }
}
