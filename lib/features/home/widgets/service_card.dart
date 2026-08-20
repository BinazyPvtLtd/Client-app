import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../model/home_service_model.dart';

class ServiceCard extends StatelessWidget {
  final HomeServiceModel service;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(
        AppSpacing.radiusCard,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusCard,
        ),
        child: Container(
          padding: const EdgeInsets.all(
            AppSpacing.xl,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusCard,
            ),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 66,
                height: 66,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surface,
                ),
                child: Icon(
                  service.icon,
                  size: 30,
                  color: AppColors.black,
                ),
              ),

              const Spacer(),

              Text(
                service.title,
                style: AppTextStyles.homeCardTitle,
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                service.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.homeCardDescription,
              ),
            ],
          ),
        ),
      ),
    );
  }
}