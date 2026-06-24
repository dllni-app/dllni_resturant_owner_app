import 'dart:async';

import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/bloc/products_bloc.dart';
import '../manager/products_notifier.dart';
import 'filter_button.dart';
import 'products_style_tokens.dart';
import 'search_field.dart';

class ProductsAppBar extends StatefulWidget {
  const ProductsAppBar({super.key, required this.productsNotifier});

  final ProductsNotifier productsNotifier;

  @override
  State<ProductsAppBar> createState() => _ProductsAppBarState();
}

class _ProductsAppBarState extends State<ProductsAppBar> {
  void _reload(BuildContext context) {
    context.read<ProductsBloc>().add(FetchProductsEvent(params: widget.productsNotifier.fetchParams(page: 1), isReload: true));
  }

  Timer? _searchDebounce;

  // void _toggleFilter(BuildContext context) {
  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.fromLTRB(16, 14 + MediaQuery.paddingOf(context).top, 16, 18),
      decoration: const BoxDecoration(
        color: ProductsStyleTokens.cardBackground,
        borderRadius: ProductsStyleTokens.appBarRadius,
        border: Border(bottom: BorderSide(width: 2, color: ProductsStyleTokens.primaryAction)),
        boxShadow: [ProductsStyleTokens.softShadow],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'المنتجات',
            style: context.textTheme.titleLarge?.copyWith(
              color: ProductsStyleTokens.titleColor,
              fontSize: 38,
              fontWeight: FontWeight.w700,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SearchField(
                  hintText: 'ابحث عن وجبة، مشروب...',
                  onChanged: (value) {
                    _searchDebounce?.cancel();

                    _searchDebounce = Timer(
                      const Duration(milliseconds: 500),
                          () {
                        widget.productsNotifier.changeSearchQuery(value);
                        _reload(context);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              FilterButton(onTap: () => _showFilters(context)
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilters(BuildContext parentContext) {
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            bool? availability = widget.productsNotifier.availabilityFilter.value;
            bool lowStock = widget.productsNotifier.lowStockOnly.value;
            bool discounted = widget.productsNotifier.discountedOnly.value;

            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.onPrimary,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(height: 20),

                    AppText.titleMedium(
                      'الفلترة',
                      fontWeight: FontWeight.bold,
                      color: context.primary,
                    ),

                    const SizedBox(height: 24),

                    SwitchListTile(
                      value: availability ?? false,
                      title: const Text('المتوفرة فقط'),
                      subtitle: Text(
                        availability == null
                            ? 'الكل'
                            : availability
                            ? 'متوفر'
                            : 'غير متوفر',
                      ),
                      onChanged: (value) {
                        setModalState(() {
                          availability = value;
                        });

                        widget.productsNotifier.changeFilters(
                          availability: value,
                          lowStock: lowStock,
                          discounted: discounted,
                        );
                      },
                    ),

                    SwitchListTile(
                      value: lowStock,
                      title: const Text('المخزون المنخفض'),
                      onChanged: (value) {
                        setModalState(() {
                          lowStock = value;
                        });

                        widget.productsNotifier.changeFilters(
                          availability: availability,
                          lowStock: value,
                          discounted: discounted,
                        );
                      },
                    ),

                    SwitchListTile(
                      value: discounted,
                      title: const Text('العروض والخصومات'),
                      onChanged: (value) {
                        setModalState(() {
                          discounted = value;
                        });

                        widget.productsNotifier.changeFilters(
                          availability: availability,
                          lowStock: lowStock,
                          discounted: value,
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _reload(parentContext);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: context.primary
                        ),
                        child: const Text('تطبيق',style:  TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color:  Colors.white ,
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
