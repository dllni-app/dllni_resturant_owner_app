import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/error_handler.dart';

import '../../domain/repository/products_repo.dart';
import 'package:common_package/helpers/typedef.dart';
import '../source/products_remote_data_source.dart';
import '../../domain/usecases/fetch_categories_use_case.dart';
import '../models/fetch_categories_model.dart';
import '../../domain/usecases/fetch_products_use_case.dart';
import '../models/fetch_products_model.dart';
import '../../domain/usecases/generate_ai_product_image_use_case.dart';
import '../models/generate_ai_product_image_model.dart';
import '../../domain/usecases/generate_ai_product_data_from_image_use_case.dart';
import '../models/generate_ai_product_data_from_image_model.dart';
import '../../domain/usecases/generate_ai_product_data_from_menu_use_case.dart';
import '../models/generate_ai_product_data_from_menu_model.dart';
import '../../domain/usecases/post_new_product_use_case.dart';
import '../models/post_new_product_model.dart';

@LazySingleton(as: ProductsRepo)
class ProductsRepoImpl with HandlingException implements ProductsRepo {
  final ProductsRemoteDataSource productsRemoteDataSource;

  ProductsRepoImpl({required this.productsRemoteDataSource});

  @override
  DataResponse<FetchCategoriesModel> fetchCategories(FetchCategoriesParams params) {
    return wrapHandlingException(
      tryCall: () => productsRemoteDataSource.fetchCategories(params),
    );
  }

  @override
  DataResponse<FetchProductsModel> fetchProducts(FetchProductsParams params) {
    return wrapHandlingException(
      tryCall: () => productsRemoteDataSource.fetchProducts(params),
    );
  }

  @override
  DataResponse<GenerateAiProductImageModel> generateAiProductImage(GenerateAiProductImageParams params) {
    return wrapHandlingException(
      tryCall: () => productsRemoteDataSource.generateAiProductImage(params),
    );
  }

  @override
  DataResponse<GenerateAiProductDataFromImageModel> generateAiProductDataFromImage(GenerateAiProductDataFromImageParams params) {
    return wrapHandlingException(
      tryCall: () => productsRemoteDataSource.generateAiProductDataFromImage(params),
    );
  }

  @override
  DataResponse<GenerateAiProductDataFromMenuModel> generateAiProductDataFromMenu(GenerateAiProductDataFromMenuParams params) {
    return wrapHandlingException(
      tryCall: () => productsRemoteDataSource.generateAiProductDataFromMenu(params),
    );
  }

  @override
  DataResponse<PostNewProductModel> postNewProduct(PostNewProductParams params) {
    return wrapHandlingException(
      tryCall: () => productsRemoteDataSource.postNewProduct(params),
    );
  }}

