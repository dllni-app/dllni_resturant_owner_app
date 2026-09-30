import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/inventory_repo.dart';
import '../../data/models/fetch_inventory_items_model.dart';

@lazySingleton
class FetchInventoryItemsUseCase implements UseCase<FetchInventoryItemsModel, FetchInventoryItemsParams> {
  final InventoryRepo inventory;

  FetchInventoryItemsUseCase({required this.inventory});

  @override
  DataResponse<FetchInventoryItemsModel> call(FetchInventoryItemsParams params) {
    return inventory.fetchInventoryItems(params);
  }
}

class FetchInventoryItemsParams with Params {
  final String? status;
  final int page;
  final int perPage;

  FetchInventoryItemsParams({
    this.status,
    this.page = 1,
    this.perPage = 10,
  });

  @override
  QueryParams getParams() => {
        'filter[status]': status,
        'page': page,
        'perPage': perPage,
      }..removeWhere((key, value) => value == null);
}
