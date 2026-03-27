import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../repository/profile_repo.dart';
import '../../data/models/fetch_resturant_data_model.dart';

@lazySingleton
class FetchResturantDataUseCase implements UseCase<FetchResturantDataModel, FetchResturantDataParams> {

  final ProfileRepo profile;

  FetchResturantDataUseCase({required this.profile});

  @override
  DataResponse<FetchResturantDataModel> call(FetchResturantDataParams params) {
    return profile.fetchResturantData(params);
  }
}

class FetchResturantDataParams with Params{}
