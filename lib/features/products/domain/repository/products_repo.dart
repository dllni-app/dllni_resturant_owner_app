import 'package:common_package/helpers/typedef.dart';
import '../usecases/fetch_categories_use_case.dart';
import '../../data/models/fetch_categories_model.dart';
import '../usecases/fetch_products_use_case.dart';
import '../../data/models/fetch_products_model.dart';
import '../usecases/generate_ai_product_image_use_case.dart';
import '../../data/models/generate_ai_product_image_model.dart';
import '../usecases/generate_ai_product_data_from_image_use_case.dart';
import '../../data/models/generate_ai_product_data_from_image_model.dart';
import '../usecases/generate_ai_product_data_from_menu_use_case.dart';
import '../../data/models/generate_ai_product_data_from_menu_model.dart';
import '../usecases/post_new_product_use_case.dart';
import '../../data/models/post_new_product_model.dart';
import '../usecases/post_products_from_menu_use_case.dart';
import '../usecases/update_product_use_case.dart';
import '../usecases/delete_product_use_case.dart';
import '../../data/models/delete_product_model.dart';
abstract class ProductsRepo {
  DataResponse<FetchCategoriesModel> fetchCategories(FetchCategoriesParams params);

  DataResponse<FetchProductsModel> fetchProducts(FetchProductsParams params);

  DataResponse<GenerateAiProductImageModel> generateAiProductImage(GenerateAiProductImageParams params);

  DataResponse<GenerateAiProductDataFromImageModel> generateAiProductDataFromImage(GenerateAiProductDataFromImageParams params);

  DataResponse<GenerateAiProductDataFromMenuModel> generateAiProductDataFromMenu(GenerateAiProductDataFromMenuParams params);

  DataResponse<PostNewProductModel> postNewProduct(PostNewProductParams params);

  DataResponse<PostProductsFromMenuResult> postProductsFromMenu(PostProductsFromMenuParams params);

  DataResponse<PostNewProductModel> updateProduct(UpdateProductParams params);

  DataResponse<DeleteProductModel> deleteProduct(DeleteProductParams params);
}
