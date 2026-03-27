import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/products_repo.dart';
import '../../data/models/generate_ai_product_image_model.dart';

@lazySingleton
class GenerateAiProductImageUseCase implements UseCase<GenerateAiProductImageModel, GenerateAiProductImageParams> {
  final ProductsRepo products;

  GenerateAiProductImageUseCase({required this.products});

  @override
  DataResponse<GenerateAiProductImageModel> call(GenerateAiProductImageParams params) {
    return products.generateAiProductImage(params);
  }
}

class GenerateAiProductImageParams with Params {
  final String name;
  final String description;

  GenerateAiProductImageParams({required this.name, required this.description});

  @override
  BodyMap getBody() => {"title": name, "description": description};
}
