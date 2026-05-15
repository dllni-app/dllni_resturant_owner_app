import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/products_repo.dart';
import '../../data/models/generate_ai_product_data_from_image_model.dart';

@lazySingleton
class GenerateAiProductDataFromImageUseCase
    implements
        UseCase<
          GenerateAiProductDataFromImageModel,
          GenerateAiProductDataFromImageParams
        > {
  final ProductsRepo products;

  GenerateAiProductDataFromImageUseCase({required this.products});

  @override
  DataResponse<GenerateAiProductDataFromImageModel> call(
    GenerateAiProductDataFromImageParams params,
  ) {
    return products.generateAiProductDataFromImage(params);
  }
}

class GenerateAiProductDataFromImageParams with Params {
  final File image;
  final String? locale;

  GenerateAiProductDataFromImageParams({required this.image, this.locale});

  @override
  BodyMap getBody() {
    final body = <String, dynamic>{"image": image, "module": "resturant"};
    final normalizedLocale = locale?.trim();
    if (normalizedLocale == 'ar' || normalizedLocale == 'en') {
      body['locale'] = normalizedLocale;
    }
    return body;
  }
}
