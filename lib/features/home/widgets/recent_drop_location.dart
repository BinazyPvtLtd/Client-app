import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class RecentDropLocation extends StatelessWidget {
  final String location;
  final VoidCallback onTap;

  const RecentDropLocation({
    super.key,
    required this.location,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,

        borderRadius: BorderRadius.circular(
          AppSpacing.radiusCard,
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm,
          ),

          child: Row(
            children: [
              // =============================================
              // HISTORY ICON
              // =============================================

              Container(
                width: 38,
                height: 38,

                alignment: Alignment.center,

                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,

                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),

                child: const Icon(
                  Icons.history_rounded,
                  size: 20,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(
                width: AppSpacing.md,
              ),

              // =============================================
              // LOCATION
              // =============================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Recent drop',
                      style: AppTextStyles.labelLarge,
                    ),

                    const SizedBox(
                      height: AppSpacing.xs,
                    ),

                    Text(
                      location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: AppSpacing.sm,
              ),

              // =============================================
              // REUSE LOCATION
              // =============================================

              const Icon(
                Icons.north_west_rounded,
                size: 18,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}