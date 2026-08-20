import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  // =========================================================
  // LIGHT THEME
  // =========================================================

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      fontFamily: 'Poppins',

      // =====================================================
      // COLOR SCHEME
      // =====================================================

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        primaryContainer: AppColors.primaryLight,
        onPrimaryContainer: AppColors.textPrimary,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        error: AppColors.error,
        onError: AppColors.white,
      ),

      scaffoldBackgroundColor: AppColors.background,

      // =====================================================
      // TEXT THEME
      // =====================================================

      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,

        headlineLarge: AppTextStyles.heading1,
        headlineMedium: AppTextStyles.heading2,
        headlineSmall: AppTextStyles.heading3,

        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,

        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
      ),

      // =====================================================
      // INPUT FIELD
      // =====================================================

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusInput,
          ),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusInput,
          ),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusInput,
          ),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusInput,
          ),
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusInput,
          ),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),

        hintStyle: AppTextStyles.inputHint,

        labelStyle: AppTextStyles.inputLabel,

        errorStyle: AppTextStyles.inputError,
      ),

      // =====================================================
      // APP BAR
      // =====================================================

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
      ),

      // =====================================================
      // ELEVATED BUTTON
      // =====================================================

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,

          minimumSize: const Size(
            double.infinity,
            AppSpacing.buttonHeight,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusButton,
            ),
          ),

          elevation: 0,

          textStyle: AppTextStyles.buttonText,
        ),
      ),

      // =====================================================
      // TEXT BUTTON
      // =====================================================

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.signupAction,
        ),
      ),

      // =====================================================
      // DIVIDER
      // =====================================================

      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
      ),

      // =====================================================
      // PROGRESS INDICATOR
      // =====================================================

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),

      // =====================================================
      // CHECKBOX
      // =====================================================

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }

          return AppColors.surface;
        }),
        side: const BorderSide(
          color: AppColors.border,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusSmall,
          ),
        ),
      ),
    );
  }
}