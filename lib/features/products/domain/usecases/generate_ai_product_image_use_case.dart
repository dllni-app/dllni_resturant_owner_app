import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/products_repo.dart';
import '../../data/models/generate_ai_product_image_model.dart';

@lazySingleton
class GenerateAiProductImageUseCase
    implements
        UseCase<GenerateAiProductImageModel, GenerateAiProductImageParams> {
  final ProductsRepo products;

  GenerateAiProductImageUseCase({required this.products});

  @override
  DataResponse<GenerateAiProductImageModel> call(
    GenerateAiProductImageParams params,
  ) {
    return products.generateAiProductImage(params);
  }
}

class GenerateAiProductImageParams with Params {
  final String title;
  final String? description;

  GenerateAiProductImageParams({required this.title, this.description});

  @override
  BodyMap getBody() {
    final body = <String, dynamic>{"title": title};
    final normalizedDescription = description?.trim();
    if (normalizedDescription != null && normalizedDescription.isNotEmpty) {
      body["description"] = normalizedDescription;
    }
    return body;
  }
}
