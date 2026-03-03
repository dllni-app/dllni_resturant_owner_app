part of 'products_bloc.dart';

abstract class ProductsEvent {}

class GetProductsEvent extends ProductsEvent with EventWithReload {
  final GetProductsParams params;

  @override
  final bool isReload;

  GetProductsEvent({required this.params, this.isReload = false});
}

class GetCategoriesEvent extends ProductsEvent {
  final GetCategoriesParams params;

  GetCategoriesEvent({required this.params});
}
