import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:common_package/helpers/typedef.dart';

import '../../data/models/fetch_resturant_data_model.dart';
import '../repository/profile_repo.dart';

@lazySingleton
class UpdateResturantDataUseCase implements UseCase<FetchResturantDataModel, UpdateResturantDataParams> {
  final ProfileRepo profile;

  UpdateResturantDataUseCase({required this.profile});

  @override
  DataResponse<FetchResturantDataModel> call(UpdateResturantDataParams params) {
    return profile.updateResturantData(params);
  }
}

class UpdateResturantDataParams with Params {
  final String? name;
  final String? description;
  final String? address;
  final String? city;
  final String? district;
  final String? phone;
  final String? whatsapp;
  final String? face;
  final String? instagram;
  final File? image;
  final File? banner;
  final double? long;
  final double? lat;

  UpdateResturantDataParams({
    this.name,
    this.description,
    this.address,
    this.city,
    this.district,
    this.phone,
    this.whatsapp,
    this.face,
    this.instagram,
    this.image,
    this.banner,
    this.long,
    this.lat,
  });

  @override
  BodyMap getBody() => {
    'name': name,
    'description': description,
    'address': address,
    'city': city,
    'district': district,
    'phone': phone,
    'whatsapp': whatsapp,
    'face': face,
    'instagram': instagram,
    'image': image,
    'banner': banner,
    'long': long,
    'lat': lat,
  }..removeWhere((key, value) => value == null);

  @override
  QueryParams getParams() => {};
}
