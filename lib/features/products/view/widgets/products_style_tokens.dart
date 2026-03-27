import 'package:flutter/material.dart';

class ProductsStyleTokens {
  const ProductsStyleTokens._();

  static const Color pageBackground = Color(0xFFF3F4F6);
  static const Color cardBackground = Colors.white;

  static const Color titleColor = Color(0xFF1E2A78);
  static const Color primaryAction = Color(0xFFFF7A00);
  static const Color primaryActionDark = Color(0xFF1E2A78);

  static const Color textHigh = Color(0xFF111827);
  static const Color textMid = Color(0xFF374151);
  static const Color textLow = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);

  static const Color lineLight = Color(0xFFE5E7EB);
  static const Color lineCard = Color(0xFFF3F4F6);
  static const Color fieldBackground = Color(0xFFF9FAFB);

  static const Color success = Color(0xFF24B364);
  static const Color successSoft = Color(0x2928C76F);
  static const Color warning = Color(0xFFFF4C51);
  static const Color warningSoft = Color(0x14FF4C51);
  static const Color danger = Color(0xFFFF4C51);

  static const Color gradientStart = Color(0xFF4ADE80);
  static const Color gradientEnd = Color(0xFF60A5FA);

  static const BorderRadius appBarRadius = BorderRadius.vertical(
    bottom: Radius.circular(24),
  );
  static const BorderRadius cardRadius16 = BorderRadius.all(
    Radius.circular(16),
  );
  static const BorderRadius cardRadius24 = BorderRadius.all(
    Radius.circular(24),
  );
  static const BorderRadius cardRadius28 = BorderRadius.all(
    Radius.circular(28),
  );
  static const BorderRadius fieldRadius = BorderRadius.all(Radius.circular(16));
  static const BorderRadius chipRadius = BorderRadius.all(Radius.circular(999));
  static const BorderRadius buttonRadius = BorderRadius.all(
    Radius.circular(10),
  );

  static const double iconBoxSize = 56;
  static const double cardHorizontalPadding = 20;
  static const double cardVerticalPadding = 16;
  static const double screenHorizontalPadding = 20;
  static const double sectionSpacing = 16;

  static const BoxShadow softShadow = BoxShadow(
    color: Color(0x0D000000),
    blurRadius: 2,
    offset: Offset(0, 1),
  );

  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x08000000),
    blurRadius: 15,
    offset: Offset.zero,
  );

  static const BoxShadow elevatedCardShadow = BoxShadow(
    color: Color(0x0D000000),
    blurRadius: 20,
    spreadRadius: -2,
    offset: Offset(0, 4),
  );

  static const LinearGradient actionGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
  );

  static InputBorder fieldBorder() {
    return const OutlineInputBorder(
      borderRadius: fieldRadius,
      borderSide: BorderSide(color: lineLight),
    );
  }
}
