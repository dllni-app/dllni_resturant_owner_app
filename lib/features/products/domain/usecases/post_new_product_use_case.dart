import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/products_repo.dart';
import '../../data/models/post_new_product_model.dart';

@lazySingleton
class PostNewProductUseCase implements UseCase<PostNewProductModel, PostNewProductParams> {
  final ProductsRepo products;

  PostNewProductUseCase({required this.products});

  @override
  DataResponse<PostNewProductModel> call(PostNewProductParams params) {
    return products.postNewProduct(params);
  }
}

class PostNewProductParams with Params {
  final int categoryId;
  final String name;
  final String desc;
  final String price;
  final String discountedPrice;
  final String lowStock;
  final String preparationTime;
  final File primaryImage;
  final List<File> images;

  PostNewProductParams({
    required this.categoryId,
    required this.name,
    required this.desc,
    required this.price,
    required this.discountedPrice,
    required this.lowStock,
    required this.preparationTime,
    required this.primaryImage,
    required this.images,
  });

  @override
  BodyMap getBody() => {
    "categoryId": categoryId,
    "name": name,
    "description": desc,
    "price": price,
    "discountedPrice": discountedPrice,
    "isAvailable": 1,
    "lowStockThreshold": lowStock,
    "preparationTime": preparationTime,
    "isFeatured": 1,
    "primaryImage": primaryImage,
    "images[]": images,
  };
}
