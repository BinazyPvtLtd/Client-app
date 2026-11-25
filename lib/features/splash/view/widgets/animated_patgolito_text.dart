


// import 'dart:math' as math;
// import 'package:flutter/material.dart';

// class AnimatedPatgolitoLogo extends StatefulWidget {
//   const AnimatedPatgolitoLogo({super.key});

//   @override
//   State<AnimatedPatgolitoLogo> createState() =>
//       _AnimatedPatgolitoLogoState();
// }

// class _AnimatedPatgolitoLogoState
//     extends State<AnimatedPatgolitoLogo>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 2200),
//     )..forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final availableWidth = constraints.maxWidth.isFinite
//             ? constraints.maxWidth
//             : MediaQuery.sizeOf(context).width;

//         final width = math.min(availableWidth * 0.96, 440.0);
//         final scale = width / 1536.0;

//         return SizedBox(
//           width: width,
//           height: 560 * scale,
//           child: AnimatedBuilder(
//             animation: _controller,
//             builder: (context, child) {
//               final progress = Curves.easeInOutCubic.transform(
//                 _controller.value,
//               );

//               return Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Positioned.fill(
//                     child: CustomPaint(
//                       painter: _ArrowPainter(progress: progress),
//                     ),
//                   ),

//                   _asset('left_pin.png', 102, 174, 116, 168, scale),

//                   _asset('right_pin.png', 1315, 174, 123, 168, scale),

//                   _asset('truck.png', 600, 0, 359, 241, scale),

//                   _asset('word.png', 82, 351, 1372, 194, scale),
//                 ],
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   Widget _asset(
//     String file,
//     double x,
//     double y,
//     double w,
//     double h,
//     double scale,
//   ) {
//     return Positioned(
//       left: x * scale,
//       top: y * scale,
//       width: w * scale,
//       height: h * scale,
//       child: Image.asset(
//         'assets/images/logo/splash/$file',
//         fit: BoxFit.fill,
//         filterQuality: FilterQuality.high,
//       ),
//     );
//   }
// }

// class _ArrowPainter extends CustomPainter {
//   const _ArrowPainter({required this.progress});

//   final double progress;

//   @override
//   void paint(Canvas canvas, Size size) {
//     canvas.save();
//     canvas.scale(size.width / 1536, size.height / 560);
//     canvas.translate(0, -224);

//     final route = Path()
//       ..moveTo(225, 523)
//       ..cubicTo(320, 436, 465, 370, 600, 350)
//       ..cubicTo(780, 320, 1055, 352, 1219, 473)
//       ..cubicTo(1242, 493, 1265, 512, 1294, 523);

//     _drawVariableWidthPath(
//       canvas,
//       route,
//       progress,
//       minWidth: 10,
//       maxWidth: 50,
//     );

//     if (progress > 0.88) {
//       final headProgress =
//           ((progress - 0.88) / 0.12).clamp(0.0, 1.0);

//       final head = Path()
//         ..moveTo(1228, 395)
//         ..quadraticBezierTo(1260, 440, 1294, 523)
//         ..quadraticBezierTo(1235, 537, 1155, 515);

//       final headPaint = Paint()
//         ..color = Colors.white
//         ..strokeWidth = 27
//         ..strokeCap = StrokeCap.round
//         ..strokeJoin = StrokeJoin.round
//         ..style = PaintingStyle.stroke
//         ..isAntiAlias = true;

//       for (final metric in head.computeMetrics()) {
//         canvas.drawPath(
//           metric.extractPath(0, metric.length * headProgress),
//           headPaint,
//         );
//       }
//     }

//     canvas.restore();
//   }

//   void _drawVariableWidthPath(
//     Canvas canvas,
//     Path path,
//     double progress, {
//     required double minWidth,
//     required double maxWidth,
//   }) {
//     final reveal = progress.clamp(0.0, 1.0);

//     for (final metric in path.computeMetrics()) {
//       final visibleLength = metric.length * reveal;
//       if (visibleLength <= 0) continue;

//       final sampleCount =
//           math.max(2, (visibleLength / 1.5).ceil());

//       final points = <Offset>[];
//       final widths = <double>[];

//       for (int i = 0; i <= sampleCount; i++) {
//         final distance = visibleLength * i / sampleCount;
//         final tangent = metric.getTangentForOffset(distance);

//         if (tangent == null) continue;

//         points.add(tangent.position);

//         final t = (distance / metric.length).clamp(0.0, 1.0);
//         final smoothWidth = math.sin(math.pi * t);

//         widths.add(
//           minWidth + (maxWidth - minWidth) * smoothWidth,
//         );
//       }

//       if (points.length < 2) continue;

//       final leftSide = <Offset>[];
//       final rightSide = <Offset>[];

//       for (int i = 0; i < points.length; i++) {
//         final previous = points[math.max(0, i - 1)];
//         final next = points[math.min(points.length - 1, i + 1)];

//         final direction = next - previous;
//         final length = math.sqrt(
//           direction.dx * direction.dx +
//               direction.dy * direction.dy,
//         );

//         if (length == 0) continue;

//         final normal = Offset(
//           -direction.dy / length,
//           direction.dx / length,
//         );

//         final halfWidth = widths[i] / 2;

//         leftSide.add(points[i] + normal * halfWidth);
//         rightSide.add(points[i] - normal * halfWidth);
//       }

//       if (leftSide.length < 2 ||
//           rightSide.length != leftSide.length) {
//         continue;
//       }

//       final outline = Path()
//         ..moveTo(leftSide.first.dx, leftSide.first.dy);

//       for (final point in leftSide.skip(1)) {
//         outline.lineTo(point.dx, point.dy);
//       }

//       for (final point in rightSide.reversed) {
//         outline.lineTo(point.dx, point.dy);
//       }

//       outline.close();

//       final fillPaint = Paint()
//         ..color = Colors.white
//         ..style = PaintingStyle.fill
//         ..isAntiAlias = true;

//       canvas.drawPath(outline, fillPaint);

//       canvas.drawCircle(points.first, widths.first / 2, fillPaint);
//       canvas.drawCircle(points.last, widths.last / 2, fillPaint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant _ArrowPainter oldDelegate) {
//     return oldDelegate.progress != progress;
//   }
// }




import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedPatgolitoLogo extends StatefulWidget {
  const AnimatedPatgolitoLogo({super.key});

  @override
  State<AnimatedPatgolitoLogo> createState() =>
      _AnimatedPatgolitoLogoState();
}

class _AnimatedPatgolitoLogoState
    extends State<AnimatedPatgolitoLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;

        final width = math.min(availableWidth * 0.96, 440.0);
        final scale = width / 1536.0;

        return SizedBox(
          width: width,
          height: 560 * scale,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final progress = Curves.easeInOutCubic.transform(
                _controller.value,
              );

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // Animated arrow
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _ArrowPainter(progress: progress),
                    ),
                  ),

                  // Left pin
                  _asset(
                    'left_pin.png',
                    102,
                    174,
                    116,
                    168,
                    scale,
                  ),

                  // Right pin
                  _asset(
                    'right_pin.png',
                    1315,
                    174,
                    123,
                    168,
                    scale,
                  ),

                  // Truck stays above arrow
                  _asset(
                    'truck.png',
                    600,
                    0,
                    359,
                    241,
                    scale,
                  ),

                  // Brand word
                  _asset(
                    'word.png',
                    82,
                    351,
                    1372,
                    194,
                    scale,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _asset(
    String file,
    double x,
    double y,
    double w,
    double h,
    double scale,
  ) {
    return Positioned(
      left: x * scale,
      top: y * scale,
      width: w * scale,
      height: h * scale,
      child: Image.asset(
        'assets/images/logo/splash/$file',
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  const _ArrowPainter({
    required this.progress,
  });

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();

    canvas.scale(
      size.width / 1536,
      size.height / 560,
    );

    canvas.translate(0, -224);

    final route = Path()
      ..moveTo(225, 523)
      ..cubicTo(320, 436, 465, 370, 600, 350)
      ..cubicTo(780, 320, 1055, 352, 1219, 473)
      ..cubicTo(1242, 493, 1265, 512, 1294, 523);

    // Draw arrow with a fixed gap around the truck.
    _drawVariableWidthPath(
      canvas,
      route,
      progress,
      minWidth: 10,
      maxWidth: 50,
    );

    // Arrow head
    if (progress > 0.88) {
      final headProgress =
          ((progress - 0.88) / 0.12).clamp(0.0, 1.0);

      final head = Path()
        ..moveTo(1228, 395)
        ..quadraticBezierTo(1260, 440, 1294, 523)
        ..quadraticBezierTo(1235, 537, 1155, 515);

      final headPaint = Paint()
        ..color = Colors.white
        ..strokeWidth = 27
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke
        ..isAntiAlias = true;

      for (final metric in head.computeMetrics()) {
        canvas.drawPath(
          metric.extractPath(
            0,
            metric.length * headProgress,
          ),
          headPaint,
        );
      }
    }

    canvas.restore();
  }

  void _drawVariableWidthPath(
    Canvas canvas,
    Path path,
    double progress, {
    required double minWidth,
    required double maxWidth,
  }) {
    final reveal = progress.clamp(0.0, 1.0);

    for (final metric in path.computeMetrics()) {
      final visibleLength = metric.length * reveal;

      if (visibleLength <= 0) continue;

      final sampleCount =
          math.max(2, (visibleLength / 1.5).ceil());

      final points = <Offset>[];
      final widths = <double>[];

      for (int i = 0; i <= sampleCount; i++) {
        final distance = visibleLength * i / sampleCount;
        final tangent = metric.getTangentForOffset(distance);

        if (tangent == null) continue;

        points.add(tangent.position);

        final t = (distance / metric.length).clamp(0.0, 1.0);
        final smoothWidth = math.sin(math.pi * t);

        widths.add(
          minWidth + (maxWidth - minWidth) * smoothWidth,
        );
      }

      if (points.length < 2) continue;

      final leftSide = <Offset>[];
      final rightSide = <Offset>[];

      for (int i = 0; i < points.length; i++) {
        final previous = points[math.max(0, i - 1)];
        final next = points[math.min(points.length - 1, i + 1)];

        final direction = next - previous;

        final length = math.sqrt(
          direction.dx * direction.dx +
              direction.dy * direction.dy,
        );

        if (length == 0) continue;

        final normal = Offset(
          -direction.dy / length,
          direction.dx / length,
        );

        final halfWidth = widths[i] / 2;

        leftSide.add(points[i] + normal * halfWidth);
        rightSide.add(points[i] - normal * halfWidth);
      }

      if (leftSide.length < 2 ||
          rightSide.length != leftSide.length) {
        continue;
      }

      final outline = Path()
        ..moveTo(
          leftSide.first.dx,
          leftSide.first.dy,
        );

      for (final point in leftSide.skip(1)) {
        outline.lineTo(point.dx, point.dy);
      }

      for (final point in rightSide.reversed) {
        outline.lineTo(point.dx, point.dy);
      }

      outline.close();

      final fillPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill
        ..isAntiAlias = true;

      // IMPORTANT:
      // Exclude the complete truck area from arrow drawing.
      // Coordinates are in the original 1536 x 560 canvas.
      const truckArea = Rect.fromLTRB(
        570,
        210,
        990,
        410,
      );

      canvas.save();

      final fullArea = Path()
        ..addRect(
          const Rect.fromLTWH(0, 0, 1536, 560),
        );

      final excludedArea = Path()
        ..addRect(truckArea);

      final visibleArea = Path.combine(
        PathOperation.difference,
        fullArea,
        excludedArea,
      );

      canvas.clipPath(visibleArea);

      canvas.drawPath(outline, fillPaint);

      canvas.drawCircle(
        points.first,
        widths.first / 2,
        fillPaint,
      );

      canvas.drawCircle(
        points.last,
        widths.last / 2,
        fillPaint,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
