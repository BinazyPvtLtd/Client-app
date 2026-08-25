import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AnimatedPatgolitoLogo extends StatefulWidget {
  const AnimatedPatgolitoLogo({
    super.key,
  });

  @override
  State<AnimatedPatgolitoLogo> createState() =>
      _AnimatedPatgolitoLogoState();
}

class _AnimatedPatgolitoLogoState
    extends State<AnimatedPatgolitoLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _routeAnimation;

  late final Animation<double> _truckOpacity;

  late final Animation<double> _brandOpacity;

  late final Animation<double> _tagScale;

  @override
  void initState() {
    super.initState();

    // =========================================================
    // MAIN ANIMATION CONTROLLER
    // =========================================================

    _controller = AnimationController(
      vsync: this,

      // Truck movement itself remains smooth and premium.
      duration: const Duration(
        milliseconds: 4000,
      ),
    );

    // =========================================================
    // ROUTE / TRUCK
    //
    // First ~8% delay
    // then truck moves smoothly until ~82%.
    // =========================================================

    _routeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.05,
    0.88,
        curve: Curves.easeInOutCubicEmphasized,
      ),
    );

    // =========================================================
    // TRUCK FADE
    // =========================================================

    _truckOpacity = TweenSequence<double>(
      [
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 0,
            end: 1,
          ).chain(
            CurveTween(
              curve: Curves.easeOut,
            ),
          ),
          weight: 15,
        ),

        TweenSequenceItem(
          tween:  ConstantTween<double>(
            1,
          ),
          weight: 85,
        ),
      ],
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.04,
          0.90,
        ),
      ),
    );

    // =========================================================
    // PATGOLITO TEXT FADE
    // =========================================================

    _brandOpacity = CurvedAnimation(
  parent: _controller,
  curve: const Interval(
    0.25,
    0.55,
    curve: Curves.easeOutCubic,
  ),
);

    // =========================================================
    // FINAL SOFT SCALE
    // =========================================================

    _tagScale = Tween<double>(
      begin: 0.96,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.55,
          0.92,
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 215,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (
          context,
          child,
        ) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // =================================================
              // ROUTE + TRUCK
              // =================================================

              SizedBox(
                width: 320,
                height: 125,
                child: CustomPaint(
                  painter: _DeliveryRoutePainter(
                    progress:
                        _routeAnimation.value,
                  ),
                  child: LayoutBuilder(
                    builder: (
                      context,
                      constraints,
                    ) {
                      return _buildTruckRoute(
                        constraints.biggest,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              // =================================================
              // PATGOLITO
              // =================================================

              FadeTransition(
                opacity: _brandOpacity,
                child: ScaleTransition(
                  scale: _tagScale,
                  child: Text(
                    'PATGOLITO',
                    textAlign:
                        TextAlign.center,
                    style:
                        AppTextStyles.splashLogoText.copyWith(
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ===========================================================
  // TRUCK ROUTE
  // ===========================================================

  Widget _buildTruckRoute(
    Size size,
  ) {
    final double progress =
        _routeAnimation.value;

    // Same Bezier used by painter.
    final Offset start = Offset(
      30,
      size.height - 28,
    );

    final Offset control = Offset(
      size.width / 2,
      5,
    );

    final Offset end = Offset(
      size.width - 30,
      size.height - 28,
    );

    // =========================================================
    // QUADRATIC BEZIER POSITION
    // =========================================================

    final Offset truckPosition =
        _quadraticBezier(
      start,
      control,
      end,
      progress,
    );

    // =========================================================
    // PATH DIRECTION
    // Used to rotate truck slightly according to route.
    // =========================================================

    final Offset tangent =
        _quadraticBezierDerivative(
      start,
      control,
      end,
      progress,
    );

    final double angle =
        math.atan2(
      tangent.dy,
      tangent.dx,
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // =====================================================
        // START PIN
        // =====================================================

        Positioned(
          left: start.dx - 26,
          top: start.dy - 31,
          child: const _LocationPin(),
        ),

        // =====================================================
        // END PIN
        // =====================================================

        Positioned(
          left: end.dx - 26,
          top: end.dy - 31,
          child: const _LocationPin(),
        ),

        // =====================================================
        // TRUCK
        // =====================================================

        Positioned(
          left: truckPosition.dx - 31,
          top: truckPosition.dy - 36,

          child: Opacity(
            opacity:
                _truckOpacity.value,

            child: Transform.rotate(
              // Very subtle rotation only.
              angle: angle * 0.08,

              child: Transform.scale(
                scale:
                    1 +
                    (0.015 *
                        math.sin(
                          progress *
                              math.pi,
                        )),

                child: const _TruckWidget(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================
  // QUADRATIC BEZIER
  // ===========================================================

  Offset _quadraticBezier(
    Offset start,
    Offset control,
    Offset end,
    double t,
  ) {
    final double inverse =
        1 - t;

    return Offset(
      (inverse * inverse * start.dx) +
          (2 *
              inverse *
              t *
              control.dx) +
          (t * t * end.dx),

      (inverse * inverse * start.dy) +
          (2 *
              inverse *
              t *
              control.dy) +
          (t * t * end.dy),
    );
  }

  // ===========================================================
  // BEZIER DIRECTION
  // ===========================================================

  Offset _quadraticBezierDerivative(
    Offset start,
    Offset control,
    Offset end,
    double t,
  ) {
    return Offset(
      2 *
          ((1 - t) *
                  (control.dx -
                      start.dx) +
              t *
                  (end.dx -
                      control.dx)),

      2 *
          ((1 - t) *
                  (control.dy -
                      start.dy) +
              t *
                  (end.dy -
                      control.dy)),
    );
  }
}

// =====================================================================
// TRUCK
// =====================================================================

class _TruckWidget extends StatelessWidget {
  const _TruckWidget();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 56,
      height: 48,
      child: Icon(
        Icons.local_shipping_rounded,
        size: 52,
        color: AppColors.white,
      ),
    );
  }
}
// =====================================================================
// LOCATION PIN
// =====================================================================

class _LocationPin extends StatelessWidget {
  const _LocationPin();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 62,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // ==========================================
          // PIN
          // ==========================================

          CustomPaint(
            size: const Size(
              48,
              56,
            ),
            painter: _LocationPinPainter(),
          ),

          // ==========================================
          // CENTER DOT
          // ==========================================

          Positioned(
            top: 13,
            child: Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // ==========================================
          // SMALL BASE
          // ==========================================

          Positioned(
            bottom: 0,
            child: Container(
              width: 30,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(
                  0.75,
                ),
                borderRadius: BorderRadius.circular(
                  100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _LocationPinPainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final Paint paint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final Path path = Path();

    final double centerX =
        size.width / 2;

    final double topRadius =
        size.width * 0.40;

    // Start from bottom point.
    path.moveTo(
      centerX,
      size.height - 4,
    );

    // Left side.
    path.cubicTo(
      centerX - 6,
      size.height - 14,
      centerX - topRadius,
      size.height * 0.53,
      centerX - topRadius,
      size.height * 0.35,
    );

    // Top-left curve.
    path.cubicTo(
      centerX - topRadius,
      8,
      centerX - 10,
      2,
      centerX,
      2,
    );

    // Top-right curve.
    path.cubicTo(
      centerX + 10,
      2,
      centerX + topRadius,
      8,
      centerX + topRadius,
      size.height * 0.35,
    );

    // Right side back to bottom.
    path.cubicTo(
      centerX + topRadius,
      size.height * 0.53,
      centerX + 6,
      size.height - 14,
      centerX,
      size.height - 4,
    );

    path.close();

    canvas.drawPath(
      path,
      paint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}
// =====================================================================
// ROUTE PAINTER
// =====================================================================

class _DeliveryRoutePainter
    extends CustomPainter {
  final double progress;

  const _DeliveryRoutePainter({
    required this.progress,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    // =========================================================
    // ROUTE
    // =========================================================

    final Offset start = Offset(
      30,
      size.height - 24,
    );

    final Offset control = Offset(
      size.width / 2,
      5,
    );

    final Offset end = Offset(
      size.width - 30,
      size.height - 24,
    );

    final Path path = Path()
      ..moveTo(
        start.dx,
        start.dy,
      )
      ..quadraticBezierTo(
        control.dx,
        control.dy,
        end.dx,
        end.dy,
      );

    // =========================================================
    // INACTIVE ROUTE
    // =========================================================

    final Paint backgroundPaint =
        Paint()
          ..color = AppColors.white.withOpacity(
            0.22,
          )
          ..strokeWidth = 4
          ..style =
              PaintingStyle.stroke
          ..strokeCap =
              StrokeCap.round;

    canvas.drawPath(
      path,
      backgroundPaint,
    );

    // =========================================================
    // ACTIVE ROUTE
    // =========================================================

    final Paint activePaint =
        Paint()
          ..color = AppColors.white
          ..strokeWidth = 4
          ..style =
              PaintingStyle.stroke
          ..strokeCap =
              StrokeCap.round;

    for (final PathMetric metric
        in path.computeMetrics()) {
      final Path animatedPath =
          metric.extractPath(
        0,
        metric.length *
            progress.clamp(
              0.0,
              1.0,
            ),
      );

      canvas.drawPath(
        animatedPath,
        activePaint,
      );
    }

    // =========================================================
    // ARROW
    // =========================================================

    if (progress > 0.92) {
      final Paint arrowPaint =
          Paint()
            ..color =
                AppColors.white
            ..strokeWidth = 4
            ..strokeCap =
                StrokeCap.round;

      canvas.drawLine(
        Offset(
          end.dx,
          end.dy,
        ),
        Offset(
          end.dx - 13,
          end.dy - 10,
        ),
        arrowPaint,
      );

      canvas.drawLine(
        Offset(
          end.dx,
          end.dy,
        ),
        Offset(
          end.dx - 13,
          end.dy + 7,
        ),
        arrowPaint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant _DeliveryRoutePainter
        oldDelegate,
  ) {
    return oldDelegate.progress !=
        progress;
  }
}