import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../viewmodel/trip_completed_viewmodel.dart';

class TripCompletedScreen extends StatefulWidget {
  const TripCompletedScreen({
    super.key,
  });

  @override
  State<TripCompletedScreen> createState() =>
      _TripCompletedScreenState();
}

class _TripCompletedScreenState
    extends State<TripCompletedScreen> {
  late final TripCompletedViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = TripCompletedViewModel();
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

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: AppSpacing.iconMedium,
          ),
        ),

        title: Text(
          'Trip Completed',
          style: AppTextStyles.screenTitle,
        ),
      ),

      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (
          context,
          _,
        ) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics:
                      const BouncingScrollPhysics(),

                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenHorizontal,
                    AppSpacing.xxxl,
                    AppSpacing.screenHorizontal,
                    AppSpacing.xxl,
                  ),

                  child: Column(
                    children: [
                      const SizedBox(
                        height: AppSpacing.huge,
                      ),

                      // =====================================
                      // COMPLETED ICON
                      // =====================================

                      _buildCompletedIcon(),

                      const SizedBox(
                        height: AppSpacing.xl,
                      ),

                      Text(
                        'Trip completed successfully',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.heading1,
                      ),

                      const SizedBox(
                        height: AppSpacing.sm,
                      ),

                      Text(
                        'Thank you for choosing Patgolito.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium,
                      ),

                      const SizedBox(
                        height: AppSpacing.huge,
                      ),

                      // =====================================
                      // TRIP CARD
                      // =====================================

                      _buildTripCard(),
                    ],
                  ),
                ),
              ),

              // =============================================
              // BOTTOM ACTIONS
              // =============================================

              _buildBottomActions(),
            ],
          );
        },
      ),
    );
  }

  // =========================================================
  // COMPLETED ICON
  // =========================================================

  Widget _buildCompletedIcon() {
    return Container(
      width: 78,
      height: 78,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surface,
        border: Border.all(
          color: AppColors.primary,
          width: AppSpacing.borderMedium,
        ),
      ),
      child: const Icon(
        Icons.check_rounded,
        color: AppColors.primary,
        size: AppSpacing.iconLarge,
      ),
    );
  }

  // =========================================================
  // TRIP CARD
  // =========================================================

  Widget _buildTripCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(
          AppSpacing.radiusCard,
        ),

        border: Border.all(
          color: AppColors.border,
        ),

        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(
              AppColors.opacityShadow,
            ),
            blurRadius: AppSpacing.shadowBlur,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          // =============================================
          // TRIP ID + FARE
          // =============================================

          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TRIP ID',
                      style:
                          AppTextStyles.labelLarge,
                    ),

                    const SizedBox(
                      height: AppSpacing.sm,
                    ),

                    Text(
                      _viewModel.tripId,
                      style:
                          AppTextStyles.heading2,
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [
                  Text(
                    'TOTAL FARE',
                    style:
                        AppTextStyles.labelLarge,
                  ),

                  const SizedBox(
                    height: AppSpacing.sm,
                  ),

                  Text(
                    '₹${_viewModel.totalFare.toInt()}',
                    style:
                        AppTextStyles.reviewPrice,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.xl,
          ),

          const Divider(),

          const SizedBox(
            height: AppSpacing.xl,
          ),

          // =============================================
          // VEHICLE
          // =============================================

          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius:
                      BorderRadius.circular(
                    AppSpacing.radiusMedium,
                  ),
                ),
                child: const Icon(
                  Icons.local_shipping_outlined,
                  color:
                      AppColors.textPrimary,
                  size:
                      AppSpacing.iconMedium,
                ),
              ),

              const SizedBox(
                width: AppSpacing.lg,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      _viewModel.vehicleName,
                      style:
                          AppTextStyles.heading3,
                    ),

                    const SizedBox(
                      height: AppSpacing.xs,
                    ),

                    Text(
                      _viewModel.vehicleNumber,
                      style:
                          AppTextStyles.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.xxl,
          ),

          // =============================================
          // PICKUP
          // =============================================

          _buildLocationRow(
            title: 'PICKUP',
            address:
                _viewModel.pickupAddress,
            isPickup: true,
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 11,
            ),
            child: Container(
              width: 2,
              height: 30,
              color: AppColors.border,
            ),
          ),

          // =============================================
          // DROP
          // =============================================

          _buildLocationRow(
            title: 'DROP',
            address:
                _viewModel.dropAddress,
            isPickup: false,
          ),

          const SizedBox(
            height: AppSpacing.xxl,
          ),

          // =============================================
          // SUMMARY
          // =============================================

          _buildTripSummary(),
        ],
      ),
    );
  }

  // =========================================================
  // LOCATION ROW
  // =========================================================

  Widget _buildLocationRow({
    required String title,
    required String address,
    required bool isPickup,
  }) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
            border: Border.all(
              color: AppColors.primary,
              width:
                  AppSpacing.borderMedium,
            ),
          ),
          child: isPickup
              ? Container(
                  width: 9,
                  height: 9,
                  decoration:
                      const BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        AppColors.primary,
                  ),
                )
              : const Icon(
                  Icons.location_on_rounded,
                  size:
                      AppSpacing.iconSmall,
                  color:
                      AppColors.primary,
                ),
        ),

        const SizedBox(
          width: AppSpacing.lg,
        ),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                title,
                style:
                    AppTextStyles.labelLarge,
              ),

              const SizedBox(
                height: AppSpacing.sm,
              ),

              Text(
                address,
                style:
                    AppTextStyles.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =========================================================
  // TRIP SUMMARY
  // =========================================================

  Widget _buildTripSummary() {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(
          AppSpacing.radiusMedium,
        ),
      ),

      child: Row(
        children: [
          Expanded(
            child: _SummaryItem(
              icon:
                  Icons.route_outlined,
              value:
                  _viewModel.distance,
              label: 'Distance',
            ),
          ),

          Container(
            width: 1,
            height: 74,
            color: AppColors.border,
          ),

          Expanded(
            child: _SummaryItem(
              icon:
                  Icons.schedule_outlined,
              value:
                  _viewModel.duration,
              label: 'Duration',
            ),
          ),

          Container(
            width: 1,
            height: 74,
            color: AppColors.border,
          ),

          Expanded(
            child: _SummaryItem(
              icon:
                  Icons.account_balance_wallet_outlined,
              value:
                  _viewModel.paymentMethod,
              label: 'Payment',
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BOTTOM ACTIONS
  // =========================================================

  Widget _buildBottomActions() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.lg,
        AppSpacing.screenHorizontal,
        AppSpacing.xl,
      ),

      decoration: BoxDecoration(
        color: AppColors.background,

        border: const Border(
          top: BorderSide(
            color: AppColors.border,
          ),
        ),

        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(
              AppColors.opacityShadow,
            ),
            blurRadius: AppSpacing.shadowBlur,
            offset: const Offset(
              0,
              -4,
            ),
          ),
        ],
      ),

      child: SafeArea(
        top: false,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // =============================================
            // RATE
            // =============================================

            SizedBox(
              width: double.infinity,
              height:
                  AppSpacing.buttonHeight,

              child: ElevatedButton.icon(
                onPressed: () {
                  _viewModel.rateExperience(
                    context,
                  );
                },

                icon: const Icon(
                  Icons.star_rounded,
                  color: AppColors.white,
                  size:
                      AppSpacing.iconSmall,
                ),

                label: Text(
                  'Rate your experience',
                  style:
                      AppTextStyles.buttonText,
                ),
              ),
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            // =============================================
            // DETAILS
            // =============================================

            SizedBox(
              width: double.infinity,
              height:
                  AppSpacing.buttonHeight,

              child: OutlinedButton(
                onPressed: () {
                  _viewModel.viewTripDetails(
                    context,
                  );
                },

                style:
                    OutlinedButton.styleFrom(
                  foregroundColor:
                      AppColors.primary,

                  side: const BorderSide(
                    color:
                        AppColors.primary,
                    width:
                        AppSpacing.borderMedium,
                  ),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      AppSpacing.radiusButton,
                    ),
                  ),
                ),

                child: Text(
                  'View Trip Details',
                  style: AppTextStyles
                      .buttonTextDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// SUMMARY ITEM
// =====================================================================

class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _SummaryItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.lg,
        horizontal: AppSpacing.sm,
      ),

      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.textSecondary,
            size: AppSpacing.iconMedium,
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                AppTextStyles.labelLarge,
          ),

          const SizedBox(
            height: AppSpacing.xs,
          ),

          Text(
            label,
            textAlign: TextAlign.center,
            style:
                AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}