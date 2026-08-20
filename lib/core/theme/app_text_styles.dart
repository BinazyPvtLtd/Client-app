import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTextStyles {
  AppTextStyles._();

  // =========================================================
  // SPLASH
  // =========================================================

  static TextStyle get splashLogoText => TextStyle(
        fontSize: AppTypography.displayScaled,
        fontWeight: AppTypography.extraBold,
        color: AppColors.white,
        letterSpacing: -0.5,
      );

  static TextStyle get splashTagline => TextStyle(
        fontSize: AppTypography.lgScaled,
        fontWeight: AppTypography.medium,
        color: AppColors.white,
      );

  // =========================================================
  // SCREEN TITLE
  // =========================================================

  static TextStyle get screenTitle => TextStyle(
        fontSize: AppTypography.xxxlScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle get screenSubtitle => TextStyle(
        fontSize: AppTypography.lgScaled,
        fontWeight: AppTypography.regular,
        color: AppColors.textSecondary,
        height: 1.45,
      );

  // =========================================================
  // LOGIN
  // =========================================================

  static TextStyle get loginTitle => TextStyle(
        fontSize: AppTypography.xxxlScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle get loginSubtitle => TextStyle(
        fontSize: AppTypography.lgScaled,
        fontWeight: AppTypography.regular,
        color: AppColors.textSecondary,
        height: 1.45,
      );

  // =========================================================
  // OTP
  // =========================================================

  static TextStyle get otpTitle => TextStyle(
        fontSize: AppTypography.xxxlScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle get otpSubtitle => TextStyle(
        fontSize: AppTypography.mdScaled,
        fontWeight: AppTypography.regular,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  static TextStyle get otpDigit => TextStyle(
        fontSize: AppTypography.xlScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle get otpTimer => TextStyle(
        fontSize: AppTypography.mdScaled,
        fontWeight: AppTypography.medium,
        color: AppColors.textSecondary,
      );

  static TextStyle get otpResend => TextStyle(
        fontSize: AppTypography.mdScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.primary,
      );

  // =========================================================
  // INPUT
  // =========================================================

  static TextStyle get phoneInput => TextStyle(
        fontSize: AppTypography.lgScaled,
        fontWeight: AppTypography.medium,
        color: AppColors.textPrimary,
      );

  static TextStyle get countryCode => TextStyle(
        fontSize: AppTypography.lgScaled,
        fontWeight: AppTypography.semiBold,
        color: AppColors.textPrimary,
      );

  static TextStyle get inputLabel => TextStyle(
        fontSize: AppTypography.smScaled,
        fontWeight: AppTypography.semiBold,
        color: AppColors.textPrimary,
      );

  static TextStyle get inputHint => TextStyle(
        fontSize: AppTypography.mdScaled,
        fontWeight: AppTypography.regular,
        color: AppColors.textTertiary,
      );

  static TextStyle get inputError => TextStyle(
        fontSize: AppTypography.smScaled,
        fontWeight: AppTypography.medium,
        color: AppColors.error,
      );

  // =========================================================
  // BUTTON
  // =========================================================

  static TextStyle get buttonText => TextStyle(
        fontSize: AppTypography.lgScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.white,
      );

  static TextStyle get buttonTextDark => TextStyle(
        fontSize: AppTypography.lgScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.textPrimary,
      );

  // =========================================================
  // SIGN UP
  // =========================================================

  static TextStyle get signupText => TextStyle(
        fontSize: AppTypography.mdScaled,
        fontWeight: AppTypography.regular,
        color: AppColors.textSecondary,
      );

  static TextStyle get signupAction => TextStyle(
        fontSize: AppTypography.mdScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.primary,
        decoration: TextDecoration.underline,
      );

  // =========================================================
  // TERMS
  // =========================================================

  static TextStyle get termsText => TextStyle(
        fontSize: AppTypography.smScaled,
        fontWeight: AppTypography.regular,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  static TextStyle get termsAction => TextStyle(
        fontSize: AppTypography.smScaled,
        fontWeight: AppTypography.semiBold,
        color: AppColors.primary,
        decoration: TextDecoration.underline,
      );

  // =========================================================
  // HEADINGS
  // =========================================================

  static TextStyle get displayLarge => TextStyle(
        fontSize: AppTypography.displayScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle get displayMedium => TextStyle(
        fontSize: AppTypography.xxxlScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle get heading1 => TextStyle(
        fontSize: AppTypography.xxlScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle get heading2 => TextStyle(
        fontSize: AppTypography.xlScaled,
        fontWeight: AppTypography.semiBold,
        color: AppColors.textPrimary,
      );

  static TextStyle get heading3 => TextStyle(
        fontSize: AppTypography.lgScaled,
        fontWeight: AppTypography.semiBold,
        color: AppColors.textPrimary,
      );

  // =========================================================
  // BODY
  // =========================================================

  static TextStyle get bodyLarge => TextStyle(
        fontSize: AppTypography.mdScaled,
        fontWeight: AppTypography.regular,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyMedium => TextStyle(
        fontSize: AppTypography.smScaled,
        fontWeight: AppTypography.regular,
        color: AppColors.textSecondary,
      );

  static TextStyle get bodySmall => TextStyle(
        fontSize: AppTypography.xsScaled,
        fontWeight: AppTypography.regular,
        color: AppColors.textSecondary,
      );

  // =========================================================
  // LABELS
  // =========================================================

  static TextStyle get labelLarge => TextStyle(
        fontSize: AppTypography.smScaled,
        fontWeight: AppTypography.semiBold,
        color: AppColors.textPrimary,
      );

  static TextStyle get labelMedium => TextStyle(
        fontSize: AppTypography.xsScaled,
        fontWeight: AppTypography.medium,
        color: AppColors.textSecondary,
      );

        // =========================================================
  // HOME SCREEN
  // =========================================================

  static TextStyle get homeAppName => TextStyle(
        fontSize: AppTypography.xxlScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle get homeGreeting => TextStyle(
        fontSize: AppTypography.xxlScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle get homeSubtitle => TextStyle(
        fontSize: AppTypography.lgScaled,
        fontWeight: AppTypography.regular,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  // =========================================================
  // SERVICE CARDS
  // =========================================================

  static TextStyle get homeCardTitle => TextStyle(
        fontSize: AppTypography.xlScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle get homeCardDescription => TextStyle(
        fontSize: AppTypography.smScaled,
        fontWeight: AppTypography.regular,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  // =========================================================
  // REWARDS
  // =========================================================

  static TextStyle get homeRewardTitle => TextStyle(
        fontSize: AppTypography.xlScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle get homeRewardSubtitle => TextStyle(
        fontSize: AppTypography.smScaled,
        fontWeight: AppTypography.medium,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  // =========================================================
  // ANNOUNCEMENTS
  // =========================================================

  static TextStyle get homeSectionTitle => TextStyle(
        fontSize: AppTypography.xlScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle get homeViewAll => TextStyle(
        fontSize: AppTypography.smScaled,
        fontWeight: AppTypography.semiBold,
        color: AppColors.primary,
      );

  static TextStyle get homeAnnouncementTitle => TextStyle(
        fontSize: AppTypography.lgScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.textPrimary,
        height: 1.25,
      );

  static TextStyle get homeAnnouncementDescription => TextStyle(
        fontSize: AppTypography.smScaled,
        fontWeight: AppTypography.regular,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  // =========================================================
  // BOTTOM NAVIGATION
  // =========================================================

  static TextStyle get homeNavLabelSelected => TextStyle(
        fontSize: AppTypography.xsScaled,
        fontWeight: AppTypography.semiBold,
        color: AppColors.primary,
      );

  static TextStyle get homeNavLabelUnselected => TextStyle(
        fontSize: AppTypography.xsScaled,
        fontWeight: AppTypography.medium,
        color: AppColors.textSecondary,
      );

        // =========================================================
  // REVIEW BOOKING
  // =========================================================

  static TextStyle get reviewTitle => TextStyle(
        fontSize: AppTypography.xxlScaled,
        fontWeight: AppTypography.semiBold,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle get reviewSectionTitle => TextStyle(
        fontSize: AppTypography.lgScaled,
        fontWeight: AppTypography.semiBold,
        color: AppColors.textPrimary,
      );

  static TextStyle get reviewBody => TextStyle(
        fontSize: AppTypography.mdScaled,
        fontWeight: AppTypography.regular,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get reviewSecondary => TextStyle(
        fontSize: AppTypography.smScaled,
        fontWeight: AppTypography.regular,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get reviewLabel => TextStyle(
        fontSize: AppTypography.smScaled,
        fontWeight: AppTypography.medium,
        color: AppColors.textSecondary,
      );

  static TextStyle get reviewValue => TextStyle(
        fontSize: AppTypography.mdScaled,
        fontWeight: AppTypography.medium,
        color: AppColors.textPrimary,
      );

  static TextStyle get reviewAction => TextStyle(
        fontSize: AppTypography.mdScaled,
        fontWeight: AppTypography.semiBold,
        color: AppColors.primary,
      );

  static TextStyle get reviewButton => TextStyle(
        fontSize: AppTypography.mdScaled,
        fontWeight: AppTypography.semiBold,
        color: AppColors.white,
      );

  static TextStyle get reviewPrice => TextStyle(
        fontSize: AppTypography.xxlScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle get reviewFareTitle => TextStyle(
        fontSize: AppTypography.mdScaled,
        fontWeight: AppTypography.regular,
        color: AppColors.textSecondary,
      );

  static TextStyle get reviewFareValue => TextStyle(
        fontSize: AppTypography.mdScaled,
        fontWeight: AppTypography.medium,
        color: AppColors.textPrimary,
      );

  static TextStyle get reviewAmountLabel => TextStyle(
        fontSize: AppTypography.lgScaled,
        fontWeight: AppTypography.semiBold,
        color: AppColors.textPrimary,
      );

  static TextStyle get reviewAmount => TextStyle(
        fontSize: AppTypography.displayScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.primary,
      );
}