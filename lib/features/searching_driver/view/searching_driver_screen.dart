import 'package:client_app/features/captain_on_the_way/view/captain_on_the_way_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../viewmodel/searching_driver_viewmodel.dart';

class SearchingDriverScreen extends StatefulWidget {
  const SearchingDriverScreen({
    super.key,
  });

  @override
  State<SearchingDriverScreen> createState() =>
      _SearchingDriverScreenState();
}

class _SearchingDriverScreenState
    extends State<SearchingDriverScreen>
    with SingleTickerProviderStateMixin {
  late final SearchingDriverViewModel _viewModel;

  late final AnimationController _animationController;
  late final Animation<double> _pulseAnimation;

  // =========================================================
  // INIT
  // =========================================================

  @override
  void initState() {
    super.initState();

    _viewModel = SearchingDriverViewModel();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
    );

    _pulseAnimation = Tween<double>(
      begin: 0.88,
      end: 1.12,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.repeat(
      reverse: true,
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    _animationController.dispose();
    _viewModel.dispose();

    super.dispose();
  }

  // =========================================================
  // SCREEN
  // =========================================================

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
            return Stack(
              children: [
                // =================================================
                // DUMMY MAP
                // =================================================

                const Positioned.fill(
                  child: _SearchingMapBackground(),
                ),

                // =================================================
                // CONTENT
                // =================================================

                Positioned.fill(
                  child: Column(
                    children: [
                      _buildTopBar(),

                      const SizedBox(
                        height: AppSpacing.md,
                      ),

                      _buildStatus(),

                      const Spacer(),

                      // =============================================
                      // SEARCHING CARD
                      // =============================================

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.screenHorizontal,
                        ),
                        child: _buildSearchingCard(),
                      ),

                      const SizedBox(
                        height: AppSpacing.lg,
                      ),

                      // =============================================
                      // BOOKING SUMMARY
                      // =============================================

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.screenHorizontal,
                        ),
                        child: _buildBookingSummary(),
                      ),

                      const SizedBox(
                        height: AppSpacing.lg,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // =========================================================
  // TOP BAR
  // =========================================================

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.lg,
        AppSpacing.screenHorizontal,
        0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CircleButton(
            icon: Icons.arrow_back_rounded,
            onTap: () {
              Navigator.pop(context);
            },
          ),

          _CircleButton(
            icon: Icons.info_outline_rounded,
            onTap: () {
              _viewModel.onInfoPressed(
                context,
              );
            },
          ),
        ],
      ),
    );
  }

  // =========================================================
  // STATUS
  // =========================================================

  Widget _buildStatus() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(
          0.94,
        ),
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusCircular,
        ),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Status: ',
            style: AppTextStyles.bodySmall,
          ),

          Text(
            'Active Search',
            style: AppTextStyles.labelLarge,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // SEARCHING CARD
  // =========================================================

  Widget _buildSearchingCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xxl,
        AppSpacing.xl,
        AppSpacing.xxl,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          // =============================================
          // PULSING SEARCH CIRCLE
          // =============================================

          SizedBox(
            height: 105,
            child: Center(
              child: AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (
                  context,
                  child,
                ) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: child,
                  );
                },
                child: _buildSearchCircle(),
              ),
            ),
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          // =============================================
          // TITLE
          // =============================================

          Text(
            'Searching for drivers',
            textAlign: TextAlign.center,
            style: AppTextStyles.heading1,
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          // =============================================
          // SUBTITLE
          // =============================================

          Text(
            'Finding the best captain near you.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium,
          ),

          const SizedBox(
            height: AppSpacing.xl,
          ),

          // =============================================
          // LOADER
          // =============================================

          ClipRRect(
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusCircular,
            ),
            child: const LinearProgressIndicator(
              minHeight: 5,
              backgroundColor: AppColors.border,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // SEARCH CIRCLE
  // =========================================================

  Widget _buildSearchCircle() {
    return SizedBox(
      width: 92,
      height: 92,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // =============================================
          // OUTER SOFT CIRCLE
          // =============================================

          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withOpacity(
                AppColors.opacityExtraLight,
              ),
              border: Border.all(
                color: AppColors.primary.withOpacity(
                  AppColors.opacityLight,
                ),
              ),
            ),
          ),

          // =============================================
          // INNER CIRCLE
          // =============================================

          Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
              border: Border.all(
                color: AppColors.primary,
                width: AppSpacing.borderMedium,
              ),
            ),
          ),

          // =============================================
          // CENTER DOT
          // =============================================

          Container(
            width: 14,
            height: 14,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BOOKING SUMMARY
  // =========================================================

  Widget _buildBookingSummary() {
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
        children: [
          // =============================================
          // PICKUP
          // =============================================

          _buildLocationRow(
            label: 'Pickup',
            address: _viewModel.pickupAddress,
            isPickup: true,
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 2,
                height: 20,
                color: AppColors.border,
              ),
            ),
          ),

          // =============================================
          // DROP
          // =============================================

          _buildLocationRow(
            label: 'Drop',
            address: _viewModel.dropAddress,
            isPickup: false,
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          const Divider(),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          // =============================================
          // VEHICLE + FARE
          // =============================================

          Row(
            children: [
              Container(
                width: 52,
                height: 52,

                alignment: Alignment.center,

                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(
                    AppSpacing.radiusMedium,
                  ),
                ),

                child: const Icon(
                  Icons.two_wheeler_rounded,
                  color: AppColors.textPrimary,
                  size: AppSpacing.iconMedium,
                ),
              ),

              const SizedBox(
                width: AppSpacing.lg,
              ),

              Expanded(
                child: Text(
                  _viewModel.vehicleName,
                  style: AppTextStyles.heading3,
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${_viewModel.finalFare.toInt()}',
                    style: AppTextStyles.reviewPrice,
                  ),

                  const SizedBox(
                    height: AppSpacing.xs,
                  ),

                  Text(
                    '₹${_viewModel.originalFare.toInt()}',
                    style: AppTextStyles.bodySmall.copyWith(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.xl,
          ),

          // =============================================
          // TEST DRIVER ACCEPT
          // Remove this when backend is connected.
          // =============================================

          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeight,

            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const CaptainOnTheWayScreen(),
                  ),
                );
              },

              child: Text(
                'Test: Driver Accept',
                style: AppTextStyles.buttonText,
              ),
            ),
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          // =============================================
          // CANCEL
          // =============================================

          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeight,

            child: OutlinedButton(
              onPressed: () {
                _viewModel.cancelRequest(
                  context,
                );
              },

              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,

                side: const BorderSide(
                  color: AppColors.border,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppSpacing.radiusButton,
                  ),
                ),
              ),

              child: Text(
                'Cancel Request',
                style: AppTextStyles.reviewAction.copyWith(
                  color: AppColors.error,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // LOCATION ROW
  // =========================================================

  Widget _buildLocationRow({
    required String label,
    required String address,
    required bool isPickup,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,

          alignment: Alignment.center,

          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
            border: Border.all(
              color: AppColors.border,
            ),
          ),

          child: Container(
            width: 8,
            height: 8,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isPickup
                  ? AppColors.textSecondary
                  : AppColors.primary,
            ),
          ),
        ),

        const SizedBox(
          width: AppSpacing.md,
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.labelMedium,
              ),

              const SizedBox(
                height: AppSpacing.xs,
              ),

              Text(
                address,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// TOP CIRCLE BUTTON
// =====================================================================

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: 2,
      shape: const CircleBorder(),

      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),

        child: SizedBox(
          width: 54,
          height: 54,

          child: Icon(
            icon,
            color: AppColors.textPrimary,
            size: AppSpacing.iconMedium,
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// DUMMY SEARCH MAP
// =====================================================================

class _SearchingMapBackground extends StatelessWidget {
  const _SearchingMapBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(
        0xFFF0F0ED,
      ),

      child: Stack(
        children: [
          // =============================================
          // ROAD 1
          // =============================================

          Positioned(
            top: 140,
            left: -70,
            right: -70,
            child: Transform.rotate(
              angle: -0.12,
              child: Container(
                height: 14,
                color: AppColors.white.withOpacity(
                  0.55,
                ),
              ),
            ),
          ),

          // =============================================
          // ROAD 2
          // =============================================

          Positioned(
            top: 330,
            left: -80,
            right: -80,
            child: Transform.rotate(
              angle: 0.16,
              child: Container(
                height: 18,
                color: AppColors.white.withOpacity(
                  0.50,
                ),
              ),
            ),
          ),

          // =============================================
          // ROAD 3
          // =============================================

          Positioned(
            top: -100,
            bottom: -100,
            left: 110,
            child: Transform.rotate(
              angle: 0.12,
              child: Container(
                width: 15,
                color: AppColors.white.withOpacity(
                  0.45,
                ),
              ),
            ),
          ),

          // =============================================
          // ROAD 4
          // =============================================

          Positioned(
            top: -100,
            bottom: -100,
            right: 90,
            child: Transform.rotate(
              angle: -0.10,
              child: Container(
                width: 13,
                color: AppColors.white.withOpacity(
                  0.40,
                ),
              ),
            ),
          ),

          // =============================================
          // SEARCH RADIUS
          // =============================================

          Center(
            child: Container(
              width: 300,
              height: 300,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                color: AppColors.primary.withOpacity(
                  AppColors.opacityExtraLight,
                ),

                border: Border.all(
                  color: AppColors.primary.withOpacity(
                    AppColors.opacityLight,
                  ),
                ),
              ),
            ),
          ),

          // =============================================
          // VEHICLE MARKER
          // =============================================

          Center(
            child: Container(
              width: 54,
              height: 54,

              alignment: Alignment.center,

              decoration: BoxDecoration(
                color: AppColors.white,

                shape: BoxShape.circle,

                border: Border.all(
                  color: AppColors.border,
                ),

                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(
                      AppColors.opacityShadow,
                    ),
                    blurRadius: 10,
                  ),
                ],
              ),

              child: const Icon(
                Icons.two_wheeler_rounded,
                color: AppColors.textPrimary,
                size: AppSpacing.iconMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}