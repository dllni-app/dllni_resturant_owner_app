import 'package:common_package/helpers/typedef.dart';
import '../usecases/get_products_use_case.dart';
import '../../data/models/get_products_model.dart';
import '../usecases/get_categories_use_case.dart';
import '../../data/models/get_categories_model.dart';
abstract class ProductsRepo {
  DataResponse<GetProductsModel> getProducts(GetProductsParams params);

  DataResponse<GetCategoriesModel> getCategories(GetCategoriesParams params);
}
