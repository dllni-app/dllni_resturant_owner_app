import 'dart:io';

import 'package:common_package/helpers/typedef.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/post_new_product_model.dart';
import '../repository/products_repo.dart';

@lazySingleton
class PostProductsFromMenuUseCase
    implements UseCase<PostProductsFromMenuResult, PostProductsFromMenuParams> {
  final ProductsRepo products;

  PostProductsFromMenuUseCase({required this.products});

  @override
  DataResponse<PostProductsFromMenuResult> call(PostProductsFromMenuParams params) {
    return products.postProductsFromMenu(params);
  }
}

class PostProductsFromMenuParams with Params {
  final int categoryId;
  final File image;
  final List<PostProductFromMenuParams> products;
  final String price;
  final String discountedPrice;
  final String lowStock;
  final String preparationTime;

  PostProductsFromMenuParams({
    required this.categoryId,
    required this.image,
    required this.products,
    this.price = '0',
    this.discountedPrice = '0',
    this.lowStock = '1',
    this.preparationTime = '0',
  });

  @override
  BodyMap getBody() => {};
}

class PostProductFromMenuParams {
  final String title;
  final String description;

  PostProductFromMenuParams({
    required this.title,
    required this.description,
  });
}

class PostProductsFromMenuResult {
  final List<PostNewProductModel> products;

  const PostProductsFromMenuResult({required this.products});

  int get createdCount => products.length;
}
