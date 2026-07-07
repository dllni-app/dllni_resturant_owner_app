import 'dart:io';

import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/core/di/injection.dart';
import 'package:dllni_resturant_owner_app/features/profile/data/models/fetch_resturant_data_model.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/update_resturant_data_use_case.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/manager/bloc/profile_bloc.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/pick_location_map_screen.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/widgets/communication_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/basic_info_card.dart';
import '../widgets/location_info_card.dart';
import '../widgets/profile_app_bar.dart';

@AutoRoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.params});

  final ProfileScreenParams params;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsController = TextEditingController();
  TextEditingController faceController = TextEditingController();
  TextEditingController instagramController = TextEditingController();

  double lat = 0;
  double long = 0;

  String image = '';
  String banner = '';

  File? uploadImage;
  File? uploadImages;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.params.profile.name);
    descController = TextEditingController(text: widget.params.profile.description);
    cityController = TextEditingController(text: widget.params.profile.city);
    countryController = TextEditingController(text: widget.params.profile.district ?? widget.params.profile.address);
    addressController = TextEditingController(text: widget.params.profile.locationDetails);
    phoneController = TextEditingController(text: widget.params.profile.phone);
    whatsController = TextEditingController(text: widget.params.profile.whatsappNumber);
    faceController = TextEditingController(text: widget.params.profile.facebookPageName);
    instagramController = TextEditingController(text: widget.params.profile.instagramUsername);
    lat = widget.params.profile.latitude ?? 0;
    long = widget.params.profile.longitude ?? 0;
    image = widget.params.profile.primaryImage ?? '';
    banner = widget.params.profile.primaryImage ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) => previous.updateResturantDataStatus != current.updateResturantDataStatus,
        listener: (context, state) {
          if (state.updateResturantDataStatus == BlocStatus.loading) {
            Loading.show(context);
            return;
          }

          Loading.close();
          if (state.updateResturantDataStatus == BlocStatus.success) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                ProfileAppBar(),
                SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 19),
                    child: Column(
                      children: [
                        BasicInfoCard(
                          name: nameController,
                          desc: descController,
                          image: image,
                          images: banner,
                          selectedImage: (single) {
                            uploadImage = single;
                          },
                          selectedImages: (images) {
                            uploadImages = images!;
                          },
                        ),
                        SizedBox(height: 16),
                        LocationInfoCard(
                          city: cityController,
                          county: countryController,
                          address: addressController,
                          lat: lat,
                          long: long,
                          selectedLat: (latitude) {
                            lat = latitude;
                          },
                          selectedLong: (longitude) {
                            long = longitude;
                          },
                          onPickLocation: () async {
                            final result = await context.pushRoute<dynamic>(
                              '/profile/map',
                              arguments: PickLocationMapParams(latitude: lat, longitude: long),
                            );
                            if (!mounted) return;
                            if (result is! PickLocationResult) return;
                            final picked = result;
                            setState(() {
                              lat = picked.latitude;
                              long = picked.longitude;
                              cityController.text = picked.city;
                              countryController.text = picked.district;
                              addressController.text = picked.locationDetails;
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        CommunicationInfoCard(
                          phoneController: phoneController,
                          whatsappController: whatsController,
                          faceController: faceController,
                          instagramController: instagramController,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: InkWell(
                          onTap: () {
                            getIt<ProfileBloc>().add(
                              UpdateResturantDataEvent(
                                context: context,
                                params: UpdateResturantDataParams(
                                  userId: widget.params.profile.userId,
                                  name: nameController.text.trim(),
                                  description: descController.text.trim(),
                                  address: addressController.text.trim().isEmpty ? widget.params.profile.address : addressController.text.trim(),
                                  city: cityController.text.trim(),
                                  district: countryController.text.trim(),
                                  phone: phoneController.text.trim(),
                                  image: uploadImage,
                                  banner: uploadImages,
                                  face: faceController.text,
                                  instagram: instagramController.text,
                                  lat: lat,
                                  long: long,
                                  whatsapp: whatsController.text,

                                ),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: context.primary),
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 16),
                            child: AppText.labelLarge(
                              'حفظ التغييرات',
                              color: context.onPrimary,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.error.withAlpha(50),
                              border: Border.all(color: context.error),
                            ),
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 16),
                            child: AppText.labelLarge('إلغاء', color: context.error, fontWeight: FontWeight.w500, textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
    );
  }
}

class ProfileScreenParams {
  final FetchResturantDataModelData profile;

  ProfileScreenParams({required this.profile});
}
