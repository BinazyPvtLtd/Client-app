import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../model/vehicle_model.dart';

class VehicleItem extends StatelessWidget {
  final VehicleModel vehicle;
  final VoidCallback onTap;

  const VehicleItem({
    super.key,
    required this.vehicle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        AppSpacing.radiusCircular,
      ),
      child: SizedBox(
        width: 82,
        child: Column(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: Icon(
                vehicle.icon,
                color: AppColors.black,
                size: 31,
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            Text(
              vehicle.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}