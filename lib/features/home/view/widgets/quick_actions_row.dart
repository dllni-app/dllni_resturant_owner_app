import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> titles = ['منتج جديد', 'إنشاء عرض', 'تعديل مخزون', 'التقارير'];
    List<String> images = [Assets.imagesNewOfferAction, Assets.imagesUpdateInventoryAction, Assets.imagesReportsAction];

    return Row(
      spacing: 12,
      children: List.generate(
        titles.length,
        (i) => Expanded(
          child: Column(
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black.withAlpha(7), blurRadius: 2, offset: Offset(0, 1))],
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Color(0xffF3F4F6), width: 1),
                  color: i == 0 ? context.primaryContainer : context.onPrimaryContainer,
                ),
                padding: EdgeInsetsDirectional.all(15),
                child: i == 0 ? Icon(Icons.add, color: context.onPrimaryContainer) : AppImage.asset(images[i - 1]),
              ),
              SizedBox(height: 8),
              AppText.labelMedium(titles[i], color: Color(0xff4B5563), fontWeight: FontWeight.w400),
            ],
          ),
        ),
      ),
    );
  }
}
