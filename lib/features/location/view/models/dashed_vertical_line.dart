import 'package:client_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';


/// A short dashed vertical line connecting the pickup and drop rows,
/// mirroring the ride/delivery-app pattern from the reference design.
class DashedVerticalLine extends StatelessWidget {
  const DashedVerticalLine({
    super.key,
    this.height = 28,
    this.dashCount = 4,
  });

  final double height;
  final int dashCount;

  @override
  Widget build(BuildContext context) {
    final dashHeight = (height / (dashCount * 2)) - 1;

    return SizedBox(
      height: height,
      width: 2,
      child: Column(
        children: List.generate(dashCount * 2, (index) {
          if (index.isOdd) {
            return SizedBox(height: dashHeight);
          }
          return Container(
            width: 2,
            height: dashHeight,
            color: AppColors.border,
          );
        }),
      ),
    );
  }
}
