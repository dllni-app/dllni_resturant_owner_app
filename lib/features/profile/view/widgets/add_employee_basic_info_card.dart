import 'dart:io';

import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/helpers/app_image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddEmployeeBasicInfoCard extends StatefulWidget {
  const AddEmployeeBasicInfoCard({
    super.key,
    required this.nameController,
    required this.phoneController,
    this.pickedImagePath,
    this.onPickImageTap,
    required this.passwordController,
  });

  final TextEditingController nameController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
  final File? pickedImagePath;
  final Function(File image)? onPickImageTap;

  @override
  State<AddEmployeeBasicInfoCard> createState() => _AddEmployeeBasicInfoCardState();
}

class _AddEmployeeBasicInfoCardState extends State<AddEmployeeBasicInfoCard> {
  File? employeeImage;

  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    employeeImage = widget.pickedImagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _requiredLabel(title: 'صورة الموظف', required: false),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  final image = await AppImagePicker.pickSingleImage();
                  if (image != null) {
                    widget.onPickImageTap?.call(image);
                    setState(() {
                      employeeImage = image;
                    });
                  }
                },
                borderRadius: BorderRadius.circular(24),
                child: DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    radius: const Radius.circular(24),
                    strokeWidth: 2,
                    dashPattern: const [8, 4],
                    color: const Color(0xFFD1D5DB),
                  ),
                  child: Container(
                    width: context.width,
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 26),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: const Color(0xFFF9FAFB)),
                    child: Column(
                      children: const [
                        Icon(Icons.cloud_upload, color: Color(0xFF065F46)),
                        SizedBox(height: 8),
                        Text(
                          'اضغط لرفع صورة',
                          style: TextStyle(color: Color(0xFF6B7280), fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if(employeeImage != null)...{
              SizedBox(width: 12,),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.file(employeeImage!, width: 100, height: 100, fit: BoxFit.cover),
              ),
            }
          ],
        ),
        const SizedBox(height: 8),
        _infoLabel('الحد الأقصى: 5 ميجابايت'),
        const SizedBox(height: 6),
        _infoLabel('الصيغ المدعومة: JPG, PNG'),
        const SizedBox(height: 20),
        _requiredLabel(title: 'الاسم الكامل', required: true),
        const SizedBox(height: 8),
        TextField(
          controller: widget.nameController,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          style: const TextStyle(color: Color(0xB22F2B3D), fontSize: 14),
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color(0xFFF9FAFB),
            hintText: 'أدخل الاسم الكامل للموظف',
            hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _requiredLabel(title: 'رقم الهاتف', required: true),
        const SizedBox(height: 8),
        TextField(
          controller: widget.phoneController,
          keyboardType: TextInputType.phone,
          textAlign: TextAlign.end,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          style: const TextStyle(color: Color(0xB22F2B3D), fontSize: 14),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _requiredLabel(title: 'كلمة المرور', required: true),
        const SizedBox(height: 8),
        TextField(
          controller: widget.passwordController,
          keyboardType: TextInputType.visiblePassword,
          textAlign: TextAlign.start,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          style: const TextStyle(color: Color(0xB22F2B3D), fontSize: 14),
          obscureText: isVisible,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off, color: const Color(0xFF374151)),
            ),
            hintText: '**************',
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _requiredLabel({required String title, required bool required}) {
    return Row(
      children: [
        AppText.bodyMedium(title, fontWeight: FontWeight.w700, color: const Color(0xFF111827)),
        if (required) AppText.bodyMedium(' *', fontWeight: FontWeight.w700, color: const Color(0xFFEF4444)),
      ],
    );
  }

  Widget _infoLabel(String message) {
    return Row(
      children: [
        const Icon(Icons.info_rounded, color: Color(0xFF065F46), size: 16),
        const SizedBox(width: 6),
        AppText.labelLarge(message, color: const Color(0xFF6B7280), fontWeight: FontWeight.w500),
      ],
    );
  }
}
