import 'package:client_app/features/captain_on_the_way/%20viewmodel/captain_on_the_way_viewmodel.dart';
import 'package:client_app/features/on_the_way/view/on_the_way_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';


class CaptainOnTheWayScreen extends StatefulWidget {
  const CaptainOnTheWayScreen({
    super.key,
  });

  @override
  State<CaptainOnTheWayScreen> createState() =>
      _CaptainOnTheWayScreenState();
}

class _CaptainOnTheWayScreenState
    extends State<CaptainOnTheWayScreen> {
  late final CaptainOnTheWayViewModel _viewModel;

  final DraggableScrollableController
      _sheetController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();

    _viewModel =
        CaptainOnTheWayViewModel();
  }

  @override
  void dispose() {
    _sheetController.dispose();
    _viewModel.dispose();

    super.dispose();
  }

  // ==========================================================
  // SCREEN
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,

          builder: (
            context,
            _,
          ) {
            return Stack(
              children: [
                // =============================================
                // MAP
                // =============================================

                Positioned.fill(
                  child: GestureDetector(
                    behavior:
                        HitTestBehavior.opaque,

                    onTap: _openMap,

                    child: _CaptainMap(
                      arrived:
                          _viewModel
                              .hasCaptainArrived,
                    ),
                  ),
                ),

                // =============================================
                // TOP BAR
                // =============================================

                Positioned(
                  top: AppSpacing.lg,
                  left:
                      AppSpacing
                          .screenHorizontal,
                  right:
                      AppSpacing
                          .screenHorizontal,

                  child: _buildTopBar(),
                ),

                // =============================================
                // DRAGGABLE SHEET
                // =============================================

                DraggableScrollableSheet(
                  controller:
                      _sheetController,

                  initialChildSize:
                      _viewModel
                              .hasCaptainArrived
                          ? 0.58
                          : 0.60,

                  minChildSize: 0.22,

                  maxChildSize:
                      _viewModel
                              .hasCaptainArrived
                          ? 0.88
                          : 0.75,

                  snap: true,

                  snapSizes:
                      _viewModel
                              .hasCaptainArrived
                          ? const [
                              0.22,
                              0.58,
                              0.88,
                            ]
                          : const [
                              0.22,
                              0.60,
                              0.75,
                            ],

                  builder: (
                    context,
                    scrollController,
                  ) {
                    return _buildCaptainSheet(
                      scrollController,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ==========================================================
  // MAP TAP
  // ==========================================================

  Future<void> _openMap() async {
    if (!_sheetController.isAttached) {
      return;
    }

    await _sheetController.animateTo(
      0.22,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeOut,
    );
  }

  // ==========================================================
  // TOP BAR
  // ==========================================================

  Widget _buildTopBar() {
    return Row(
      children: [
        // BACK

        _CircleButton(
          icon:
              Icons.arrow_back_rounded,

          onTap: () {
            Navigator.pop(context);
          },
        ),

        const SizedBox(
          width: AppSpacing.lg,
        ),

        // STATUS

        Expanded(
          child: Container(
            height: 54,

            alignment: Alignment.center,

            decoration: BoxDecoration(
              color: AppColors.white,

              borderRadius:
                  BorderRadius.circular(
                AppSpacing
                    .radiusCircular,
              ),

              border: Border.all(
                color: AppColors.border,
              ),

              boxShadow: [
                BoxShadow(
                  color: AppColors.black
                      .withOpacity(
                    AppColors
                        .opacityShadow,
                  ),
                  blurRadius: 10,
                ),
              ],
            ),

            child: AnimatedSwitcher(
              duration: const Duration(
                milliseconds: 250,
              ),

              child: Text(
                _viewModel
                        .hasCaptainArrived
                    ? 'Captain Arrived'
                    : 'Arriving Now',

                key: ValueKey(
                  _viewModel
                      .hasCaptainArrived,
                ),

                style:
                    AppTextStyles.heading2,
              ),
            ),
          ),
        ),

        const SizedBox(
          width: AppSpacing.lg,
        ),

        // INFO

        _CircleButton(
          icon:
              Icons.help_outline_rounded,

          onTap: () {
            _viewModel.openInfo(
              context,
            );
          },
        ),
      ],
    );
  }

  // ==========================================================
  // CAPTAIN SHEET
  // ==========================================================

  Widget _buildCaptainSheet(
    ScrollController scrollController,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,

        borderRadius:
            const BorderRadius.vertical(
          top: Radius.circular(
            AppSpacing
                .radiusExtraLarge,
          ),
        ),

        border: const Border(
          top: BorderSide(
            color: AppColors.border,
          ),
        ),

        boxShadow: [
          BoxShadow(
            color: AppColors.black
                .withOpacity(
              AppColors.opacityShadow,
            ),
            blurRadius:
                AppSpacing.shadowBlur,
            offset:
                const Offset(0, -4),
          ),
        ],
      ),

      child: SingleChildScrollView(
        controller: scrollController,

        physics:
            const ClampingScrollPhysics(),

        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.md,
          AppSpacing.screenHorizontal,
          AppSpacing.xxl,
        ),

        child: AnimatedSwitcher(
          duration: const Duration(
            milliseconds: 300,
          ),

          child:
              _viewModel.hasCaptainArrived
                  ? _buildArrivedContent()
                  : _buildOnTheWayContent(),
        ),
      ),
    );
  }

  // ==========================================================
  // ON THE WAY CONTENT
  // ==========================================================

  Widget _buildOnTheWayContent() {
    return Column(
      key: const ValueKey(
        'on_the_way',
      ),

      crossAxisAlignment:
          CrossAxisAlignment.stretch,

      children: [
        _buildHandle(),

        const SizedBox(
          height: AppSpacing.xxl,
        ),

        Text(
          'Captain is on the way',
          textAlign: TextAlign.center,
          style: AppTextStyles.heading1,
        ),

        const SizedBox(
          height: AppSpacing.sm,
        ),

        Row(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Container(
              width: 8,
              height: 8,

              decoration:
                  const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(
              width: AppSpacing.sm,
            ),

            Text(
              _viewModel.arrivalText,

              style: AppTextStyles
                  .heading3
                  .copyWith(
                color:
                    AppColors.primary,
              ),
            ),
          ],
        ),

        const SizedBox(
          height: AppSpacing.xxl,
        ),

        _buildDriverCard(),

        const SizedBox(
          height: AppSpacing.xxl,
        ),

        _buildContactButtons(),

        const SizedBox(
          height: AppSpacing.xl,
        ),

        // ============================================
        // TEST BUTTON
        //
        // REMOVE AFTER BACKEND/SOCKET INTEGRATION
        // ============================================

        SizedBox(
          height: AppSpacing.buttonHeight,

          child: ElevatedButton(
            onPressed: () {
              _viewModel
                  .setDriverArrived();

              _moveSheetAfterArrival();
            },

            child: Text(
              'Test: Captain Arrived',
              style:
                  AppTextStyles.buttonText,
            ),
          ),
        ),

        const SizedBox(
          height: AppSpacing.md,
        ),

        Center(
          child: TextButton(
            onPressed: () {
              _viewModel.cancelRide(
                context,
              );
            },

            child: Text(
              'Cancel Ride',

              style: AppTextStyles
                  .reviewAction
                  .copyWith(
                color: AppColors.error,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // ARRIVED CONTENT
  // ==========================================================

  Widget _buildArrivedContent() {
    return Column(
      key: const ValueKey(
        'arrived',
      ),

      crossAxisAlignment:
          CrossAxisAlignment.stretch,

      children: [
        _buildHandle(),

        const SizedBox(
          height: AppSpacing.xxl,
        ),

        // ============================================
        // ARRIVED
        // ============================================

        Row(
          children: [
            Container(
              width: 12,
              height: 12,

              decoration:
                  const BoxDecoration(
                shape: BoxShape.circle,
                color:
                    Color(0xFF20BF6B),
              ),
            ),

            const SizedBox(
              width: AppSpacing.md,
            ),

            Expanded(
              child: Text(
                'Captain has arrived',

                style:
                    AppTextStyles.heading1,
              ),
            ),
          ],
        ),

        const SizedBox(
          height: AppSpacing.xxl,
        ),

        // ============================================
        // DRIVER
        // ============================================

        _buildDriverCard(
          showActions: true,
        ),

        const SizedBox(
          height: AppSpacing.xxxl,
        ),

        // ============================================
        // OTP INSTRUCTION
        // ============================================

        Text(
          'Share the pickup OTP with your captain.',

          textAlign: TextAlign.center,

          style:
              AppTextStyles.bodyLarge,
        ),

        const SizedBox(
          height: AppSpacing.xl,
        ),

        // ============================================
        // OTP
        // ============================================

        _buildLargeOtpCard(),

        const SizedBox(
          height: AppSpacing.xxl,
        ),

        // ============================================
        // SECURITY
        // ============================================

        _buildSecurityCard(),

        const SizedBox(
          height: AppSpacing.xxl,
        ),
        SizedBox(
  width: double.infinity,
  height: AppSpacing.buttonHeight,
  child: ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>  OnTheWayScreen(),
        ),
      );
    },
    child: Text(
      'Test: Start Ride',
      style: AppTextStyles.buttonText,
    ),
  ),
),
      ],
    );
  }

  // ==========================================================
  // MOVE SHEET AFTER ARRIVAL
  // ==========================================================

  Future<void>
      _moveSheetAfterArrival() async {
    await Future.delayed(
      const Duration(
        milliseconds: 100,
      ),
    );

    if (!_sheetController.isAttached) {
      return;
    }

    await _sheetController.animateTo(
      0.58,
      duration: const Duration(
        milliseconds: 350,
      ),
      curve: Curves.easeOut,
    );
  }

  // ==========================================================
  // HANDLE
  // ==========================================================

  Widget _buildHandle() {
    return Center(
      child: Container(
        width: 54,
        height: 5,

        decoration: BoxDecoration(
          color: AppColors.border,

          borderRadius:
              BorderRadius.circular(
            AppSpacing
                .radiusCircular,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // DRIVER CARD
  // ==========================================================

  Widget _buildDriverCard({
    bool showActions = false,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusCard,
        ),

        border: Border.all(
          color: AppColors.border,
        ),

        boxShadow: [
          BoxShadow(
            color: AppColors.black
                .withOpacity(
              0.04,
            ),
            blurRadius: 8,
            offset:
                const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [
          // DRIVER PHOTO

          Container(
            width: 62,
            height: 62,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              color: AppColors.surface,

              border: Border.all(
                color: AppColors.border,
              ),
            ),

            child: const Icon(
              Icons.person_rounded,
              size:
                  AppSpacing.iconLarge,
              color:
                  AppColors.textSecondary,
            ),
          ),

          const SizedBox(
            width: AppSpacing.lg,
          ),

          // DRIVER DETAILS

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  _viewModel.driverName,

                  style:
                      AppTextStyles.heading2,
                ),

                const SizedBox(
                  height: AppSpacing.xs,
                ),

                Text(
                  '${_viewModel.vehicleName} • ${_viewModel.vehicleNumber}',

                  maxLines: 2,

                  overflow:
                      TextOverflow.ellipsis,

                  style:
                      AppTextStyles.bodyLarge,
                ),

                const SizedBox(
                  height: AppSpacing.xs,
                ),

                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size:
                          AppSpacing.iconSmall,
                    ),

                    const SizedBox(
                      width: AppSpacing.xs,
                    ),

                    Text(
                      _viewModel
                          .driverRating,

                      style: AppTextStyles
                          .bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),

          if (showActions) ...[
            const SizedBox(
              width: AppSpacing.sm,
            ),

            _SmallActionButton(
              icon: Icons
                  .chat_bubble_outline_rounded,

              filled: false,

              onTap: () {
                _viewModel.openChat(
                  context,
                );
              },
            ),

            const SizedBox(
              width: AppSpacing.sm,
            ),

            _SmallActionButton(
              icon:
                  Icons.call_outlined,

              filled: true,

              onTap:
                  _viewModel.callDriver,
            ),
          ],
        ],
      ),
    );
  }

  // ==========================================================
  // CONTACT BUTTONS
  // ==========================================================

  Widget _buildContactButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height:
                AppSpacing.buttonHeight,

            child: ElevatedButton.icon(
              onPressed:
                  _viewModel.callDriver,

              icon: const Icon(
                Icons.call_outlined,
                color: AppColors.white,
                size:
                    AppSpacing.iconSmall,
              ),

              label: Text(
                'Call',
                style:
                    AppTextStyles.buttonText,
              ),
            ),
          ),
        ),

        const SizedBox(
          width: AppSpacing.lg,
        ),

        Expanded(
          child: SizedBox(
            height:
                AppSpacing.buttonHeight,

            child: OutlinedButton.icon(
              onPressed: () {
                _viewModel.openChat(
                  context,
                );
              },

              icon: const Icon(
                Icons
                    .chat_bubble_outline_rounded,
                size:
                    AppSpacing.iconSmall,
              ),

              label: Text(
                'Chat',

                style: AppTextStyles
                    .buttonTextDark,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // LARGE OTP
  // ==========================================================

  Widget _buildLargeOtpCard() {
    final otp = _viewModel.rideOtp;

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.xxxl,
      ),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusCard,
        ),

        border: Border.all(
          color: AppColors.primary,
          width:
              AppSpacing.borderMedium,
        ),
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: List.generate(
          otp.length,

          (index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal:
                    AppSpacing.md,
              ),

              child: Text(
                otp[index],

                style:
                    AppTextStyles.otpDigit,
              ),
            );
          },
        ),
      ),
    );
  }

  // ==========================================================
  // SECURITY CARD
  // ==========================================================

  Widget _buildSecurityCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusCard,
        ),

        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          const Icon(
            Icons
                .security_outlined,
            color:
                AppColors.textSecondary,
            size:
                AppSpacing.iconMedium,
          ),

          const SizedBox(
            width: AppSpacing.lg,
          ),

          Expanded(
            child: Text(
              'Only share the OTP when the correct captain '
              'and vehicle are present. Do not share over phone.',

              style:
                  AppTextStyles.bodyMedium
                      .copyWith(
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CIRCLE BUTTON
// ============================================================

class _CircleButton
    extends StatelessWidget {
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

        customBorder:
            const CircleBorder(),

        child: SizedBox(
          width: 54,
          height: 54,

          child: Icon(
            icon,
            color:
                AppColors.textPrimary,
            size:
                AppSpacing.iconMedium,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SMALL ACTION BUTTON
// ============================================================

class _SmallActionButton
    extends StatelessWidget {
  final IconData icon;

  final bool filled;

  final VoidCallback onTap;

  const _SmallActionButton({
    required this.icon,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled
          ? AppColors.primary
          : AppColors.surface,

      shape: const CircleBorder(),

      child: InkWell(
        onTap: onTap,

        customBorder:
            const CircleBorder(),

        child: SizedBox(
          width: 46,
          height: 46,

          child: Icon(
            icon,

            color: filled
                ? AppColors.white
                : AppColors
                    .textPrimary,

            size:
                AppSpacing.iconSmall,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// DUMMY MAP
// ============================================================

class _CaptainMap
    extends StatelessWidget {
  final bool arrived;

  const _CaptainMap({
    required this.arrived,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 400,
      ),

      color:
          const Color(0xFFF2F1ED),

      child: Stack(
        children: [
          // ============================================
          // DUMMY ROADS
          // ============================================

          Positioned(
            top: 180,
            left: -80,
            right: -80,

            child: Transform.rotate(
              angle: -0.10,

              child: Container(
                height: 14,

                color:
                    AppColors.white
                        .withOpacity(
                  0.60,
                ),
              ),
            ),
          ),

          Positioned(
            top: 380,
            left: -80,
            right: -80,

            child: Transform.rotate(
              angle: 0.13,

              child: Container(
                height: 16,

                color:
                    AppColors.white
                        .withOpacity(
                  0.50,
                ),
              ),
            ),
          ),

          // ============================================
          // MAP MARKER
          // ============================================

          Align(
            alignment:
                const Alignment(
              0,
              0.05,
            ),

            child: AnimatedSwitcher(
              duration:
                  const Duration(
                milliseconds: 350,
              ),

              child: arrived
                  ? const _PickupMarker()
                  : const _DriverMarker(),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// DRIVER MARKER
// ============================================================

class _DriverMarker
    extends StatelessWidget {
  const _DriverMarker();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey(
        'driver',
      ),

      width: 58,
      height: 58,

      alignment: Alignment.center,

      decoration: BoxDecoration(
        color: AppColors.white,

        shape: BoxShape.circle,

        border: Border.all(
          color: AppColors.border,
        ),

        boxShadow: [
          BoxShadow(
            color: AppColors.black
                .withOpacity(
              0.08,
            ),
            blurRadius: 12,
          ),
        ],
      ),

      child: const Icon(
        Icons.two_wheeler_rounded,
        color: AppColors.primary,
        size: AppSpacing.iconMedium,
      ),
    );
  }
}

// ============================================================
// PICKUP MARKER
// ============================================================

class _PickupMarker
    extends StatelessWidget {
  const _PickupMarker();

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey(
        'pickup',
      ),

      mainAxisSize: MainAxisSize.min,

      children: [
        Container(
          width: 62,
          height: 62,

          alignment: Alignment.center,

          decoration: BoxDecoration(
            color: AppColors.white,

            shape: BoxShape.circle,

            border: Border.all(
              color: AppColors.primary,
              width:
                  AppSpacing.borderMedium,
            ),
          ),

          child: const Icon(
            Icons.location_on_outlined,
            color: AppColors.primary,
            size: AppSpacing.iconLarge,
          ),
        ),

        const SizedBox(
          height: AppSpacing.sm,
        ),

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal:
                AppSpacing.xl,
            vertical:
                AppSpacing.md,
          ),

          decoration: BoxDecoration(
            color: AppColors.white,

            borderRadius:
                BorderRadius.circular(
              AppSpacing
                  .radiusCircular,
            ),

            boxShadow: [
              BoxShadow(
                color: AppColors.black
                    .withOpacity(
                  0.08,
                ),
                blurRadius: 10,
              ),
            ],
          ),

          child: Text(
            'Pickup Location',

            style:
                AppTextStyles.labelLarge,
          ),
        ),
      ],
    );
  }
}