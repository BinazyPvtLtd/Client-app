import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class LocationSearchCard extends StatelessWidget {
  final VoidCallback onTap;

  const LocationSearchCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(
        AppSpacing.radiusExtraLarge,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusExtraLarge,
        ),
        child: Container(
          height: 82,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusExtraLarge,
            ),
            border: Border.all(
              color: AppColors.border,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(
                  alpha: AppColors.opacityShadow,
                ),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(
                Icons.search_rounded,
                size: 34,
                color: AppColors.black,
              ),

              const SizedBox(width: AppSpacing.lg),

              Expanded(
                child: Text(
                  'Where do you want to send?',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}