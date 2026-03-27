import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/assets.dart';
import '../manager/bloc/profile_bloc.dart';
import '../widgets/more_screen_app_bar.dart';
import '../widgets/section_card.dart';
import '../widgets/section_title.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          MoreScreenAppBar(),
          SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SectionTitle(title: 'إعدادات المتجر'),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: context.onPrimaryContainer,
                      border: Border.all(color: Color(0xffF3F4F6), width: 1),
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), offset: Offset(0, 2), blurRadius: 10)],
                    ),
                    padding: EdgeInsetsDirectional.all(16),
                    child: Column(
                      children: [
                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            final resturantData = state.resturantData?.data;
                            return SectionCard(
                              containerColor: Color(0xffD1FAE5),
                              imageColor: Color(0xff059669),
                              image: Assets.imagesMarketInfoIcon,
                              title: 'معلومات المتجر',
                              subtitle: 'الاسم والعنوان والتفاصيل',
                              onTap: () {
                                if (resturantData == null) return;
                                context.pushRoute('/profile', arguments: ProfileScreenParams(profile: resturantData));
                              },
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.symmetric(vertical: 16),
                          child: Divider(color: context.surface, thickness: .5),
                        ),
                        SectionCard(
                          containerColor: Color(0xffE0F2FE),
                          imageColor: Color(0xff0284C7),
                          image: Assets.imagesWorkingHourIcon,
                          title: 'ساعات العمل',
                          subtitle: 'تحديد اوقات الفتح والاغلاق',
                          onTap: () {
                            context.pushRoute('/workingtime');
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  SectionTitle(title: 'العروض والتسويق'),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: context.onPrimaryContainer,
                      border: Border.all(color: Color(0xffF3F4F6), width: 1),
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), offset: Offset(0, 2), blurRadius: 10)],
                    ),
                    padding: EdgeInsetsDirectional.all(16),
                    child: Column(
                      children: [
                        SectionCard(
                          containerColor: Color(0xffFEE2E2),
                          imageColor: Color(0xffDC2626),
                          image: Assets.imagesOffersManagementIcon,
                          title: 'ادارة العروض',
                          subtitle: 'انشاء وتعديل العروض الترويجية',
                          onTap: () {
                            context.pushRoute('/offersmanagement');
                          },
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.symmetric(vertical: 16),
                          child: Divider(color: context.surface, thickness: .5),
                        ),
                        SectionCard(
                          containerColor: Color(0xffFEF3C7),
                          imageColor: Color(0xffD97706),
                          image: Assets.imagesCoponsIcon,
                          title: 'الكوبونات',
                          subtitle: 'ادارة اكواد الخصم',
                          onTap: () {
                            context.pushRoute('/couponsmanagement');
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  SectionTitle(title: 'الموظفون والسجل'),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: context.onPrimaryContainer,
                      border: Border.all(color: Color(0xffF3F4F6), width: 1),
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), offset: Offset(0, 2), blurRadius: 10)],
                    ),
                    padding: EdgeInsetsDirectional.all(16),
                    child: Column(
                      children: [
                        SectionCard(
                          containerColor: Color(0xffCFFAFE),
                          imageColor: Color(0xff0891B2),
                          image: Assets.imagesEmployeesManagementIcon,
                          title: 'إدارة الموظفين',
                          subtitle: 'إضافة وتعديل بيانات الموظفين',
                          onTap: () {
                            context.pushRoute('/employeesmanagement');
                          },
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.symmetric(vertical: 16),
                          child: Divider(color: context.surface, thickness: .5),
                        ),
                        SectionCard(
                          containerColor: Color(0xffF1F5F9),
                          imageColor: Color(0xff475569),
                          image: Assets.imagesEmployeesHistoryIcon,
                          title: 'سجل نشاط الموظفين',
                          subtitle: 'متابعة نشاط الفريق',
                          onTap: () {
                            // context.pushRoute('/couponsmanagement');
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: context.onPrimaryContainer,
                      border: Border.all(color: Color(0xffF3F4F6), width: 1),
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), offset: Offset(0, 2), blurRadius: 10)],
                    ),
                    padding: EdgeInsetsDirectional.all(16),
                    child: Column(
                      children: [
                        SectionCard(
                          containerColor: Color(0xffDBEAFE),
                          imageColor: Color(0xff2563EB),
                          image: Assets.imagesSupportIcon,
                          title: 'الدعم الفني',
                          subtitle: 'تواصل مع فريق الدعم',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: () {
                      SharedPreferencesHelper.clearData();
                      context.pushRouteAndRemoveUntil('/login');
                    },
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffEF4444).withAlpha(6),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Color(0xffEF4444).withAlpha(52)),
                      ),
                      padding: EdgeInsetsDirectional.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(color: Color(0xffEF4444).withAlpha(25), borderRadius: BorderRadius.circular(16)),
                            padding: EdgeInsetsDirectional.all(13),
                            child: Icon(Icons.logout_rounded, color: Color(0xffEF4444)),
                          ),
                          SizedBox(width: 12),
                          AppText.bodyMedium('تسجيل الخروج', color: Color(0xffEF4444), fontWeight: FontWeight.bold),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
