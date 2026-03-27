import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/inventory/domain/usecases/create_inventory_item_use_case.dart';
import 'package:dllni_resturant_owner_app/features/inventory/domain/usecases/update_inventory_item_use_case.dart';
import 'package:dllni_resturant_owner_app/features/inventory/data/models/fetch_inventory_items_model.dart';
import 'package:dllni_resturant_owner_app/features/products/data/models/fetch_products_model.dart';
import 'package:dllni_resturant_owner_app/features/products/view/manager/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../products/domain/usecases/fetch_products_use_case.dart';
import '../manager/bloc/inventory_bloc.dart';
import '../widgets/create_inventory_item_app_bar.dart';
import '../widgets/inventory_link_products_section.dart';
import '../widgets/inventory_selected_products_card.dart';
import '../widgets/inventory_step_card.dart';
import '../widgets/inventory_text_field.dart';
import '../widgets/inventory_unit_selector.dart';

@AutoRoutePage(path: '/inventory/new')
class CreateInventoryItemScreen extends StatelessWidget {
  const CreateInventoryItemScreen({super.key, required this.params});

  final CreateInventoryItemScreenParams params;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsBloc>(
      create: (context) => getIt<ProductsBloc>()..add(FetchProductsEvent(params: FetchProductsParams(page: 1), isReload: true)),
      child: _CreateInventoryItemBody(params: params),
    );
  }
}

class _CreateInventoryItemBody extends StatefulWidget {
  const _CreateInventoryItemBody({this.params});

  final CreateInventoryItemScreenParams? params;

  @override
  State<_CreateInventoryItemBody> createState() => _CreateInventoryItemBodyState();
}

class _CreateInventoryItemBodyState extends State<_CreateInventoryItemBody> {
  static const List<String> _defaultUnits = ['كغ', 'لتر', 'قطعة'];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _customUnitController = TextEditingController();
  final TextEditingController _initialQuantityController = TextEditingController(text: '0');
  final TextEditingController _minimumQuantityController = TextEditingController(text: '0');
  final TextEditingController _unitCostController = TextEditingController(text: '0');
  final TextEditingController _searchController = TextEditingController();

  final Set<int> _selectedProductIds = {};
  String _selectedUnit = 'كغ';

  FetchInventoryItemsModelDataItem? get _editingItem => widget.params?.item;

  List<FetchProductsModelDataItem> _getSelectedProducts(List<FetchProductsModelDataItem> allProducts) {
    return allProducts.where((p) => _selectedProductIds.contains(p.id)).toList();
  }

  @override
  void initState() {
    super.initState();
    final item = _editingItem;
    if (item == null) {
      return;
    }
    _nameController.text = item.name ?? '';
    _initialQuantityController.text = '${item.quantity ?? 0}';
    _minimumQuantityController.text = '${item.minimumLimit ?? 0}';
    _unitCostController.text = '${item.unitCost ?? 0}';
    if (_defaultUnits.contains(item.unit)) {
      _selectedUnit = item.unit!;
    } else if ((item.unit ?? '').isNotEmpty) {
      _customUnitController.text = item.unit!;
    }
  }

  void _onSave(InventoryBloc bloc) {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final customUnit = _customUnitController.text.trim();
    final unit = customUnit.isNotEmpty ? customUnit : _selectedUnit;
    final quantity = int.tryParse(_initialQuantityController.text.trim()) ?? 0;
    final minimumLimit = int.tryParse(_minimumQuantityController.text.trim()) ?? 0;
    final unitCost = double.tryParse(_unitCostController.text.trim()) ?? 0.0;
    final item = _editingItem;
    if (item != null) {
      bloc.add(
        UpdateInventoryItemEvent(
          params: UpdateInventoryItemParams(
            id: item.id!,
            name: name,
            unit: unit,
            quantity: quantity,
            minimumLimit: minimumLimit,
            unitCost: unitCost,
            productIds: _selectedProductIds.toList(),
          ),
        ),
      );
      return;
    }
    bloc.add(
      CreateInventoryItemEvent(
        params: CreateInventoryItemParams(
          name: name,
          unit: unit,
          quantity: quantity,
          minimumLimit: minimumLimit,
          unitCost: unitCost,
          productIds: _selectedProductIds.toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _customUnitController.dispose();
    _initialQuantityController.dispose();
    _minimumQuantityController.dispose();
    _unitCostController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, productsState) {
            final allProducts = productsState.products?.list ?? [];
            final selectedProducts = _getSelectedProducts(allProducts);

            return Column(
              children: [
                const CreateInventoryItemAppBar(),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        InventoryStepCard(
                          number: 1,
                          title: 'المعلومات الأساسية',
                          child: Column(
                            children: [
                              InventoryTextField(title: 'اسم المادة', hintText: 'مثال: برجر دجاج كلاسيك', controller: _nameController),
                              const SizedBox(height: 14),
                              InventoryUnitSelector(
                                selectedUnit: _selectedUnit,
                                onUnitChanged: (value) => setState(() {
                                  _selectedUnit = value;
                                }),
                                customUnitController: _customUnitController,
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  Expanded(
                                    child: InventoryTextField(
                                      title: 'الكمية الأولية',
                                      hintText: '0',
                                      controller: _initialQuantityController,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: InventoryTextField(
                                      title: 'الحد الأدنى',
                                      hintText: '0',
                                      controller: _minimumQuantityController,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              InventoryTextField(
                                title: 'تكلفة الوحدة',
                                hintText: '0',
                                controller: _unitCostController,
                                keyboardType: TextInputType.number,
                                suffix: const Text(
                                  'ل.س',
                                  style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        InventoryStepCard(
                          number: 2,
                          title: 'الربط بالمنتجات',
                          trailing: AppText.labelLarge('(اختياري)', color: const Color(0xFF6B7280), fontWeight: FontWeight.w500),
                          child: InventoryLinkProductsSection(
                            selectedProductIds: _selectedProductIds,
                            searchController: _searchController,
                            onSearchChanged: (value) {
                              context.read<ProductsBloc>().add(
                                FetchProductsEvent(params: FetchProductsParams(search: value, page: 1), isReload: true),
                              );
                            },
                            onProductToggle: (productId) => setState(() {
                              if (_selectedProductIds.contains(productId)) {
                                _selectedProductIds.remove(productId);
                              } else {
                                _selectedProductIds.add(productId);
                              }
                            }),
                            onShowAll: () => setState(() {
                              _searchController.clear();
                            }),
                          ),
                        ),
                        const SizedBox(height: 16),
                        InventorySelectedProductsCard(selectedProducts: selectedProducts),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                  child: BlocConsumer<InventoryBloc, InventoryState>(
                    bloc: widget.params!.bloc,
                    listener: (context, state) {
                      final isCreateLoading = state.createInventoryItemStatus == BlocStatus.loading;
                      final isUpdateLoading = state.updateInventoryItemStatus == BlocStatus.loading;
                      if (isCreateLoading || isUpdateLoading) {
                        Loading.show(context);
                        return;
                      }
                      if (state.createInventoryItemStatus == BlocStatus.failed || state.updateInventoryItemStatus == BlocStatus.failed) {
                        Loading.close();
                        AppToast.showToast(context: context, message: state.errorMessage ?? 'خطا في حفظ المادة', type: ToastificationType.error);
                        return;
                      }
                      if (state.updateInventoryItemStatus == BlocStatus.success) {
                        Loading.close();
                        context.pop();
                        return;
                      }
                      if (state.createInventoryItemStatus == BlocStatus.success) {
                        Loading.close();
                      }
                    },
                    buildWhen: (prev, curr) =>
                        curr.createInventoryItemStatus != prev.createInventoryItemStatus ||
                        curr.updateInventoryItemStatus != prev.updateInventoryItemStatus,
                    builder: (context, invState) {
                      final isLoading =
                          invState.createInventoryItemStatus == BlocStatus.loading || invState.updateInventoryItemStatus == BlocStatus.loading;
                      final isEditMode = _editingItem != null;
                      return Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: InkWell(
                              onTap: isLoading ? null : (){
                                _onSave(widget.params!.bloc);
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: context.primary),
                                padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 16),
                                child: AppText.labelLarge(
                                  isEditMode ? 'حفظ التعديلات' : 'حفظ المادة',
                                  color: context.onPrimary,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: InkWell(
                              onTap: isLoading
                                  ? null
                                  : () {
                                      context.pop();
                                    },
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: context.error.withAlpha(20),
                                  border: Border.all(color: context.error),
                                ),
                                padding: const EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 16),
                                child: AppText.labelLarge('إلغاء', color: context.error, fontWeight: FontWeight.w500, textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CreateInventoryItemScreenParams {
  final FetchInventoryItemsModelDataItem? item;

  final InventoryBloc bloc;

  CreateInventoryItemScreenParams({this.item, required this.bloc});
}
