import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/products/domain/usecases/get_categories_use_case.dart';
import 'package:dllni_resturant_owner_app/features/products/domain/usecases/get_products_use_case.dart';
import 'package:dllni_resturant_owner_app/features/products/view/manager/products_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../manager/bloc/products_bloc.dart';
import '../widgets/categories_list.dart';
import '../widgets/product_card.dart';
import '../widgets/products_app_bar.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductsNotifier productsNotifier = ProductsNotifier();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsBloc>(
      create: (context) => getIt<ProductsBloc>()..add(GetCategoriesEvent(params: GetCategoriesParams())),
      child: SafeArea(
        child: Column(
          children: [
            ProductsAppBar(),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: context.primaryContainer),
                width: context.width,
                padding: EdgeInsetsDirectional.symmetric(vertical: 11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle, color: context.onPrimaryContainer, size: 22),
                    SizedBox(width: 8),
                    AppText.labelLarge('إضافة منتج جديد', color: context.onPrimaryContainer, fontWeight: FontWeight.bold),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            CategoriesList(),
            Expanded(
              child: BlocBuilder<ProductsBloc, ProductsState>(
                buildWhen: (previous, current) => previous.products != current.products,
                builder: (context, state) {
                  return state.products!.builder(
                    loadingWidget: Padding(
                      padding: EdgeInsetsDirectional.only(top: 40),
                      child: Center(child: CircularProgressIndicator.adaptive()),
                    ),
                    emptyWidget: AppText.labelMedium('لا يوجد طلبات', fontWeight: FontWeight.w400),
                    successWidget: () {
                      return ValueListenableBuilder(
                        valueListenable: productsNotifier.categoryId,
                        builder: (context, id, _) => ListView.separated(
                          padding: EdgeInsetsDirectional.only(start: 24, end: 24, bottom: 20),
                          itemBuilder: (context, index) {
                            if (state.products!.length <= index) {
                              if (state.products!.length == index) {
                                context.read<ProductsBloc>().add(
                                  GetProductsEvent(
                                    params: GetProductsParams(page: state.products!.pageNumber, categoryId: id),
                                  ),
                                );
                              }
                              return SizedBox(width: 30, height: 30, child: FittedBox(child: CircularProgressIndicator.adaptive(strokeWidth: 3)));
                            }
                            return ProductCard();
                          },
                          separatorBuilder: (context, index) => SizedBox(height: 16),
                          itemCount: state.products!.listLength(1),
                        ),
                      );
                    },
                    onTapRetry: () {
                      context.read<ProductsBloc>().add(
                        GetProductsEvent(
                          params: GetProductsParams(page: state.products!.pageNumber, categoryId: productsNotifier.categoryId.value),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
