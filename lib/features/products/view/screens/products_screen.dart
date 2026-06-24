import 'package:dllni_resturant_owner_app/features/products/domain/usecases/fetch_categories_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../manager/bloc/products_bloc.dart';
import '../manager/products_notifier.dart';
import '../widgets/products_app_bar.dart';
import '../widgets/products_body.dart';
import '../widgets/products_style_tokens.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductsNotifier productsNotifier = ProductsNotifier(

  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => getIt<ProductsBloc>()..add(FetchCategoriesEvent(params: FetchCategoriesParams(page: 1))),
      child: Scaffold(
        backgroundColor: ProductsStyleTokens.pageBackground,
        body: Column(
          children: [
            ProductsAppBar(productsNotifier: productsNotifier),
            Expanded(child: ProductsBody(productsNotifier: productsNotifier)),
          ],
        ),
      ),
    );
  }
}
