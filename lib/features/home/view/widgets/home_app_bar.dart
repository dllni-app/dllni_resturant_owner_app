import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, this.image, this.name});

  final String? image;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.onPrimary,
        border: Border(bottom: BorderSide(color: context.primaryContainer, width: 2)),
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(24), bottomLeft: Radius.circular(24)),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(27), offset: Offset(0, -2), blurRadius: 12, spreadRadius: 0)],
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
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(7), offset: Offset(0, 1), blurRadius: 2)],
            ),
            child: CircleAvatar(
              backgroundColor: context.onError,
              radius: 22,
              child: CircleAvatar(backgroundColor: Colors.grey, radius: 20),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.headlineLarge('مطعم البيت الحلبي', color: context.primaryContainer, fontWeight: FontWeight.bold, textAlign: TextAlign.start),
                AppText.labelLarge('الفرع الرئيسي - العزيزية', color: Color(0xff2C6862), fontWeight: FontWeight.w400, textAlign: TextAlign.start),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              color: context.onPrimaryContainer,
              border: Border.all(color: Color(0xffF3F4F6), width: 1),
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(7), offset: Offset(0, 1), blurRadius: 2)],
            ),
            padding: EdgeInsetsDirectional.all(12),
            child: Stack(
              alignment: AlignmentGeometry.topRight,
              children: [
                AppImage.asset(Assets.imagesHomeNotification, size: 18),
                CircleAvatar(
                  backgroundColor: context.onError,
                  radius: 4,
                  child: CircleAvatar(backgroundColor: Colors.red, radius: 3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
