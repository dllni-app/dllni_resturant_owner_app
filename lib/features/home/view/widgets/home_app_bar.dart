import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/manager/bloc/profile_bloc.dart';
import 'package:dllni_resturant_owner_app/features/profile/data/models/fetch_resturant_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../generated/assets.dart';
import '../../domain/usecases/fetch_notifications_use_case.dart';
import '../manager/bloc/home_bloc.dart';
import '../screens/notifications_screen.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key, this.image, this.name});

  static const String _restaurantNameKey = 'restaurant_name';
  static const String _restaurantBranchKey = 'restaurant_branch';
  static const String _restaurantImageKey = 'restaurant_image';

  final String? image;
  final String? name;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  late final HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = getIt<HomeBloc>()
      ..add(
        FetchNotificationsEvent(
          params: FetchNotificationsParams(status: 'all'),
        ),
      );

    // TODO: implement initState
    super.initState();
  }

  String? _cleanValue(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) return null;
    return normalized;
  }

  String _resolveBranch(FetchResturantDataModelData? restaurant) {
    return _cleanValue(restaurant?.district) ??
        _cleanValue(restaurant?.city) ??
        _cleanValue(restaurant?.address) ??
        '';
  }

  bool _areEqual(String? first, String? second) {
    return _cleanValue(first) == _cleanValue(second);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final restaurant = state.resturantData?.data;
        final cachedName = _cleanValue(
          SharedPreferencesHelper.getData(key: HomeAppBar._restaurantNameKey)
              as String?,
        );
        final cachedBranch = _cleanValue(
          SharedPreferencesHelper.getData(key: HomeAppBar._restaurantBranchKey)
              as String?,
        );
        final cachedImage = _cleanValue(
          SharedPreferencesHelper.getData(key: HomeAppBar._restaurantImageKey)
              as String?,
        );

        final apiName = _cleanValue(restaurant?.name);
        final apiBranch = _cleanValue(_resolveBranch(restaurant));
        final apiImage = _cleanValue(restaurant?.primaryImage);

        final hasApiData =
            apiName != null || apiBranch != null || apiImage != null;
        final isDifferentFromCache =
            !_areEqual(apiName, cachedName) ||
            !_areEqual(apiBranch, cachedBranch) ||
            !_areEqual(apiImage, cachedImage);

        final shouldUseApiData = hasApiData && isDifferentFromCache;

        if (shouldUseApiData) {
          if (apiName != null) {
            SharedPreferencesHelper.saveData(
              key: HomeAppBar._restaurantNameKey,
              value: apiName,
            );
          }
          if (apiBranch != null) {
            SharedPreferencesHelper.saveData(
              key: HomeAppBar._restaurantBranchKey,
              value: apiBranch,
            );
          }
          if (apiImage != null) {
            SharedPreferencesHelper.saveData(
              key: HomeAppBar._restaurantImageKey,
              value: apiImage,
            );
          }
        }

        final displayName =
            widget.name ??
            (shouldUseApiData ? apiName : cachedName) ??
            'اسم المطعم';
        final displayBranch = shouldUseApiData
            ? (apiBranch ?? '')
            : (cachedBranch ?? '');
        final displayImage = shouldUseApiData
            ? apiImage
            : (cachedImage ?? widget.image);

        return Container(
          decoration: BoxDecoration(
            color: context.onPrimary,
            border: Border(
              bottom: BorderSide(color: context.primaryContainer, width: 2),
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(27),
                offset: Offset(0, -2),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          width: context.width,
          height: 110,
          padding: EdgeInsetsDirectional.symmetric(horizontal: 24),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  color: context.onPrimaryContainer,
                  border: Border.all(color: Color(0xffF3F4F6), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(7),
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: context.onError,
                  radius: 22,
                  child: ClipOval(
                    child: displayImage != null && displayImage.isNotEmpty
                        ? Image.network(
                            displayImage,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 20,
                            ),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 20,
                          ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText.headlineLarge(
                      displayName,
                      color: context.primaryContainer,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                    AppText.labelLarge(
                      displayBranch.isEmpty ? 'غير محدد' : displayBranch,
                      color: Color(0xff2C6862),
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  String selectedKey = 'all';

                  context.pushRoute(
                    '/notifications',
                    arguments: NotificationsScreenParams(
                      homeBloc: homeBloc,
                      selectedKey: selectedKey,
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(9999),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9999),
                        color: context.onPrimaryContainer,
                        border: Border.all(color: Color(0xffF3F4F6), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(7),
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      padding: EdgeInsetsDirectional.all(12),
                      child: AppImage.asset(
                        Assets.images.homeNotification.path,
                        size: 18,
                      ),
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      bloc: homeBloc,
                      builder: (context, state) {
                        return
                          state.notificationsStatus==BlocStatus.success?


                          ( ( state.unreadNumber==null ||state.unreadNumber ==0)?

                              SizedBox()                              :

                          PositionedDirectional(
                            start: -2,
                            child: Container(
                              padding: EdgeInsets.all(4),

                              decoration: BoxDecoration(
                                  color: context.error,
                                  shape: BoxShape.circle
                              ),

                              child:

                              AppText.labelSmall(
                                state.unreadNumber.toString(),
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.start,

                              ),
                            ),
                          )

                          ):SizedBox()


                        ;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
