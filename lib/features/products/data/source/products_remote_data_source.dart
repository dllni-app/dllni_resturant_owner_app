import 'package:common_package/helpers/dio_network.dart';
import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/api_handler.dart';
import '../models/get_products_model.dart';
import '../../domain/usecases/get_products_use_case.dart';
import '../models/get_categories_model.dart';
import '../../domain/usecases/get_categories_use_case.dart';

@lazySingleton
class ProductsRemoteDataSource with HandlingApiManager {
  final DioNetwork dioNetwork;

  ProductsRemoteDataSource({required this.dioNetwork});

  Future<GetProductsModel> getProducts(GetProductsParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/api/v1/products', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: getProductsModelFromJson,
    );
  }

  Future<GetCategoriesModel> getCategories(GetCategoriesParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(endPoint: '/api/v1/categories', params: params.getParams(), data: params.getBody().isEmpty ? null : params.getBody()),
      jsonConvert: getCategoriesModelFromJson,
    );
  }}