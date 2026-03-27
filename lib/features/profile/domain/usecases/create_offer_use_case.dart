import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/profile_repo.dart';
import '../../data/models/create_offer_model.dart';

@lazySingleton
class CreateOfferUseCase implements UseCase<CreateOfferModel, CreateOfferParams> {
  final ProfileRepo profile;

  CreateOfferUseCase({required this.profile});

  @override
  DataResponse<CreateOfferModel> call(CreateOfferParams params) {
    return profile.createOffer(params);
  }
}

class CreateOfferParams with Params {
  final String? name;
  final String? discountType;
  final double? discountValue;
  final String? startsAt;
  final String? endsAt;
  final bool? isActive;
  final List<int>? productIds;

  final bool isAddNew;
  final bool isDelete;
  final int? id;

  CreateOfferParams({
    this.name,
    this.discountType,
    this.discountValue,
    this.startsAt,
    this.endsAt,
    this.isActive,
    this.productIds,
    this.isAddNew = true,
    this.isDelete = false,
    this.id,
  });

  @override
  BodyMap getBody() => {
    'name': name,
    'discountType': discountType,
    'discountValue': discountValue,
    'startsAt': startsAt,
    'endsAt': endsAt,
    'isActive': isActive,
    'productIds': productIds,
  }..removeWhere((key, val) => val == null);

  @override
  QueryParams getParams() => {};
}

