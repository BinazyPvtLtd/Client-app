import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../model/notification_model.dart';
import '../viewmodel/notification_viewmodel.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  State<NotificationScreen> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState
    extends State<NotificationScreen> {
  late final NotificationViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = NotificationViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (
            context,
            _,
          ) {
            return Column(
              children: [
                // ==========================================
                // HEADER
                // ==========================================

                _buildHeader(),

                const SizedBox(
                  height: AppSpacing.lg,
                ),

                // ==========================================
                // NOTIFICATION LIST
                // ==========================================

                Expanded(
                  child:
                      _viewModel.notifications.isEmpty
                          ? _buildEmptyState()
                          : _buildNotificationList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // =========================================================
  // HEADER
  // =========================================================

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.lg,
        AppSpacing.screenHorizontal,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          // BACK

          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.primary,
              size: AppSpacing.iconLarge,
            ),
          ),

          const SizedBox(
            width: AppSpacing.md,
          ),

          // TITLE

          Expanded(
            child: Text(
              'Notifications',
              style:
                  AppTextStyles.screenTitle.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // MORE

          IconButton(
            onPressed: () {
              _viewModel.showMoreOptions(
                context,
              );
            },
            icon: const Icon(
              Icons.more_vert_rounded,
              color: AppColors.primary,
              size: AppSpacing.iconLarge,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // LIST
  // =========================================================

  Widget _buildNotificationList() {
    return ListView.separated(
      physics:
          const BouncingScrollPhysics(),

      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        0,
        AppSpacing.screenHorizontal,
        AppSpacing.xxl,
      ),

      itemCount:
          _viewModel.notifications.length,

      separatorBuilder: (
        context,
        index,
      ) {
        return const SizedBox(
          height: AppSpacing.md,
        );
      },

      itemBuilder: (
        context,
        index,
      ) {
        final notification =
            _viewModel.notifications[index];

        return _NotificationCard(
          notification: notification,
          onTap: () {
            _viewModel.openNotification(
              context,
              notification,
            );
          },
        );
      },
    );
  }

  // =========================================================
  // EMPTY STATE
  // =========================================================

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.xxl,
        ),
        child: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              alignment: Alignment.center,
              decoration:
                  const BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                color:
                    AppColors.textSecondary,
                size: AppSpacing.iconLarge,
              ),
            ),

            const SizedBox(
              height: AppSpacing.xl,
            ),

            Text(
              'No notifications yet',
              style:
                  AppTextStyles.heading2,
            ),

            const SizedBox(
              height: AppSpacing.sm,
            ),

            Text(
              'Your trip, payment and service updates will appear here.',
              textAlign: TextAlign.center,
              style:
                  AppTextStyles.bodyMedium.copyWith(
                color:
                    AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// NOTIFICATION CARD
// =====================================================================

class _NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.notification,
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
        child: IntrinsicHeight(
          child: Container(
            width: double.infinity,

            // Reduced from 108
            constraints: const BoxConstraints(
              minHeight: 88,
            ),

            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusCard,
              ),
              border: Border.all(
                color: AppColors.border,
              ),
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // UNREAD INDICATOR
                AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  width: notification.isUnread ? 4 : 0,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        AppSpacing.radiusCard,
                      ),
                      bottomLeft: Radius.circular(
                        AppSpacing.radiusCard,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    // Reduced padding
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.center,
                      children: [
                        _NotificationIcon(
                          notification: notification,
                        ),

                        const SizedBox(
                          width: AppSpacing.md,
                        ),

                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      notification.title,
                                      maxLines: 1,
                                      overflow:
                                          TextOverflow.ellipsis,
                                      style:
                                          AppTextStyles.heading3,
                                    ),
                                  ),

                                  const SizedBox(
                                    width: AppSpacing.sm,
                                  ),

                                  Text(
                                    notification.time,
                                    style: AppTextStyles
                                        .labelMedium
                                        .copyWith(
                                      color: AppColors
                                          .textSecondary,
                                    ),
                                  ),

                                  if (notification.isUnread) ...[
                                    const SizedBox(
                                      width: AppSpacing.sm,
                                    ),
                                    Container(
                                      width: 7,
                                      height: 7,
                                      decoration:
                                          const BoxDecoration(
                                        color:
                                            AppColors.primary,
                                        shape:
                                            BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ],
                              ),

                              const SizedBox(
                                height: AppSpacing.xs,
                              ),

                              Text(
                                notification.message,
                                maxLines: 2,
                                overflow:
                                    TextOverflow.ellipsis,
                                style: AppTextStyles
                                    .bodyMedium
                                    .copyWith(
                                  color: AppColors
                                      .textSecondary,
                                  height: 1.25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// =====================================================================
// NOTIFICATION ICON
// =====================================================================

class _NotificationIcon
    extends StatelessWidget {
  final NotificationModel notification;

  const _NotificationIcon({
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCancelled =
        notification.type ==
            NotificationType.bookingCancelled;

    final Color backgroundColor;

    final Color iconColor;

    if (isCancelled) {
      backgroundColor =
          AppColors.error.withOpacity(
        0.12,
      );

      iconColor = AppColors.error;
    } else if (notification.isUnread) {
      backgroundColor =
          AppColors.primary.withOpacity(
        0.15,
      );

      iconColor = AppColors.primary;
    } else {
      backgroundColor =
          AppColors.surface;

      iconColor =
          AppColors.textSecondary;
    }

    return Container(
      width: 44,
      height: 44,

      alignment: Alignment.center,

      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),

      child: Icon(
        notification.icon,
        color: iconColor,
        size: AppSpacing.iconMedium,
      ),
    );
  }
}