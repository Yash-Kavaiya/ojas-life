import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class OjasTextStyles {
  // Display
  static const displayLarge = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: OjasColors.cream,
    height: 1.2,
  );

  static const displayMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: OjasColors.cream,
    height: 1.2,
  );

  // Headline
  static const headlineLarge = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: OjasColors.cream,
    height: 1.3,
  );

  static const headlineMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: OjasColors.cream,
    height: 1.3,
  );

  // Body
  static const bodyLarge = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: OjasColors.textPrimary,
    height: 1.5,
  );

  static const bodyMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: OjasColors.textPrimary,
    height: 1.5,
  );

  static const bodySmall = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: OjasColors.textSecondary,
    height: 1.4,
  );

  // Label
  static const labelLarge = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: OjasColors.cream,
    height: 1.2,
    letterSpacing: 0.5,
  );

  static const labelMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: OjasColors.textSecondary,
    height: 1.2,
    letterSpacing: 0.3,
  );

  // Hindi / Devanagari
  static const hindiBody = TextStyle(
    fontFamily: 'NotoSansDevanagari',
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: OjasColors.textPrimary,
    height: 1.6,
  );

  static const hindiHeadline = TextStyle(
    fontFamily: 'NotoSansDevanagari',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: OjasColors.cream,
    height: 1.4,
  );
}
