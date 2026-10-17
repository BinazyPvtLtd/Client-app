import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  // Font family
  // No custom font is configured in pubspec.yaml.
  // null uses Flutter's platform default font.
  static const String? fontFamily = null;

  // Global scale
  static const double scale = 1.0;

  // Existing Client App font sizes
  static const double xs = 12.0;
  static const double sm = 14.0;
  static const double md = 16.0;
  static const double lg = 18.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 28.0;
  static const double display = 32.0;

  // Existing getters - preserved
  static double get xsScaled => xs * scale;
  static double get smScaled => sm * scale;
  static double get mdScaled => md * scale;
  static double get lgScaled => lg * scale;
  static double get xlScaled => xl * scale;
  static double get xxlScaled => xxl * scale;
  static double get xxxlScaled => xxxl * scale;
  static double get displayScaled => display * scale;

  // Partner App typography scale
  static const double displayLarge = 32.0;
  static const double displayMedium = 28.0;
  static const double displaySmall = 24.0;

  static const double headingLarge = 22.0;
  static const double headingMedium = 20.0;
  static const double headingSmall = 18.0;

  static const double titleLarge = 18.0;
  static const double titleMedium = 16.0;
  static const double titleSmall = 14.0;

  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;

  static const double labelLarge = 15.0;
  static const double labelMedium = 13.0;
  static const double labelSmall = 11.0;

  // Font weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  // Line heights
  static const double tightHeight = 1.15;
  static const double normalHeight = 1.35;
  static const double relaxedHeight = 1.5;

  // Letter spacing
  static const double tightLetterSpacing = -0.3;
  static const double normalLetterSpacing = 0.0;
  static const double wideLetterSpacing = 0.3;
}
