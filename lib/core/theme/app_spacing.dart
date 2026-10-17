import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  // Base spacing - Partner App standard
  static const double xxs = 4.0;
  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 16.0;
  static const double lg = 20.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double xxxl = 40.0;
  static const double huge = 48.0;

  // Screen padding
  static const double screenHorizontal = 20.0;
  static const double screenVertical = 20.0;

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
  );

  static const EdgeInsets screenPaddingAll = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
    vertical: screenVertical,
  );

  // Component padding
  static const EdgeInsets cardPadding = EdgeInsets.all(16.0);

  static const EdgeInsets cardPaddingLarge = EdgeInsets.all(20.0);

  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 16.0,
  );

  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: 20.0,
    vertical: 16.0,
  );

  // Common gaps
  static const SizedBox gapXXS = SizedBox(height: xxs);
  static const SizedBox gapXS = SizedBox(height: xs);
  static const SizedBox gapSM = SizedBox(height: sm);
  static const SizedBox gapMD = SizedBox(height: md);
  static const SizedBox gapLG = SizedBox(height: lg);
  static const SizedBox gapXL = SizedBox(height: xl);
  static const SizedBox gapXXL = SizedBox(height: xxl);
  static const SizedBox gapXXXL = SizedBox(height: xxxl);

  // Horizontal gaps
  static const SizedBox horizontalXXS = SizedBox(width: xxs);
  static const SizedBox horizontalXS = SizedBox(width: xs);
  static const SizedBox horizontalSM = SizedBox(width: sm);
  static const SizedBox horizontalMD = SizedBox(width: md);
  static const SizedBox horizontalLG = SizedBox(width: lg);
  static const SizedBox horizontalXL = SizedBox(width: xl);

  // Radius - Partner App standard
  static const double radiusXS = 6.0;
  static const double radiusSM = 10.0;
  static const double radiusMD = 14.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;

  // Existing Client App radius names
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusExtraLarge = 20.0;
  static const double radiusCard = 16.0;
  static const double radiusButton = 14.0;
  static const double radiusInput = 14.0;
  static const double radiusCircular = 999.0;

  // Component heights
  static const double buttonHeight = 54.0;
  static const double inputHeight = 56.0;
  static const double otpFieldHeight = 54.0;
  static const double appBarHeight = 56.0;
  static const double bottomNavigationHeight = 72.0;

  // Icon sizes - Partner App
  static const double iconXS = 16.0;
  static const double iconSM = 20.0;
  static const double iconMD = 24.0;
  static const double iconLG = 28.0;
  static const double iconXL = 32.0;
  static const double iconXXL = 40.0;

  // Existing Client App icon names
  static const double iconSmall = 20.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 28.0;
  static const double iconExtraLarge = 40.0;

  // Border
  static const double borderThin = 1.0;
  static const double borderMedium = 2.0;

  // Shadow
  static const double shadowBlur = 20.0;

  // Existing Home Screen constants
  static const double profileAvatarSize = 66.0;
  static const double serviceCardHeight = 230.0;
  static const double serviceIconContainer = 92.0;
  static const double rewardLogoSize = 88.0;
  static const double announcementCardHeight = 150.0;
  static const double announcementCardWidth = 330.0;
  static const double bottomNavigationSpace = 120.0;
  static const double bottomNavigationRadius = 28.0;

  // Existing Service Card constants
  static const double serviceImageWidth = 130.0;
  static const double serviceImageHeight = 130.0;

  // Auth dimensions
  static const double authPhoneRadius = 32.0;
  static const double authOtpFieldWidth = 48.0;
  static const double authOtpFieldMinWidth = 32.0;
  static const double authOtpGap = 8.0;
  static const double authArrowIcon = 22.0;
  static const double authEditIcon = 20.0;

  static double authHorizontalPadding(double width) {
    return width < 360 ? 16.0 : screenHorizontal;
  }

  static double authLogoHeight(double height) {
    if (height < 700) return 82.0;
    if (height < 820) return 92.0;
    return 104.0;
  }

  static double authTruckHeight(double height) {
    if (height < 700) return 165.0;
    if (height < 820) return 190.0;
    return 210.0;
  }

  static double authTopGap(double height) {
    if (height < 700) return 8.0;
    if (height < 820) return 12.0;
    return 16.0;
  }

  static double authSectionGap(double height) {
    if (height < 700) return 10.0;
    if (height < 820) return 12.0;
    return 16.0;
  }
}
