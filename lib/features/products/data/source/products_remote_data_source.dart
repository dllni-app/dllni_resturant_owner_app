import 'package:common_package/common_package.dart';
import 'package:injectable/injectable.dart';
import '../models/fetch_categories_model.dart';
import '../../domain/usecases/fetch_categories_use_case.dart';
import '../models/fetch_products_model.dart';
import '../../domain/usecases/fetch_products_use_case.dart';
import '../models/generate_ai_product_image_model.dart';
import '../../domain/usecases/generate_ai_product_image_use_case.dart';
import '../models/generate_ai_product_data_from_image_model.dart';
import '../../domain/usecases/generate_ai_product_data_from_image_use_case.dart';
import '../models/generate_ai_product_data_from_menu_model.dart';
import '../../domain/usecases/generate_ai_product_data_from_menu_use_case.dart';
import '../models/post_new_product_model.dart';
import '../../domain/usecases/post_new_product_use_case.dart';

@lazySingleton
class ProductsRemoteDataSource with HandlingApiManager {
  final DioNetwork dioNetwork;
  static const Duration _aiRequestTimeout = Duration(seconds: 60);

  ProductsRemoteDataSource({required this.dioNetwork});

  Future<FetchCategoriesModel> fetchCategories(FetchCategoriesParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(
        endPoint: '/api/v1/categories',
        params: params.getParams(),
        data: params.getBody().isEmpty ? null : params.getBody(),
      ),
      jsonConvert: fetchCategoriesModelFromJson,
    );
  }

  Future<FetchProductsModel> fetchProducts(FetchProductsParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.getData(
        endPoint: '/api/v1/products',
        params: params.getParams(),
        data: params.getBody().isEmpty ? null : params.getBody(),
      ),
      jsonConvert: fetchProductsModelFromJson,
    );
  }

  Future<GenerateAiProductImageModel> generateAiProductImage(
    GenerateAiProductImageParams params,
  ) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.postData(
        endPoint: '/api/v1/products/ai/generate-image',
        data: params.getBody(),
        params: params.getParams(),
        sendTimeout: _aiRequestTimeout,
        receiveTimeout: _aiRequestTimeout,
      ),
      jsonConvert: generateAiProductImageModelFromJson,
    );
  }

  Future<GenerateAiProductDataFromImageModel> generateAiProductDataFromImage(
    GenerateAiProductDataFromImageParams params,
  ) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.postData(
        endPoint: '/api/v1/products/ai/extract-from-image',
        data: params.getBody(),
        params: params.getParams(),
        sendTimeout: _aiRequestTimeout,
        receiveTimeout: _aiRequestTimeout,
      ),
      jsonConvert: generateAiProductDataFromImageModelFromJson,
    );
  }

  Future<GenerateAiProductDataFromMenuModel> generateAiProductDataFromMenu(
    GenerateAiProductDataFromMenuParams params,
  ) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.postData(
        endPoint: '/api/v1/products/ai/extract-from-menu',
        data: params.getBody(),
        params: params.getParams(),
        sendTimeout: _aiRequestTimeout,
        receiveTimeout: _aiRequestTimeout,
      ),
      jsonConvert: generateAiProductDataFromMenuModelFromJson,
    );
  }

  Future<PostNewProductModel> postNewProduct(PostNewProductParams params) {
    return wrapHandlingApi(
      tryCall: () => dioNetwork.postData(
        endPoint: '/api/v1/products',
        data: params.getBody(),
        params: params.getParams(),
      ),
      jsonConvert: postNewProductModelFromJson,
    );
  }
}
