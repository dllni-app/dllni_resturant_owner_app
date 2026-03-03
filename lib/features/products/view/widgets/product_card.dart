import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: context.onPrimary,
        border: Border.all(color: context.error),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(4), offset: Offset(0, 0), blurRadius: 15)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              alignment: AlignmentGeometry.bottomCenter,
              children: [
                AppImage.asset(Assets.imagesTestBurger, height: 96, width: 96),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(16), bottomLeft: Radius.circular(16)),
                    color: context.error.withAlpha(178),
                  ),
                  width: 96,
                  padding: EdgeInsetsDirectional.symmetric(vertical: 2),
                  child: AppText.labelSmall('باقي 3 فقط', color: context.onError, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.bodyLarge('برجر كلاسيك لحم', fontWeight: FontWeight.bold),
                SizedBox(height: 9),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Color(0xff28C76F).withAlpha(39)),
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 2),
                      child: AppText.labelSmall('متوفر', color: Color(0xff28C76F)),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Color(0xff2F2B3D).withAlpha(39)),
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 2),
                      child: AppText.labelSmall('غير متوفر', color: Color(0xff2F2B3D)),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText.titleLarge('350.00', fontWeight: FontWeight.bold, color: context.primaryContainer),
                    SizedBox(width: 4),
                    AppText.labelSmall('ل.س', fontWeight: FontWeight.w400, color: Color(0xff9CA3AF)),
                    Spacer(),
                    Switch(value: true, onChanged: (val) {}, activeTrackColor: context.primaryContainer),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
