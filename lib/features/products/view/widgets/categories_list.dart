import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffE5E7EB), width: 1),
              borderRadius: BorderRadius.circular(24),
              color: context.onPrimary,
              gradient: selectedIndex == index
                  ? LinearGradient(
                      colors: [context.primary.withAlpha(127), context.primary],
                      begin: AlignmentGeometry.centerRight,
                      end: AlignmentGeometry.centerLeft,
                    )
                  : null,
            ),
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 9),
            child: Row(
              children: [
                AppText.labelLarge('دجاج', color: selectedIndex == index ? context.onPrimary : Color(0xff4B5563)),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: selectedIndex == index ? context.primaryContainer : Color(0xffF3F4F6),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 2),
                  child: AppText.labelLarge('1244', color: selectedIndex == index ? context.onPrimaryContainer : Color(0xff4B5563)),
                ),
              ],
            ),
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemCount: 5,
      ),
    );
  }
}
