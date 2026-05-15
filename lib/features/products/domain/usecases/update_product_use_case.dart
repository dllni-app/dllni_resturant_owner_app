import 'dart:io';

import 'package:common_package/helpers/typedef.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/post_new_product_model.dart';
import '../repository/products_repo.dart';

@lazySingleton
class UpdateProductUseCase
    implements UseCase<PostNewProductModel, UpdateProductParams> {
  final ProductsRepo products;

  UpdateProductUseCase({required this.products});

  @override
  DataResponse<PostNewProductModel> call(UpdateProductParams params) {
    return products.updateProduct(params);
  }
}

class UpdateProductParams with Params {
  final int id;
  final int categoryId;
  final String name;
  final String? description;
  final String price;
  final String? discountedPrice;
  final bool? isAvailable;
  final String? stockQuantity;
  final String? lowStockThreshold;
  final String? preparationTime;
  final bool? isFeatured;
  final File? primaryImage;
  final List<File>? images;

  UpdateProductParams({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
    required this.price,
    this.discountedPrice,
    this.isAvailable,
    this.stockQuantity,
    this.lowStockThreshold,
    this.preparationTime,
    this.isFeatured,
    this.primaryImage,
    this.images,
  });

  @override
  BodyMap getBody() {
    final body = <String, dynamic>{
      'categoryId': categoryId,
      'name': name,
      'price': price,
    };

    if (_hasValue(description)) body['description'] = description!.trim();
    if (_hasValue(discountedPrice)) body['discountedPrice'] = discountedPrice!.trim();
    if (isAvailable != null) body['isAvailable'] = isAvailable;
    if (_hasValue(stockQuantity)) body['stockQuantity'] = stockQuantity!.trim();
    if (_hasValue(lowStockThreshold)) body['lowStockThreshold'] = lowStockThreshold!.trim();
    if (_hasValue(preparationTime)) body['preparationTime'] = preparationTime!.trim();
    if (isFeatured != null) body['isFeatured'] = isFeatured;
    if (primaryImage != null) body['primaryImage'] = primaryImage!;
    if (images != null && images!.isNotEmpty) body['images[]'] = images!;

    return body;
  }

  bool _hasValue(String? value) => value != null && value.trim().isNotEmpty;
}
