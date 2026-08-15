import 'package:common_package/common_package.dart';
import 'package:flutter/material.dart';

class EngagementFeaturesCards extends StatelessWidget {
  const EngagementFeaturesCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
              child: _EngagementFeatureCard(
                title: 'دولاب الحظ',
                icon: Icons.casino_rounded,
                gradientColors: [Color(0xffFF7A00), Color(0xff994900)],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _EngagementFeatureCard(
                title: 'التصويت',
                icon: Icons.how_to_vote_rounded,
                gradientColors: [Color(0xff384EDE), Color(0xff1E2A78)],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const _EngagementFeatureCard(
          title: 'التكامل الاجتماعي',
          icon: Icons.groups_rounded,
          gradientColors: [Color(0xff2EC4B6), Color(0xff165E57)],
          isWide: true,
        ),
      ],
    );
  }
}

class _EngagementFeatureCard extends StatelessWidget {
  const _EngagementFeatureCard({
    required this.title,
    required this.icon,
    required this.gradientColors,
    this.isWide = false,
  });

  final String title;
  final IconData icon;
  final List<Color> gradientColors;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: isWide
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.bodyLarge(
                  title,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                _FeatureIcon(icon: icon),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: _FeatureIcon(icon: icon),
                ),
                AppText.labelLarge(
                  title,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ],
            ),
    );
  }
}

class _FeatureIcon extends StatelessWidget {
  const _FeatureIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(38),
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}
