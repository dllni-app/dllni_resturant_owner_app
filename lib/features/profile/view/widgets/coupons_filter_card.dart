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
  final TextEditingController _searchController = TextEditingController();

  List<Color> colors = [const Color(0xff10B981), const Color(0xff9CA3AF)];
  List<String> title = ['الكل', 'نشط', 'منتهي'];
  List<String> status = ['all', 'active', 'expired'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _reload() {
    final query = _searchController.text.trim();
    context.read<ProfileBloc>().add(
          FetchCouponsEvent(
            params: FetchCouponsParams(status: status[selectedIndex], search: query.isEmpty ? null : query, page: 1),
            isReload: true,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: context.onPrimary,
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), offset: const Offset(0, 1), blurRadius: 2)],
        border: Border.all(color: const Color(0xffF3F4F6), width: 1),
      ),
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 24),
      padding: const EdgeInsetsDirectional.all(16),
      child: Column(
        children: [
          TextFormField(
            controller: _searchController,
            style: const TextStyle(color: Color(0xff2F2B3D), fontSize: 14, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF9FAFB),
              prefixIcon: const Icon(Icons.search, color: Color(0xff9CA3AF)),
              hintText: 'ابحث عن كوبون...',
              hintStyle: const TextStyle(color: Color(0xff9CA3AF), fontSize: 14, fontWeight: FontWeight.w400),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xffE5E7EB), width: 1)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xffE5E7EB), width: 1)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xffE5E7EB), width: 1)),
            ),
            onChanged: (_) => _reload(),
            onFieldSubmitted: (_) => _reload(),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 50,
            child: Row(
              children: List.generate(
                title.length,
                (i) => Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() => selectedIndex = i);
                        widget.profileNotifier.changeCouponStatus(status[i]);
                        _reload();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: selectedIndex == i ? const Color(0xff064E3B) : const Color(0xffF3F4F6),
                        ),
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (i != 0) CircleAvatar(radius: 5, backgroundColor: colors[i - 1]),
                            if (i != 0) const SizedBox(width: 6),
                            AppText.labelLarge(title[i], fontWeight: FontWeight.bold, color: i == selectedIndex ? context.onPrimary : const Color(0xff374151)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
