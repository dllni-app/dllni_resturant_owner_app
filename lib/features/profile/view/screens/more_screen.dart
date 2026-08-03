import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/seller_permission_access.dart';
import '../../../../generated/assets.dart';
import '../manager/bloc/profile_bloc.dart';
import '../widgets/more_screen_app_bar.dart';
import '../widgets/section_card.dart';
import '../widgets/section_title.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final access = SellerPermissionAccess.current();
    final canManageStore = access.can(RestaurantPermissionCodes.storeData);
    final canManageOffers = access.can(
      RestaurantPermissionCodes.offersAndCoupons,
    );
    final canManageEmployees = access.can(
      RestaurantPermissionCodes.employees,
    );

    return SafeArea(
      child: Column(
        children: [
          const MoreScreenAppBar(),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
              child: Column(
                children: [
                  if (canManageStore) ...[
                    const SectionTitle(title: 'إعدادات المتجر'),
                    const SizedBox(height: 16),
                    _SectionContainer(
                      children: [
                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            final resturantData = state.resturantData?.data;
                            return SectionCard(
                              containerColor: const Color(0xffD1FAE5),
                              imageColor: const Color(0xff059669),
                              image: Assets.images.marketInfoIcon.path,
                              title: 'معلومات المتجر',
                              subtitle: 'الاسم والعنوان والتفاصيل',
                              onTap: () {
                                if (resturantData == null) return;
                                context.pushRoute(
                                  '/profile',
                                  arguments: ProfileScreenParams(
                                    profile: resturantData,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const _SectionDivider(),
                        SectionCard(
                          containerColor: const Color(0xffE0F2FE),
                          imageColor: const Color(0xff0284C7),
                          image: Assets.images.workingHourIcon.path,
                          title: 'ساعات العمل',
                          subtitle: 'تحديد اوقات الفتح والاغلاق',
                          onTap: () => context.pushRoute('/workingtime'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (canManageOffers) ...[
                    const SectionTitle(title: 'العروض والتسويق'),
                    const SizedBox(height: 16),
                    _SectionContainer(
                      children: [
                        SectionCard(
                          containerColor: const Color(0xffFEE2E2),
                          imageColor: const Color(0xffDC2626),
                          image: Assets.images.offersManagementIcon.path,
                          title: 'ادارة العروض',
                          subtitle: 'انشاء وتعديل العروض الترويجية',
                          onTap: () => context.pushRoute('/offersmanagement'),
                        ),
                        const _SectionDivider(),
                        SectionCard(
                          containerColor: const Color(0xffFEF3C7),
                          imageColor: const Color(0xffD97706),
                          image: Assets.images.coponsIcon.path,
                          title: 'الكوبونات',
                          subtitle: 'ادارة اكواد الخصم',
                          onTap: () => context.pushRoute('/couponsmanagement'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (canManageEmployees) ...[
                    const SectionTitle(title: 'الموظفون والسجل'),
                    const SizedBox(height: 16),
                    _SectionContainer(
                      children: [
                        SectionCard(
                          containerColor: const Color(0xffCFFAFE),
                          imageColor: const Color(0xff0891B2),
                          image: Assets.images.employeesManagementIcon.path,
                          title: 'إدارة الموظفين',
                          subtitle: 'إضافة وتعديل بيانات الموظفين',
                          onTap: () => context.pushRoute(
                            '/employeesmanagement',
                          ),
                        ),
                        const _SectionDivider(),
                        SectionCard(
                          containerColor: const Color(0xffF1F5F9),
                          imageColor: const Color(0xff475569),
                          image: Assets.images.employeesHistoryIcon.path,
                          title: 'سجل نشاط الموظفين',
                          subtitle: 'متابعة نشاط الفريق',
                          onTap: () => context.pushRoute('/employees/activity'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  _SectionContainer(
                    children: [
                      SectionCard(
                        containerColor: const Color(0xffDBEAFE),
                        imageColor: const Color(0xff2563EB),
                        image: Assets.images.supportIcon.path,
                        title: 'الدعم الفني',
                        subtitle: 'تواصل مع فريق الدعم',
                        onTap: () => context.pushRoute('/support'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () {
                      SharedPreferencesHelper.clearData();
                      context.pushRouteAndRemoveUntil('/login');
                    },
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffEF4444).withAlpha(6),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xffEF4444).withAlpha(52),
                        ),
                      ),
                      padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffEF4444).withAlpha(25),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsetsDirectional.all(13),
                            child: const Icon(
                              Icons.logout_rounded,
                              color: Color(0xffEF4444),
                            ),
                          ),
                          const SizedBox(width: 12),
                          AppText.bodyMedium(
                            'تسجيل الخروج',
                            color: const Color(0xffEF4444),
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionContainer extends StatelessWidget {
  const _SectionContainer({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: context.onPrimaryContainer,
        border: Border.all(color: const Color(0xffF3F4F6), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(6),
            offset: const Offset(0, 2),
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsetsDirectional.all(16),
      child: Column(children: children),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 16),
      child: Divider(color: context.surface, thickness: .5),
    );
  }
}
