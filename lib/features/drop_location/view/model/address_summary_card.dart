import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../viewmodel/drop_location_viewmodel.dart';

class AddressSummaryCard extends StatelessWidget {
  const AddressSummaryCard({super.key, required this.viewModel});

  final DropLocationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(AppColors.opacityShadow),
            blurRadius: AppSpacing.shadowBlur,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: AppSpacing.iconExtraLarge,
            height: AppSpacing.iconExtraLarge,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(AppColors.opacityLight),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.location_on_rounded,
              color: AppColors.primary,
              size: AppSpacing.iconMedium,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewModel.addressTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.heading3,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  viewModel.addressSubtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => viewModel.onChangeAddressPressed(context),
            child: Text(
              'CHANGE',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.primary,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}