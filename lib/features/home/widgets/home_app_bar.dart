import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onNotificationPressed;
  final VoidCallback onProfilePressed;

  const HomeAppBar({
    super.key,
    required this.onNotificationPressed,
    required this.onProfilePressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(76);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 76,
      elevation: 0,
      backgroundColor: AppColors.background,
      surfaceTintColor: AppColors.background,
      automaticallyImplyLeading: false,
      titleSpacing: AppSpacing.screenHorizontal,
      title: Row(
        children: [
          InkWell(
            onTap: onProfilePressed,
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusCircular,
            ),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: const Icon(
                Icons.person_outline_rounded,
                color: AppColors.black,
                size: 26,
              ),
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          Text(
            'PATGOLITO',
            style: AppTextStyles.homeAppName.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: onNotificationPressed,
          icon: const Icon(
            Icons.notifications_none_rounded,
            size: 30,
          ),
        ),

        const SizedBox(width: AppSpacing.lg),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(
          height: 1,
          color: AppColors.border,
        ),
      ),
    );
  }
}