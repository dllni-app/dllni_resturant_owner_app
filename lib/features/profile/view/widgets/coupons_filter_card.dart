import 'package:common_package/common_package.dart';
import 'package:dllni_resturant_owner_app/features/profile/domain/usecases/fetch_coupons_use_case.dart';
import 'package:dllni_resturant_owner_app/features/profile/view/manager/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/profile_notifier.dart';

class CouponsFilterCard extends StatefulWidget {
  const CouponsFilterCard({super.key, required this.profileNotifier});

  final ProfileNotifier profileNotifier;

  @override
  State<CouponsFilterCard> createState() => _CouponsFilterCardState();
}

class _CouponsFilterCardState extends State<CouponsFilterCard> {
  int selectedIndex = 0;

  List<Color> colors = [Color(0xff10B981), Color(0xff9CA3AF)];

  List<String> title = ['الكل', 'نشط', 'منتهي'];
  List<String> status = ['all', 'active', 'expired'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: context.onPrimary,
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), offset: Offset(0, 1), blurRadius: 2)],
        border: Border.all(color: Color(0xffF3F4F6), width: 1),
      ),
      margin: EdgeInsetsDirectional.symmetric(horizontal: 24),
      padding: EdgeInsetsDirectional.all(16),
      child: Column(
        children: [
          TextFormField(
            style: TextStyle(color: Color(0xff2F2B3D), fontSize: 14, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xffF9FAFB),
              prefixIcon: Icon(Icons.search, color: Color(0xff9CA3AF)),
              hintText: 'ابحث عن عرض...',
              hintStyle: TextStyle(color: Color(0xff9CA3AF), fontSize: 14, fontWeight: FontWeight.w400),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xffE5E7EB), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xffE5E7EB), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xffE5E7EB), width: 1),
              ),
            ),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 50,
            child: Row(
              spacing: 8,
              children: List.generate(
                title.length,
                (i) => Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = i;
                      });
                      widget.profileNotifier.changeCouponStatus(status[i]);
                      context.read<ProfileBloc>().add(FetchCouponsEvent(params: FetchCouponsParams(status: status[i]), isReload: true));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: selectedIndex == i ? Color(0xff064E3B) : Color(0xffF3F4F6),
                      ),
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          i == 0 ? SizedBox.shrink() : CircleAvatar(radius: 5, backgroundColor: colors[i - 1]),
                          i == 0 ? SizedBox.shrink() : SizedBox(width: 6),
                          AppText.labelLarge(
                            title[i],
                            fontWeight: FontWeight.bold,
                            color: i == selectedIndex ? context.onPrimary : Color(0xff374151),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xffE5E7EB), width: 1),
            ),
            padding: EdgeInsetsDirectional.symmetric(vertical: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.filter_alt_rounded, color: Color(0xff374151), size: 14),
                SizedBox(width: 8),
                AppText.bodyMedium('فلترة حسب التاريخ', color: Color(0xff374151), fontWeight: FontWeight.bold),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
