import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class OrderDetailsEditCard extends StatelessWidget {
  const OrderDetailsEditCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(color: Color(0xffEFF6FF), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xffDBEAFE),
                child: Icon(Icons.edit, size: 20, color: Color(0xff2563EB)),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.headlineMedium('تعديل الطلب', fontWeight: FontWeight.bold, color: Color(0xff1E3A8A)),
                    SizedBox(height: 8),
                    AppText.bodySmall(
                      'يمكنك إجراء تعديلات محدودة على الطلب. سيتم إعلام الزبون بأي تغيير.',
                      color: Color(0xff2563EB),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: context.onPrimary,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xff2563EB)),
                  ),
                  child: Center(
                    child: AppText.labelMedium('تعديل الكمية', color: Color(0xff2563EB), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: context.onPrimary,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xff2563EB)),
                  ),
                  child: Center(
                    child: AppText.labelMedium('إضافة منتج', color: Color(0xff2563EB), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
