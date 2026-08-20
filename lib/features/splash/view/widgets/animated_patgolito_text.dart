import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AnimatedPatgolitoText extends StatefulWidget {
  const AnimatedPatgolitoText({
    super.key,
  });

  @override
  State<AnimatedPatgolitoText> createState() =>
      _AnimatedPatgolitoTextState();
}

class _AnimatedPatgolitoTextState
    extends State<AnimatedPatgolitoText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    // Start the O swap after the splash text appears.
    Future.delayed(
      const Duration(milliseconds: 650),
      () {
        if (!mounted) return;

        _controller.forward();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return _buildText();
        },
      ),
    );
  }

  Widget _buildText() {
    //const double fontSize = 26;

     final TextStyle style = AppTextStyles.splashLogoText;

    // =========================================================
    // ACTUAL LETTER WIDTHS
    // =========================================================

    final double pWidth = _measureText('P', style);
    final double aWidth = _measureText('a', style);
    final double tWidth = _measureText('t', style);
    final double gWidth = _measureText('g', style);
    final double oWidth = _measureText('o', style);
    final double lWidth = _measureText('l', style);
    final double iWidth = _measureText('i', style);
    final double secondTWidth = _measureText('t', style);

    // =========================================================
    // EXACT O POSITIONS
    // =========================================================

    final double firstOPosition =
        pWidth +
        aWidth +
        tWidth +
        gWidth;

    final double secondOPosition =
        firstOPosition +
        oWidth +
        lWidth +
        iWidth +
        secondTWidth;

    // =========================================================
    // WHOLE WORD SHIMMER
    // =========================================================

    final double shimmer = _shimmerValue();

    return SizedBox(
      width: secondOPosition + oWidth,
      height: 55,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // =====================================================
          // P
          // =====================================================

          _staticLetter(
            'P',
            left: 0,
            style: style,
            shimmer: shimmer,
          ),

          // =====================================================
          // A
          // =====================================================

          _staticLetter(
            'a',
            left: pWidth,
            style: style,
            shimmer: shimmer,
          ),

          // =====================================================
          // T
          // =====================================================

          _staticLetter(
            't',
            left: pWidth + aWidth,
            style: style,
            shimmer: shimmer,
          ),

          // =====================================================
          // G
          // =====================================================

          _staticLetter(
            'g',
            left: pWidth + aWidth + tWidth,
            style: style,
            shimmer: shimmer,
          ),

          // =====================================================
          // L
          // =====================================================

          _staticLetter(
            'l',
            left: firstOPosition + oWidth,
            style: style,
            shimmer: shimmer,
          ),

          // =====================================================
          // I
          // =====================================================

          _staticLetter(
            'i',
            left: firstOPosition + oWidth + lWidth,
            style: style,
            shimmer: shimmer,
          ),

          // =====================================================
          // T
          // =====================================================

          _staticLetter(
            't',
            left: firstOPosition +
                oWidth +
                lWidth +
                iWidth,
            style: style,
            shimmer: shimmer,
          ),

          // =====================================================
          // FIRST O
          // =====================================================

          _buildFirstO(
            position: firstOPosition,
            targetPosition: secondOPosition,
            width: oWidth,
            style: style,
            shimmer: shimmer,
          ),

          // =====================================================
          // SECOND O
          // =====================================================

          _buildSecondO(
            position: secondOPosition,
            targetPosition: firstOPosition,
            width: oWidth,
            style: style,
            shimmer: shimmer,
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // FIRST O
  // ===========================================================

  Widget _buildFirstO({
    required double position,
    required double targetPosition,
    required double width,
    required TextStyle style,
    required double shimmer,
  }) {
    final double progress = Curves.easeInOutCubic.transform(
      _controller.value,
    );

    final double x = _interpolate(
      position,
      targetPosition,
      progress,
    );

    // Arc.
    final double arc =
        -30 * math.sin(progress * math.pi);

    // Landing bounce.
    final double landingBounce =
        progress > 0.75
            ? -5 *
                math.sin(
                  ((progress - 0.75) / 0.25) * math.pi * 2,
                ) *
                (progress - 0.75) /
                0.25
            : 0;

    final double y = 7 + arc + landingBounce;

    final double rotation =
        0.14 * math.sin(progress * math.pi);

    final double scale =
        1.0 +
        (0.08 * math.sin(progress * math.pi));

    return Positioned(
      left: x,
      top: y,
      child: Transform.rotate(
        angle: rotation,
        child: Transform.scale(
          scale: scale,
          child: _shimmerText(
            'o',
            style,
            shimmer,
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // SECOND O
  // ===========================================================

  Widget _buildSecondO({
    required double position,
    required double targetPosition,
    required double width,
    required TextStyle style,
    required double shimmer,
  }) {
    final double progress = Curves.easeInOutCubic.transform(
      _controller.value,
    );

    final double x = _interpolate(
      position,
      targetPosition,
      progress,
    );

    // Opposite rotation.
    final double rotation =
        -0.14 * math.sin(progress * math.pi);

    // Same arc.
    final double arc =
        -30 * math.sin(progress * math.pi);

    final double landingBounce =
        progress > 0.75
            ? -5 *
                math.sin(
                  ((progress - 0.75) / 0.25) * math.pi * 2,
                ) *
                (progress - 0.75) /
                0.25
            : 0;

    final double y = 7 + arc + landingBounce;

    final double scale =
        1.0 +
        (0.08 * math.sin(progress * math.pi));

    return Positioned(
      left: x,
      top: y,
      child: Transform.rotate(
        angle: rotation,
        child: Transform.scale(
          scale: scale,
          child: _shimmerText(
            'o',
            style,
            shimmer,
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // STATIC LETTER
  // ===========================================================

  Widget _staticLetter(
    String letter, {
    required double left,
    required TextStyle style,
    required double shimmer,
  }) {
    return Positioned(
      left: left,
      top: 7,
      child: _shimmerText(
        letter,
        style,
        shimmer,
      ),
    );
  }

  // ===========================================================
  // SHIMMER / BLINK
  // ===========================================================

  double _shimmerValue() {
    if (_controller.value < 0.85) {
      return 0;
    }

    final double progress =
        (_controller.value - 0.85) / 0.15;

    return math.sin(
      progress * math.pi,
    );
  }

  Widget _shimmerText(
    String text,
    TextStyle style,
    double shimmer,
  ) {
    final double glow =
        shimmer * 8;

    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 80),
      style: style.copyWith(
        color: Color.lerp(
          AppColors.white,
          AppColors.primaryLight,
          shimmer * 0.35,
        ),
        shadows: shimmer > 0
            ? [
                Shadow(
                  color: AppColors.white.withOpacity(
                    0.55 * shimmer,
                  ),
                  blurRadius: glow,
                ),
              ]
            : null,
      ),
      child: Text(text),
    );
  }

  // ===========================================================
  // TEXT MEASUREMENT
  // ===========================================================

  double _measureText(
    String text,
    TextStyle style,
  ) {
    final TextPainter painter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    return painter.width;
  }

  // ===========================================================
  // INTERPOLATION
  // ===========================================================

  double _interpolate(
    double start,
    double end,
    double progress,
  ) {
    return start +
        ((end - start) * progress);
  }
}