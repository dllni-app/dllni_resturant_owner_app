import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AppImagePicker {
  static Future<File?> pickSingleImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      log('Error picking image: $e');
    }
    return null;
  }

  static Future<List<File>> pickMultipleImages() async {
    final ImagePicker picker = ImagePicker();
    List<File> images = [];
    try {
      List<XFile>? selectedImages = await picker.pickMultiImage();
      if (selectedImages.isNotEmpty) {
        images = selectedImages.map((file) => File(file.path)).toList();
      }
    } catch (e) {
      log('Error picking images: $e');
    }
    return images;
  }
}
