import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  // =========================================================
  // GLOBAL FONT SCALE
  // =========================================================

  /// Change this single value to scale the entire app typography.
  ///
  /// 1.0 = Normal
  /// 1.1 = 10% Larger
  /// 0.9 = 10% Smaller
  static const double scale = 1.0;

  // =========================================================
  // FONT SIZES
  // =========================================================

  static const double xs = 12.0;
  static const double sm = 14.0;
  static const double md = 16.0;
  static const double lg = 18.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 28.0;
  static const double display = 32.0;

  // =========================================================
  // SCALED FONT SIZES
  // =========================================================

  static double get xsScaled => xs * scale;
  static double get smScaled => sm * scale;
  static double get mdScaled => md * scale;
  static double get lgScaled => lg * scale;
  static double get xlScaled => xl * scale;
  static double get xxlScaled => xxl * scale;
  static double get xxxlScaled => xxxl * scale;
  static double get displayScaled => display * scale;

  // =========================================================
  // FONT WEIGHTS
  // =========================================================

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
}