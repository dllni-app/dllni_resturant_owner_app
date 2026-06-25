import 'dart:async';

import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

import '../manager/profile_notifier.dart';

class CouponsFilterCard extends StatefulWidget {
  const CouponsFilterCard({super.key, required this.profileNotifier, this.onFiltersChanged});

  final ProfileNotifier profileNotifier;
  final VoidCallback? onFiltersChanged;

  @override
  State<CouponsFilterCard> createState() => _CouponsFilterCardState();
}

class _CouponsFilterCardState extends State<CouponsFilterCard> {
  int selectedIndex = 0;
  String selectedSort = '-created_at';
  Timer? _searchDebounce;
  final TextEditingController _searchController = TextEditingController();

  final List<Color> colors = [const Color(0xff10B981), const Color(0xff3B82F6), const Color(0xff9CA3AF)];
  final List<String> title = ['الكل', 'نشط', 'مجدول', 'منتهي'];
  final List<String> status = ['all', 'active', 'scheduled', 'expired'];
  final Map<String, String> sortOptions = const {
    '-created_at': 'الأحدث أولاً',
    'created_at': 'الأقدم أولاً',
    '-performance': 'الأعلى أداءً',
    'performance': 'الأقل أداءً',
  };

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _reload() {
    widget.onFiltersChanged?.call();
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 450), () {
      widget.profileNotifier.changeCouponSearch(value.trim());
      _reload();
    });
  }

  String _formatDate(DateTime value) {
    final year = value.year.toString().padLeft(4, '0');
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final selected = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 3),
      lastDate: DateTime(now.year + 3),
      initialDateRange: widget.profileNotifier.couponDateFrom.value != null && widget.profileNotifier.couponDateTo.value != null
          ? DateTimeRange(
              start: DateTime.tryParse(widget.profileNotifier.couponDateFrom.value!) ?? now,
              end: DateTime.tryParse(widget.profileNotifier.couponDateTo.value!) ?? now,
            )
          : null,
    );

    if (selected == null) return;
    widget.profileNotifier.changeCouponDateRange(dateFrom: _formatDate(selected.start), dateTo: _formatDate(selected.end));
    setState(() {});
    _reload();
  }

  void _clearDateRange() {
    widget.profileNotifier.changeCouponDateRange();
    setState(() {});
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    final dateFrom = widget.profileNotifier.couponDateFrom.value;
    final dateTo = widget.profileNotifier.couponDateTo.value;

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
            onChanged: _onSearchChanged,
            onFieldSubmitted: (value) {
              _searchDebounce?.cancel();
              widget.profileNotifier.changeCouponSearch(value.trim());
              _reload();
            },
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
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (i != 0) CircleAvatar(radius: 5, backgroundColor: colors[i - 1]),
                            if (i != 0) const SizedBox(width: 5),
                            AppText.labelLarge(title[i], fontWeight: FontWeight.bold, color: i == selectedIndex ? context.onPrimary : const Color(0xff374151), scrollText: true),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
                  decoration: BoxDecoration(color: const Color(0xffF9FAFB), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xffE5E7EB))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedSort,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      items: sortOptions.entries
                          .map((entry) => DropdownMenuItem<String>(
                                value: entry.key,
                                child: AppText.labelLarge(entry.value, textAlign: TextAlign.start),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() => selectedSort = value);
                        widget.profileNotifier.changeCouponSort(value);
                        _reload();
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: _pickDateRange,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(color: const Color(0xffF9FAFB), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xffE5E7EB))),
                  child: Row(
                    children: [
                      const Icon(Icons.date_range_rounded, size: 18, color: Color(0xff6B7280)),
                      const SizedBox(width: 6),
                      AppText.labelLarge(dateFrom == null || dateTo == null ? 'التاريخ' : '$dateFrom - $dateTo', color: const Color(0xff374151)),
                    ],
                  ),
                ),
              ),
              if (dateFrom != null || dateTo != null) ...[
                const SizedBox(width: 6),
                InkWell(
                  onTap: _clearDateRange,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsetsDirectional.all(12),
                    decoration: BoxDecoration(color: context.error.withAlpha(15), borderRadius: BorderRadius.circular(12)),
                    child: Icon(Icons.close_rounded, size: 18, color: context.error),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
