import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/products_repo.dart';
import '../../data/models/generate_ai_product_data_from_image_model.dart';

@lazySingleton
class GenerateAiProductDataFromImageUseCase implements UseCase<GenerateAiProductDataFromImageModel, GenerateAiProductDataFromImageParams> {
  final ProductsRepo products;

  GenerateAiProductDataFromImageUseCase({required this.products});

  @override
  DataResponse<GenerateAiProductDataFromImageModel> call(GenerateAiProductDataFromImageParams params) {
    return products.generateAiProductDataFromImage(params);
  }
}

class GenerateAiProductDataFromImageParams with Params {
  final File image;

  GenerateAiProductDataFromImageParams({required this.image});

  @override
  BodyMap getBody() => {"image": image, 'locale': 'ar'};
}
