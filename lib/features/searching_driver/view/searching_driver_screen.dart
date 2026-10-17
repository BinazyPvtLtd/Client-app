import 'package:client_app/features/captain_on_the_way/view/captain_on_the_way_screen.dart';
import 'package:client_app/features/home/widgets/patgolito_map.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../viewmodel/searching_driver_viewmodel.dart';

class SearchingDriverScreen extends StatefulWidget {
  const SearchingDriverScreen({super.key});

  @override
  State<SearchingDriverScreen> createState() => _SearchingDriverScreenState();
}

class _SearchingDriverScreenState extends State<SearchingDriverScreen>
    with SingleTickerProviderStateMixin {
  late final SearchingDriverViewModel _viewModel;

  late final AnimationController _animationController;
  late final Animation<double> _pulseAnimation;

  List<BoxShadow> get _cardShadow => [
    BoxShadow(
      color: AppColors.black.withValues(alpha: 0.14),
      blurRadius: 20,
      spreadRadius: 0,
      offset: const Offset(0, 6),
    ),
  ];

  // =========================================================
  // INIT
  // =========================================================

  @override
  void initState() {
    super.initState();

    _viewModel = SearchingDriverViewModel();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _pulseAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );

    _animationController.repeat();
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
          builder: (context, _) {
            return Stack(
              children: [
                // =================================================
                // DUMMY MAP
                // =================================================
                const Positioned.fill(
                  child: PatgolitoMap(
                    latitude: 26.8467,
                    longitude: 80.9462,
                    zoom: 15.5,
                  ),
                ),

                // =================================================
                // CONTENT
                // =================================================
                Positioned.fill(
                  child: Column(
                    children: [
                      _buildTopBar(),

                      const SizedBox(height: AppSpacing.md),

                      _buildStatus(),

                      const SizedBox(height: AppSpacing.md),

                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.screenHorizontal,
                            AppSpacing.lg,
                            AppSpacing.screenHorizontal,
                            AppSpacing.xl,
                          ),
                          child: Column(
                            children: [
                              _buildSearchingCard(),

                              const SizedBox(height: AppSpacing.lg),

                              _buildBookingSummary(),
                            ],
                          ),
                        ),
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
              _viewModel.onInfoPressed(context);
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
        color: AppColors.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Status: ', style: AppTextStyles.bodySmall),

          Text('Active Search', style: AppTextStyles.labelLarge),
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

        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),

        border: Border.all(color: AppColors.border),

        boxShadow: _cardShadow,
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // =============================================
          // PULSING SEARCH CIRCLE
          // =============================================
          SizedBox(height: 105, child: Center(child: _buildSearchCircle())),

          const SizedBox(height: AppSpacing.lg),

          // =============================================
          // TITLE
          // =============================================
          Text(
            'Searching for drivers',
            textAlign: TextAlign.center,
            style: AppTextStyles.heading1,
          ),

          const SizedBox(height: AppSpacing.sm),

          // =============================================
          // SUBTITLE
          // =============================================
          Text(
            'Finding the best captain near you.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium,
          ),

          const SizedBox(height: AppSpacing.xl),

          // =============================================
          // LOADER
          // =============================================
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
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
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, _) {
          return CustomPaint(
            painter: _RadarPainter(progress: _pulseAnimation.value),
            child: Center(
              child: Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFDBEAFE),
                  border: Border.all(color: const Color(0xFF2563EB), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2563EB).withValues(alpha: 0.15),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: const Center(
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Color(0xFF2563EB),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // =========================================================
  // BOOKING SUMMARY
  // =========================================================

  Widget _buildBookingSummary() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(AppSpacing.md),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),

        border: Border.all(color: AppColors.border),

        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(AppColors.opacityShadow),
            blurRadius: AppSpacing.shadowBlur,
            offset: const Offset(0, 4),
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
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(width: 2, height: 20, color: AppColors.border),
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

          const SizedBox(height: AppSpacing.xs),

          const Divider(),

          const SizedBox(height: AppSpacing.xs),

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
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),

                child: const Icon(
                  Icons.two_wheeler_rounded,
                  color: AppColors.textPrimary,
                  size: AppSpacing.iconMedium,
                ),
              ),

              const SizedBox(width: AppSpacing.lg),

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

                  const SizedBox(height: AppSpacing.xs),

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

          const SizedBox(height: AppSpacing.xl),

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
                    builder: (_) => const CaptainOnTheWayScreen(),
                  ),
                );
              },

              child: Text(
                'Test: Driver Accept',
                style: AppTextStyles.buttonText,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // =============================================
          // CANCEL
          // =============================================
          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeight,

            child: OutlinedButton(
              onPressed: () {
                _viewModel.cancelRequest(context);
              },

              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,

                side: const BorderSide(color: AppColors.border),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
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
            border: Border.all(color: AppColors.border),
          ),

          child: Container(
            width: 8,
            height: 8,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isPickup ? AppColors.textSecondary : AppColors.primary,
            ),
          ),
        ),

        const SizedBox(width: AppSpacing.md),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.labelMedium),

              const SizedBox(height: AppSpacing.xs),

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

  const _CircleButton({required this.icon, required this.onTap});

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

class _RadarPainter extends CustomPainter {
  final double progress;

  const _RadarPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    const blue = Color(0xFF3B82F6);
    const maxRadius = 170.0;

    for (int i = 0; i < 3; i++) {
      final waveProgress = (progress + i / 3) % 1.0;

      final radius = 8 + (maxRadius * waveProgress);
      final opacity = (1 - waveProgress) * 0.32;

      final fillPaint = Paint()
        ..color = blue.withValues(alpha: opacity * 0.45)
        ..style = PaintingStyle.fill;

      final borderPaint = Paint()
        ..color = blue.withValues(alpha: opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawCircle(center, radius, fillPaint);
      canvas.drawCircle(center, radius, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _RadarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
