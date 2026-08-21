import 'package:client_app/core/theme/app_colors.dart';
import 'package:client_app/core/theme/app_spacing.dart';
import 'package:client_app/core/theme/app_text_styles.dart';
import 'package:client_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';



import '../viewmodel/cancel_booking_viewmodel.dart';

class CancelBookingSheet extends StatefulWidget {
  const CancelBookingSheet({
    super.key,
  });

  @override
  State<CancelBookingSheet> createState() =>
      _CancelBookingSheetState();
}

class _CancelBookingSheetState
    extends State<CancelBookingSheet> {
  late final CancelBookingViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = CancelBookingViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                AppSpacing.radiusExtraLarge,
              ),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // =============================================
                // DRAG HANDLE
                // =============================================

                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSpacing.md,
                  ),
                  child: Container(
                    width: 56,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusCircular,
                      ),
                    ),
                  ),
                ),

                // =============================================
                // SCROLLABLE CONTENT
                // =============================================

                Flexible(
                  child: SingleChildScrollView(
                    physics:
                        const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenHorizontal,
                      AppSpacing.xxl,
                      AppSpacing.screenHorizontal,
                      AppSpacing.lg,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        // =====================================
                        // TITLE
                        // =====================================

                        Text(
                          'Cancel Booking?',
                          style: AppTextStyles.heading1.copyWith(
                            fontWeight:
                                AppTypography.bold,
                          ),
                        ),

                        const SizedBox(
                          height: AppSpacing.sm,
                        ),

                        Text(
                          'Please select a reason for cancellation',
                          style:
                              AppTextStyles.bodyLarge.copyWith(
                            color:
                                AppColors.textSecondary,
                          ),
                        ),

                        const SizedBox(
                          height: AppSpacing.xxl,
                        ),

                        // =====================================
                        // REASONS
                        // =====================================

                        ..._viewModel.reasons.map(
                          (reason) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(
                                bottom: AppSpacing.md,
                              ),
                              child: _ReasonTile(
                                title: reason,
                                selected:
                                    _viewModel.isSelected(
                                  reason,
                                ),
                                onTap: () {
                                  _viewModel.selectReason(
                                    reason,
                                  );
                                },
                              ),
                            );
                          },
                        ),

                        const SizedBox(
                          height: AppSpacing.lg,
                        ),

                        // =====================================
                        // FEE INFORMATION
                        // =====================================

                        _buildFeeWarning(),
                      ],
                    ),
                  ),
                ),

                // =============================================
                // FIXED ACTION AREA
                // =============================================

                _buildActions(),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // FEE WARNING
  // =========================================================

  Widget _buildFeeWarning() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(
          AppColors.opacityExtraLight,
        ),
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusCard,
        ),
        border: Border.all(
          color: AppColors.error.withOpacity(
            AppColors.opacityLightStrong,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: AppColors.error,
            size: AppSpacing.iconMedium,
          ),

          const SizedBox(
            width: AppSpacing.md,
          ),

          Expanded(
            child: RichText(
              text: TextSpan(
                style:
                    AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.5,
                ),
                children: [
                  const TextSpan(
                    text:
                        'A cancellation fee of ',
                  ),
                  TextSpan(
                    text: '₹25',
                    style:
                        AppTextStyles.bodyMedium
                            .copyWith(
                      color: AppColors.error,
                      fontWeight:
                          AppTypography.semiBold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        ' may apply if the captain has already reached the pickup location.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // ACTIONS
  // =========================================================

  Widget _buildActions() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.lg,
        AppSpacing.screenHorizontal,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // =============================================
          // KEEP BOOKING
          // =============================================

          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: Text(
                'Keep Booking',
                style: AppTextStyles.buttonText,
              ),
            ),
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          // =============================================
          // CANCEL BOOKING
          // =============================================

          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeight,
            child: OutlinedButton(
              onPressed:
                  _viewModel.isCancelling
                      ? null
                      : () {
                          _viewModel
                              .confirmCancellation(
                            context,
                          );
                        },
              style: OutlinedButton.styleFrom(
                foregroundColor:
                    AppColors.error,
                side: const BorderSide(
                  color: AppColors.error,
                  width:
                      AppSpacing.borderMedium,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    AppSpacing.radiusButton,
                  ),
                ),
              ),
              child:
                  _viewModel.isCancelling
                      ? const SizedBox(
                          width:
                              AppSpacing.iconSmall,
                          height:
                              AppSpacing.iconSmall,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                            color:
                                AppColors.error,
                          ),
                        )
                      : Text(
                          'Cancel Booking',
                          style: AppTextStyles
                              .buttonTextDark
                              .copyWith(
                            color:
                                AppColors.error,
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// REASON TILE
// =====================================================================

class _ReasonTile extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _ReasonTile({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusMedium,
        ),
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 180,
          ),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.lg,
          ),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primary.withOpacity(
                    AppColors.opacityExtraLight,
                  )
                : AppColors.surface,
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusMedium,
            ),
            border: Border.all(
              color: selected
                  ? AppColors.primary
                  : AppColors.border,
              width: selected
                  ? AppSpacing.borderMedium
                  : AppSpacing.borderThin,
            ),
          ),
          child: Row(
            children: [
              // Use native Radio so selection semantics
              // are correct and accessible.
              Radio<bool>(
                value: true,
                groupValue:
                    selected ? true : null,
                activeColor:
                    AppColors.primary,
                    materialTapTargetSize:
      MaterialTapTargetSize.shrinkWrap,
                onChanged: (_) {
                  onTap();
                },
              ),

              const SizedBox(
                width: AppSpacing.sm,
              ),

              Expanded(
                child: Text(
                  title,
                  style:
                      AppTextStyles.bodyLarge.copyWith(
                    color:
                        AppColors.textPrimary,
                    fontWeight:
                        AppTypography.medium,
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