import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class DummyMap extends StatelessWidget {
  const DummyMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F1F1),
      child: Stack(
        children: [
          // ============================================
          // FAKE ROADS - HORIZONTAL
          // ============================================

          Positioned(
            top: 60,
            left: -20,
            right: -20,
            child: Transform.rotate(
              angle: -0.08,
              child: Container(
                height: 12,
                color: AppColors.white,
              ),
            ),
          ),

          Positioned(
            top: 150,
            left: -30,
            right: -30,
            child: Transform.rotate(
              angle: 0.10,
              child: Container(
                height: 16,
                color: AppColors.white,
              ),
            ),
          ),

          Positioned(
            top: 245,
            left: -30,
            right: -30,
            child: Transform.rotate(
              angle: -0.05,
              child: Container(
                height: 10,
                color: AppColors.white,
              ),
            ),
          ),

          // ============================================
          // FAKE ROADS - VERTICAL
          // ============================================

          Positioned(
            top: -50,
            bottom: -50,
            left: 75,
            child: Transform.rotate(
              angle: 0.12,
              child: Container(
                width: 12,
                color: AppColors.white,
              ),
            ),
          ),

          Positioned(
            top: -50,
            bottom: -50,
            right: 85,
            child: Transform.rotate(
              angle: -0.18,
              child: Container(
                width: 14,
                color: AppColors.white,
              ),
            ),
          ),

          // ============================================
          // AREA LABELS
          // ============================================

          const Positioned(
            top: 90,
            left: 40,
            child: _MapLabel(
              text: 'Aliganj',
            ),
          ),

          const Positioned(
            top: 185,
            right: 45,
            child: _MapLabel(
              text: 'Indira Nagar',
            ),
          ),

          const Positioned(
            top: 270,
            left: 130,
            child: _MapLabel(
              text: 'Gomti Nagar',
            ),
          ),

          // ============================================
          // CURRENT LOCATION MARKER
          // ============================================

          Center(
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.black.withValues(
                  alpha: 0.12,
                ),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.white,
                    width: 4,
                  ),
                ),
              ),
            ),
          ),

          // ============================================
          // DUMMY BADGE
          // ============================================

          Positioned(
            top: AppSpacing.lg,
            left: AppSpacing.lg,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                  AppSpacing.radiusMedium,
                ),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 17,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Map Preview',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapLabel extends StatelessWidget {
  final String text;

  const _MapLabel({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary.withValues(
          alpha: 0.7,
        ),
      ),
    );
  }
}