import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class BottomNavDestinationData {
  const BottomNavDestinationData({required this.title, required this.image});

  final String title;
  final String image;
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.controller,
    required this.items,
  });

  final TabController controller;
  final List<BottomNavDestinationData> items;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.onPrimary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(27),
            offset: const Offset(0, -2),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      width: context.width,
      height: 94,
      child: Row(
        children: List.generate(
          widget.items.length,
          (i) {
            final item = widget.items[i];
            final isSelected = widget.controller.index == i;

            return Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  widget.controller.animateTo(i);
                  setState(() {});
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: isSelected
                          ? context.primaryContainer.withAlpha(63)
                          : Colors.transparent,
                      child: AppImage.asset(
                        item.image,
                        color: isSelected
                            ? context.primaryContainer
                            : const Color(0xffA5AAC9),
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AppText.labelMedium(
                      item.title,
                      fontWeight: FontWeight.w300,
                      color: isSelected
                          ? context.primaryContainer
                          : const Color(0xffA5AAC9),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
