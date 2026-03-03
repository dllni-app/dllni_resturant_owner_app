import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class InventoryItemCard extends StatelessWidget {
  final String productName;
  final String currentQuantity;
  final String minimumQuantity;
  final String statusText;
  final String lastUpdated;
  final Color cardColor;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onAdjustQuantity;

  final bool isLow;

  const InventoryItemCard({
    super.key,
    required this.productName,
    required this.currentQuantity,
    required this.cardColor,
    required this.minimumQuantity,
    required this.isLow,
    this.statusText = 'منخفض',
    this.lastUpdated = 'منذ 5 ساعات',
    this.onIncrement,
    this.onDecrement,
    this.onAdjustQuantity,
  });

  @override
  Widget build(BuildContext context) {
    final currentQty = double.tryParse(currentQuantity.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
    final minQty = double.tryParse(minimumQuantity.replaceAll(RegExp(r'[^\d.]'), '')) ?? 1;
    final progress = (currentQty / minQty).clamp(0.0, 1.0);

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: context.onPrimary,
          border: Border(right: BorderSide(color: cardColor, width: 5)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.bodyLarge(productName, fontWeight: FontWeight.bold, color: Colors.black),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      AppText.labelLarge(currentQuantity, color: cardColor, fontWeight: FontWeight.bold),
                      SizedBox(width: 8),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                      ),
                      SizedBox(width: 8),
                      AppText.labelLarge('الحد الأدنى: $minimumQuantity', color: Colors.black87),
                    ],
                  ),
                  SizedBox(height: 12),
                  LinearProgressIndicator(value: .5, color: cardColor, backgroundColor: Color(0xffF3F4F6), minHeight: 6),
                  SizedBox(height: 12),
                  // Last updated
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
                      SizedBox(width: 6),
                      AppText.labelLarge('آخر تحديث: $lastUpdated', color: Colors.grey.shade600),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: onDecrement,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle),
                          child: Icon(Icons.remove, color: Colors.white, size: 20),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.symmetric(horizontal: 12),
                          child: InkWell(
                            onTap: onAdjustQuantity,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: EdgeInsetsDirectional.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: context.secondary, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: AppText.bodyMedium(
                                'تعديل الكمية',
                                color: context.secondary,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: onIncrement,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(color: isLow ? context.primaryContainer : Colors.grey.shade300, shape: BoxShape.circle),
                          child: Icon(Icons.add, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(14), bottomRight: Radius.circular(10)),
                    color: cardColor.withAlpha(51),
                  ),
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(color: cardColor, shape: BoxShape.circle),
                      ),
                      SizedBox(width: 6),
                      AppText.bodySmall(statusText, fontWeight: FontWeight.w500, color: cardColor),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
