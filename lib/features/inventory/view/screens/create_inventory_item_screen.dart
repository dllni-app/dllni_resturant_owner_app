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
  final Map<int, FetchProductsModelDataItem> _initialLinkedProducts = {};
  String _selectedUnit = 'كغ';

  FetchInventoryItemsModelDataItem? get _editingItem => widget.params?.item;

  String _formatNumber(num? value) {
    final number = value ?? 0;
    if (number % 1 == 0) return number.toInt().toString();
    return number.toString();
  }

  int _parseWholeNumber(String value) {
    return (double.tryParse(value.trim()) ?? 0).toInt();
  }

  List<FetchProductsModelDataItem> _getSelectedProducts(List<FetchProductsModelDataItem> allProducts) {
    final map = <int, FetchProductsModelDataItem>{..._initialLinkedProducts};
    for (final product in allProducts) {
      final id = product.id;
      if (id != null) map[id] = product;
    }
    return _selectedProductIds.map((id) => map[id]).whereType<FetchProductsModelDataItem>().toList();
  }

  @override
  void initState() {
    super.initState();
    final item = _editingItem;
    if (item == null) return;

    _nameController.text = item.name ?? '';
    _initialQuantityController.text = _formatNumber(item.quantity);
    _minimumQuantityController.text = _formatNumber(item.minimumLimit);
    _unitCostController.text = _formatNumber(item.unitCost);
    if (_defaultUnits.contains(item.unit)) {
      _selectedUnit = item.unit!;
    } else if ((item.unit ?? '').isNotEmpty) {
      _customUnitController.text = item.unit!;
    }

    for (final linkedProduct in item.products ?? <InventoryLinkedProduct>[]) {
      final id = linkedProduct.id;
      if (id == null) continue;
      _selectedProductIds.add(id);
      _initialLinkedProducts[id] = FetchProductsModelDataItem(id: id, name: linkedProduct.name);
    }
  }

  void _onSave(InventoryBloc bloc) {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      AppToast.showToast(context: context, message: 'أدخل اسم المادة', type: ToastificationType.error);
      return;
    }

    final customUnit = _customUnitController.text.trim();
    final unit = customUnit.isNotEmpty ? customUnit : _selectedUnit;
    final quantity = _parseWholeNumber(_initialQuantityController.text);
    final minimumLimit = _parseWholeNumber(_minimumQuantityController.text);
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
        child: Column(
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
                            onUnitChanged: (value) => setState(() => _selectedUnit = value),
                            customUnitController: _customUnitController,
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: InventoryTextField(title: 'الكمية الأولية', hintText: '0', controller: _initialQuantityController, keyboardType: TextInputType.number),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: InventoryTextField(title: 'الحد الأدنى', hintText: '0', controller: _minimumQuantityController, keyboardType: TextInputType.number),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          InventoryTextField(
                            title: 'تكلفة الوحدة',
                            hintText: '0',
                            controller: _unitCostController,
                            keyboardType: TextInputType.number,
                            suffix: const Text('ل.س', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    InventoryStepCard(
                      number: 2,
                      title: 'الربط بالمنتجات',
                      trailing: AppText.labelLarge('(اختياري)', color: const Color(0xFF6B7280), fontWeight: FontWeight.w500),
                      child: BlocBuilder<ProductsBloc, ProductsState>(
                        builder: (context, state) {
                          return InventoryLinkProductsSection(
                            selectedProductIds: _selectedProductIds,
                            searchController: _searchController,
                            onSearchChanged: (value) {
                              context.read<ProductsBloc>().add(FetchProductsEvent(params: FetchProductsParams(search: value, page: 1), isReload: true));
                            },
                            onProductToggle: (productId) => setState(() {
                              if (_selectedProductIds.contains(productId)) {
                                _selectedProductIds.remove(productId);
                              } else {
                                _selectedProductIds.add(productId);
                              }
                            }),
                            onShowAll: () {
                              setState(() => _searchController.clear());
                              context.read<ProductsBloc>().add(FetchProductsEvent(params: FetchProductsParams(page: 1), isReload: true));
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<ProductsBloc, ProductsState>(
                      builder: (context, state) {
                        final allProducts = state.products?.list ?? [];
                        final selectedProducts = _getSelectedProducts(allProducts);
                        return InventorySelectedProductsCard(selectedProducts: selectedProducts);
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
              child: MultiBlocListener(
                listeners: [
                  BlocListener<InventoryBloc, InventoryState>(
                    bloc: widget.params!.bloc,
                    listenWhen: (previous, current) =>
                    previous.createInventoryItemStatus !=
                        current.createInventoryItemStatus,
                    listener: (context, state) {
                      switch (state.createInventoryItemStatus) {
                        case BlocStatus.loading:
                          Loading.show(context);
                          break;

                        case BlocStatus.failed:
                          Loading.close();
                          AppToast.showToast(
                            context: context,
                            message: state.errorMessage ?? 'خطا في حفظ المادة',
                            type: ToastificationType.error,
                          );
                          break;

                        case BlocStatus.success:
                          Loading.close();
                          if (context.mounted) {
                            context.pop();
                          }
                          break;

                        default:
                          break;
                      }
                    },
                  ),

                  BlocListener<InventoryBloc, InventoryState>(
                    bloc: widget.params!.bloc,
                    listenWhen: (previous, current) =>
                    previous.updateInventoryItemStatus !=
                        current.updateInventoryItemStatus,
                    listener: (context, state) {
                      switch (state.updateInventoryItemStatus) {
                        case BlocStatus.loading:
                          Loading.show(context);
                          break;

                        case BlocStatus.failed:
                          Loading.close();
                          AppToast.showToast(
                            context: context,
                            message: state.errorMessage ?? 'خطا في حفظ المادة',
                            type: ToastificationType.error,
                          );
                          break;

                        case BlocStatus.success:
                          Loading.close();
                          if (context.mounted) {
                            context.pop();
                          }
                          break;

                        default:
                          break;
                      }
                    },
                  ),
                ],
                child: BlocBuilder<InventoryBloc, InventoryState>(
                  bloc: widget.params!.bloc,
                  buildWhen: (prev, curr) =>
                  curr.createInventoryItemStatus !=
                      prev.createInventoryItemStatus ||
                      curr.updateInventoryItemStatus !=
                          prev.updateInventoryItemStatus,
                  builder: (context, invState) {
                    final isLoading =
                        invState.createInventoryItemStatus == BlocStatus.loading ||
                            invState.updateInventoryItemStatus == BlocStatus.loading;

                    final isEditMode = _editingItem != null;

                    return Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: isLoading
                                ? null
                                : () => _onSave(widget.params!.bloc),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: context.primary,
                              ),
                              padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              child: AppText.labelLarge(
                                isEditMode
                                    ? 'حفظ التعديلات'
                                    : 'حفظ المادة',
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
                                : () => context.pop(),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: context.error.withAlpha(20),
                                border: Border.all(
                                  color: context.error,
                                ),
                              ),
                              padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 6,
                                vertical: 16,
                              ),
                              child: AppText.labelLarge(
                                'إلغاء',
                                color: context.error,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            ),
            const SizedBox(height: 10),
          ],
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
