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
  final File? primaryImage;
  final List<File>? images;

  PostNewProductParams({
    required this.categoryId,
    required this.name,
    this.desc = '',
    required this.price,
    this.discountedPrice = '',
    this.lowStock = '',
    this.preparationTime = '',
    this.primaryImage,
    this.images,
  });

  @override
  BodyMap getBody() {
    final body = <String, dynamic>{
      'categoryId': categoryId,
      'name': name,
      'price': price,
      'isAvailable': 1,
      'isFeatured': 1,
    };
    if (desc.trim().isNotEmpty) body['description'] = desc.trim();
    if (discountedPrice.trim().isNotEmpty) body['discountedPrice'] = discountedPrice.trim();
    if (lowStock.trim().isNotEmpty) body['lowStockThreshold'] = lowStock.trim();
    if (preparationTime.trim().isNotEmpty) body['preparationTime'] = preparationTime.trim();
    if (primaryImage != null) body['primaryImage'] = primaryImage!;
    if (images != null && images!.isNotEmpty) body['images[]'] = images!;
    return body;
  }
}
