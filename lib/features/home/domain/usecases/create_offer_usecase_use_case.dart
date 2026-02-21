import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/home_repo.dart';
import '../../data/models/create_offer_usecase_model.dart';

@lazySingleton
class CreateOfferUsecaseUseCase implements UseCase<CreateOfferUsecaseModel, CreateOfferUsecaseParams> {
  final HomeRepo home;

  CreateOfferUsecaseUseCase({required this.home});

  @override
  DataResponse<CreateOfferUsecaseModel> call(CreateOfferUsecaseParams params) {
    return home.createOfferUsecase(params);
  }
}

class CreateOfferUsecaseParams with Params {
  final String title;
  final double discountPercentage;
  final DateTime startsAt;
  final DateTime endsAt;
  final int restaurantId;

  CreateOfferUsecaseParams({
    required this.title,
    required this.discountPercentage,
    required this.startsAt,
    required this.endsAt,
    required this.restaurantId,
  });

  @override
  BodyMap getBody() => {
    "title": title,
    "discountPercentage": '$discountPercentage',
    "startsAt": '$startsAt',
    "endsAt": '$endsAt',
    "restaurantId": '$restaurantId',
  };
}
