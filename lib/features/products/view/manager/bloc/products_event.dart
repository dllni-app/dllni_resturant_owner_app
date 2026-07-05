part of 'products_bloc.dart';

abstract class ProductsEvent {}

class FetchCategoriesEvent extends ProductsEvent with EventWithReload {
  final FetchCategoriesParams params;

  @override
  final bool isReload;

  FetchCategoriesEvent({required this.params, this.isReload = false});
}

class FetchProductsEvent extends ProductsEvent with EventWithReload {
  final FetchProductsParams params;

  @override
  final bool isReload;

  FetchProductsEvent({required this.params, this.isReload = false});
}

class GenerateAiProductImageEvent extends ProductsEvent {
  final GenerateAiProductImageParams params;

  GenerateAiProductImageEvent({required this.params});
}

class GenerateAiProductDataFromImageEvent extends ProductsEvent {
  final GenerateAiProductDataFromImageParams params;

  GenerateAiProductDataFromImageEvent({required this.params});
}

class GenerateAiProductDataFromMenuEvent extends ProductsEvent {
  final GenerateAiProductDataFromMenuParams params;

  GenerateAiProductDataFromMenuEvent({required this.params});
}

class PostNewProductEvent extends ProductsEvent {
  final PostNewProductParams params;

  PostNewProductEvent({required this.params});
}

class PostProductsFromMenuEvent extends ProductsEvent {
  final PostProductsFromMenuParams params;

  PostProductsFromMenuEvent({required this.params});
}

class UpdateProductEvent extends ProductsEvent {
  final UpdateProductParams params;
  final FetchProductsParams refreshParams;

  UpdateProductEvent({
    required this.params,
    required this.refreshParams,
  });
}

class DeleteProductEvent extends ProductsEvent {
  final DeleteProductParams params;
  final FetchProductsParams refreshParams;

  DeleteProductEvent({
    required this.params,
    required this.refreshParams,
  });
}
