import 'package:common_package/annotations/auto_route_page.dart';
import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/widgets/communication_info_card.dart';
import 'package:flutter/material.dart';

import '../widgets/basic_info_card.dart';
import '../widgets/location_info_card.dart';
import '../widgets/profile_app_bar.dart';

@AutoRoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProfileAppBar(),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 19),
                child: Column(children: [BasicInfoCard(), SizedBox(height: 16), LocationInfoCard(), SizedBox(height: 16), CommunicationInfoCard()]),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: context.primary),
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 16),
                      child: AppText.labelLarge('حفظ التغييرات', color: context.onPrimary, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: context.error.withAlpha(50),
                        border: Border.all(color: context.error),
                      ),
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 16),
                      child: AppText.labelLarge('إلغاء', color: context.error, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
