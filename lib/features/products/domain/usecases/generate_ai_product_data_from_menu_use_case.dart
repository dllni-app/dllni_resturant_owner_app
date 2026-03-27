import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/products_repo.dart';
import '../../data/models/generate_ai_product_data_from_menu_model.dart';

@lazySingleton
class GenerateAiProductDataFromMenuUseCase implements UseCase<GenerateAiProductDataFromMenuModel, GenerateAiProductDataFromMenuParams> {

  final ProductsRepo products;

  GenerateAiProductDataFromMenuUseCase({required this.products});

  @override
  DataResponse<GenerateAiProductDataFromMenuModel> call(GenerateAiProductDataFromMenuParams params) {
    return products.generateAiProductDataFromMenu(params);
  }
}

class GenerateAiProductDataFromMenuParams with Params{
  final File image;

  GenerateAiProductDataFromMenuParams({required this.image});

  @override
  BodyMap getBody() => {"image": image, 'locale': 'ar'};
}
