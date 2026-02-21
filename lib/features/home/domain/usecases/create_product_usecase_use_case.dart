import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/home_repo.dart';
import '../../data/models/create_product_usecase_model.dart';

@lazySingleton
class CreateProductUsecaseUseCase implements UseCase<CreateProductUsecaseModel, CreateProductUsecaseParams> {
  final HomeRepo home;

  CreateProductUsecaseUseCase({required this.home});

  @override
  DataResponse<CreateProductUsecaseModel> call(CreateProductUsecaseParams params) {
    return home.createProductUsecase(params);
  }
}

class CreateProductUsecaseParams with Params {
  final String name;
  final double price;
  final int stockQuantity;
  final int lowStockThreshold;
  final int restaurantId;

  CreateProductUsecaseParams({
    required this.name,
    required this.price,
    required this.stockQuantity,
    required this.lowStockThreshold,
    required this.restaurantId,
  });

  @override
  BodyMap getBody() => {
    "name": name,
    "price": '$price',
    "stockQuantity": '$stockQuantity',
    "lowStockThreshold": '$lowStockThreshold',
    "restaurantId": '$restaurantId',
  };
}
