import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';

class PreparingOrdersCard extends StatelessWidget {
  const PreparingOrdersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: context.onPrimary,
        border: Border.all(color: Color(0xffF3F4F6), width: 1),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(4), blurRadius: 10, offset: Offset(0, 2))],
      ),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 18),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Row(
          children: [
            CircleAvatar(backgroundColor: Color(0xff3B82F6), radius: 4),
            SizedBox(width: 12),
            AppText.bodyMedium('طلب #42', fontWeight: FontWeight.bold),
            SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(color: Color(0xffF3F4F6), borderRadius: BorderRadius.circular(4)),
              padding: EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 2),
              child: AppText.labelSmall('داخلي', color: Color(0xff9CA3AF)),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(color: Color(0xffF3F4F6), borderRadius: BorderRadius.circular(4)),
              padding: EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 2),
              child: Row(
                children: [
                  AppImage.asset(Assets.imagesOrderClock, color: context.primary, width: 12, height: 12),
                  SizedBox(width: 4),
                  AppText.labelLarge('12 دقيقة', color: context.primary, fontWeight: FontWeight.bold),
                ],
              ),
            ),
          ],
        ),
        separatorBuilder: (context, index) => Padding(
          padding: EdgeInsetsDirectional.symmetric(vertical: 4),
          child: Divider(thickness: 1, color: Color(0xffF9FAFB)),
        ),
        itemCount: 3,
      ),
    );
  }
}
