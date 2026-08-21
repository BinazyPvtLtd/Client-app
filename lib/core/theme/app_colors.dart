// import 'package:flutter/material.dart';

// class AppColors {
//   AppColors._();

//   // =========================================================
//   // BRAND
//   // =========================================================

//   static const Color primary = Color(0xFFC17F4A);
//   static const Color primaryDark = Color(0xFFA96537);
//   static const Color primaryLight = Color(0xFFD49A6C);

//   // =========================================================
//   // BACKGROUND
//   // =========================================================

//   static const Color background = Color(0xFFFAF7F3);
//   static const Color surface = Color(0xFFFFFFFF);

//   // =========================================================
//   // TEXT
//   // =========================================================

//   static const Color textPrimary = Color(0xFF1C1917);
//   static const Color textSecondary = Color(0xFF6B625C);
//   static const Color textTertiary = Color(0xFF9A918A);
//   static const Color textOnPrimary = Color(0xFFFFFFFF);

//   // =========================================================
//   // STATUS
//   // =========================================================

//   static const Color success = Color(0xFF2E9B67);
//   static const Color warning = Color(0xFFE6A23C);
//   static const Color error = Color(0xFFD94A4A);
//   static const Color info = Color(0xFF4A90E2);

//   // =========================================================
//   // BORDER
//   // =========================================================

//   static const Color border = Color(0xFFE5DDD5);
//   static const Color borderFocused = primary;

//   // =========================================================
//   // COMMON
//   // =========================================================

//   static const Color white = Color(0xFFFFFFFF);
//   static const Color black = Color(0xFF000000);
//   static const Color transparent = Colors.transparent;

//   // =========================================================
//   // OVERLAY
//   // =========================================================

//   static const Color overlay = Color(0x66000000);

//     // =========================================================
//   // OPACITY
//   // =========================================================

//   static const double opacityExtraLight = 0.08;

//   static const double opacityLight = 0.12;

//   static const double opacityLightStrong = 0.28;

//   static const double opacityMedium = 0.35;

//   static const double opacityMediumStrong = 0.55;

//   static const double opacityShadow = 0.08;
// }



import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // =========================================================
  // BRAND
  // =========================================================

  static const Color primary = Color(0xFF000000);
  static const Color primaryDark = Color(0xFF000000);
  static const Color primaryLight = Color(0xFF333333);

  // =========================================================
  // BACKGROUND
  // =========================================================

  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF7F7F7);

  // =========================================================
  // TEXT
  // =========================================================

  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF555555);
  static const Color textTertiary = Color(0xFF888888);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // =========================================================
  // STATUS
  // =========================================================

  // Keeping status colors separate makes errors/success
  // recognizable even in a monochrome brand theme.
  static const Color success = Color(0xFF333333);
  static const Color warning = Color(0xFF666666);
  static const Color error = Color(0xFF000000);
  static const Color info = Color(0xFF555555);

  // =========================================================
  // BORDER
  // =========================================================

  static const Color border = Color(0xFFE0E0E0);
  static const Color borderFocused = Color(0xFF000000);

  // =========================================================
  // COMMON
  // =========================================================

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;

  // =========================================================
  // OVERLAY
  // =========================================================

  static const Color overlay = Color(0x66000000);

  // =========================================================
  // OPACITY
  // =========================================================

  static const double opacityExtraLight = 0.08;
  static const double opacityLight = 0.12;
  static const double opacityLightStrong = 0.28;
  static const double opacityMedium = 0.35;
  static const double opacityMediumStrong = 0.55;
  static const double opacityShadow = 0.08;
}