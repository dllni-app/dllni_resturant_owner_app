import 'package:dllni_resturant_owner_app/features/products/domain/usecases/fetch_categories_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../manager/bloc/products_bloc.dart';
import '../widgets/products_app_bar.dart';
import '../widgets/products_body.dart';
import '../widgets/products_style_tokens.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => getIt<ProductsBloc>()..add(FetchCategoriesEvent(params: FetchCategoriesParams(page: 1))),
      child: Scaffold(
        backgroundColor: ProductsStyleTokens.pageBackground,
        body: Column(
          children: [
            ProductsAppBar(),
            Expanded(child: ProductsBody()),
          ],
        ),
      ),
    );
  }
}
