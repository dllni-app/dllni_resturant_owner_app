import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/create_offer_use_case.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/manager/bloc/profile_bloc.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/screens/create_offer_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/assets.dart';
import '../../data/models/fetch_offers_model.dart';

enum _OfferAction { update, delete }

class OfferCard extends StatelessWidget {
  const OfferCard({super.key, required this.offer});

  final FetchOffersModelDataItem offer;

  String _getStatusText(String? status) {
    switch (status) {
      case 'active':
        return 'نشط';
      case 'scheduled':
        return 'مجدول';
      case 'expired':
        return 'منتهي';
      default:
        return 'غير معروف';
    }
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'active':
        return Color(0xff10B981);
      case 'scheduled':
        return Color(0xffF59E0B);
      case 'expired':
        return Color(0xff9CA3AF);
      default:
        return Color(0xff9CA3AF);
    }
  }

  String _formatDateRange() {
    if (offer.startsAt == null && offer.endsAt == null) {
      return 'غير محدد';
    }
    try {
      if (offer.startsAt != null && offer.endsAt != null) {
        final startDate = DateTime.parse(offer.startsAt!);
        final endDate = DateTime.parse(offer.endsAt!);
        return '${DateFormat('d MMMM', 'ar').format(startDate)} - ${DateFormat('d MMMM', 'ar').format(endDate)}';
      } else if (offer.startsAt != null) {
        final startDate = DateTime.parse(offer.startsAt!);
        return DateFormat('d MMMM', 'ar').format(startDate);
      } else if (offer.endsAt != null) {
        final endDate = DateTime.parse(offer.endsAt!);
        return DateFormat('d MMMM', 'ar').format(endDate);
      }
    } catch (e) {
      return 'غير محدد';
    }
    return 'غير محدد';
  }

  String _formatDiscountValue() {
    if (offer.discountValue == null) return 'غير محدد';
    if (offer.discountType == 'percentage') {
      return '${offer.discountValue}%';
    } else {
      return '${offer.discountValue} ل.س';
    }
  }

  @override
  Widget build(BuildContext context) {
    final calculatedStatus = offer.calculateStatus();
    final statusColor = _getStatusColor(calculatedStatus);
    final statusText = _getStatusText(calculatedStatus);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffF3F4F6), width: 1),
        color: context.onPrimary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), offset: Offset(0, 1), blurRadius: 2)],
      ),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.titleMedium(offer.name ?? 'عرض بدون اسم', fontWeight: FontWeight.bold),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: statusColor.withAlpha(25)),
                          padding: EdgeInsetsDirectional.symmetric(horizontal: 9, vertical: 6),
                          child: Row(children: [AppText.labelLarge(statusText, color: statusColor)]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<_OfferAction>(
                icon: const Icon(Icons.more_vert, color: Color(0xFF6B7280)),
                onSelected: (value) {
                  if (value == _OfferAction.update) {
                    context.pushRoute('/offersmanagement/new', arguments: CreateOfferScreenParams(offer: offer));
                  } else {
                    context.read<ProfileBloc>().add(
                      CreateOfferSubmitEvent(
                        params: CreateOfferParams(isDelete: true, id: offer.id!),
                        context: context,
                      ),
                    );
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<_OfferAction>(
                    value: _OfferAction.update,
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined, size: 18, color: Color(0xFF065F46)),
                        SizedBox(width: 8),
                        AppText.labelLarge('تعديل'),
                      ],
                    ),
                  ),
                  PopupMenuItem<_OfferAction>(
                    value: _OfferAction.delete,
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, size: 18, color: Color(0xFFEF4444)),
                        SizedBox(width: 8),
                        AppText.labelLarge('حذف'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Color(0xffF9FAFB)),
            padding: EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.labelLarge('قيمة الخصم', color: Color(0xff4B5563), fontWeight: FontWeight.w400),
                    AppText.bodyMedium(_formatDiscountValue(), color: Color(0xff064E3B), fontWeight: FontWeight.bold),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.labelLarge('مدة العرض', color: Color(0xff4B5563), fontWeight: FontWeight.w400),
                    AppText.bodyMedium(_formatDateRange(), color: Color(0xff064E3B), fontWeight: FontWeight.bold),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Divider(color: Color(0xffF3F4F6), thickness: 1),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 8,
                children: [
                  AppImage.asset(Assets.images.navBarOrders.path, color: Color(0xff4B5563), size: 10),
                  AppText.labelLarge('طلبات مستفيدة', color: Color(0xff4B5563), fontWeight: FontWeight.w400),
                ],
              ),
              AppText.bodyMedium('${offer.performance?.ordersCount ?? 0} طلب', color: Color(0xff10B981), fontWeight: FontWeight.bold),
            ],
          ),
        ],
      ),
    );
  }
}
