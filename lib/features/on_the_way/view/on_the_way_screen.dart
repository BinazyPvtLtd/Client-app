import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../viewmodel/on_the_way_viewmodel.dart';

class OnTheWayScreen extends StatefulWidget {
  const OnTheWayScreen({
    super.key,
  });

  @override
  State<OnTheWayScreen> createState() =>
      _OnTheWayScreenState();
}

class _OnTheWayScreenState
    extends State<OnTheWayScreen> {
  late final OnTheWayViewModel _viewModel;

  final DraggableScrollableController
      _sheetController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();

    _viewModel = OnTheWayViewModel();
  }

  @override
  void dispose() {
    _sheetController.dispose();
    _viewModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      appBar: AppBar(
        backgroundColor:
            AppColors.background,

        elevation: 0,

        scrolledUnderElevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back_rounded,
            size:
                AppSpacing.iconMedium,
          ),
        ),

        title: Text(
          'On the way',
          style:
              AppTextStyles.screenTitle,
        ),

        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () {
              _viewModel.openSupport(
                context,
              );
            },

            icon: const Icon(
              Icons.support_agent_rounded,
              size:
                  AppSpacing.iconMedium,
            ),
          ),

          const SizedBox(
            width: AppSpacing.sm,
          ),
        ],
      ),

      body: ListenableBuilder(
        listenable: _viewModel,

        builder: (
          context,
          _,
        ) {
          return Stack(
            children: [
              // =============================================
              // DUMMY MAP
              // =============================================

              Positioned.fill(
                child: GestureDetector(
                  behavior:
                      HitTestBehavior.opaque,

                  onTap: _openMap,

                  child:
                      const _OnTheWayDummyMap(),
                ),
              ),

              // =============================================
              // DESTINATION MARKER
              // =============================================

              const Positioned.fill(
                child: IgnorePointer(
                  child:
                      _DestinationMapMarker(),
                ),
              ),

              // =============================================
              // DRAGGABLE BOTTOM SHEET
              // =============================================

              DraggableScrollableSheet(
                controller:
                    _sheetController,

                initialChildSize: 0.66,

                minChildSize: 0.28,

                maxChildSize: 0.88,

                snap: true,

                snapSizes: const [
                  0.28,
                  0.66,
                  0.88,
                ],

                builder: (
                  context,
                  scrollController,
                ) {
                  return _buildTripSheet(
                    scrollController,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  // =========================================================
  // MAP TAP
  // =========================================================

  Future<void> _openMap() async {
    if (!_sheetController.isAttached) {
      return;
    }

    await _sheetController.animateTo(
      0.28,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeOut,
    );
  }

  // =========================================================
  // TRIP SHEET
  // =========================================================

  Widget _buildTripSheet(
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

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,

          children: [
            // =========================================
            // HANDLE
            // =========================================

            Center(
              child: Container(
                width: 54,
                height: 5,

                decoration:
                    BoxDecoration(
                  color:
                      AppColors.border,

                  borderRadius:
                      BorderRadius.circular(
                    AppSpacing
                        .radiusCircular,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: AppSpacing.xxl,
            ),

            // =========================================
            // DRIVER
            // =========================================

            _buildDriverHeader(),

            const SizedBox(
              height: AppSpacing.xl,
            ),

            const Divider(),

            const SizedBox(
              height: AppSpacing.xl,
            ),

            // =========================================
            // DESTINATION
            // =========================================

            _buildDestinationSection(),

            const SizedBox(
              height: AppSpacing.xl,
            ),

            const Divider(),

            const SizedBox(
              height: AppSpacing.xxl,
            ),

            // =========================================
            // TIMELINE
            // =========================================

            _buildTimeline(),

            const SizedBox(
              height: AppSpacing.xxl,
            ),

            const Divider(),

            const SizedBox(
              height: AppSpacing.xl,
            ),

            // =========================================
            // CALL + CHAT
            // =========================================

            _buildContactButtons(),

            // =========================================
            // TEST ONLY
            // =========================================

            const SizedBox(
              height: AppSpacing.md,
            ),

           SizedBox(
  width: double.infinity,
  height: AppSpacing.buttonHeight,
  child: ElevatedButton(
    onPressed: () {
      _viewModel.markDelivered(
        context,
      );
    },
    child: Text(
      'Test: Complete Trip',
      style: AppTextStyles.buttonText,
    ),
  ),
),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // DRIVER HEADER
  // =========================================================

  Widget _buildDriverHeader() {
    return Row(
      children: [
        // =============================================
        // AVATAR
        // =============================================

        Container(
          width: 64,
          height: 64,

          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surface,

            border: Border.all(
              color: AppColors.border,
            ),
          ),

          child: const Icon(
            Icons.person_rounded,
            color:
                AppColors.textSecondary,
            size: AppSpacing.iconLarge,
          ),
        ),

        const SizedBox(
          width: AppSpacing.lg,
        ),

        // =============================================
        // DETAILS
        // =============================================

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      _viewModel.driverName,

                      maxLines: 1,

                      overflow:
                          TextOverflow.ellipsis,

                      style:
                          AppTextStyles.heading2,
                    ),
                  ),

                  const SizedBox(
                    width: AppSpacing.sm,
                  ),

                  _buildRatingBadge(),
                ],
              ),

              const SizedBox(
                height: AppSpacing.sm,
              ),

              Text(
                '${_viewModel.vehicleName} • '
                '${_viewModel.vehicleNumber}',

                maxLines: 2,

                overflow:
                    TextOverflow.ellipsis,

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
  // RATING
  // =========================================================

  Widget _buildRatingBadge() {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusSmall,
        ),
      ),

      child: Row(
        mainAxisSize:
            MainAxisSize.min,

        children: [
          const Icon(
            Icons.star_outline_rounded,
            size:
                AppSpacing.iconSmall,
          ),

          const SizedBox(
            width: AppSpacing.xs,
          ),

          Text(
            _viewModel.driverRating,
            style:
                AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // DESTINATION
  // =========================================================

  Widget _buildDestinationSection() {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        const Icon(
          Icons.location_on_outlined,
          size:
              AppSpacing.iconMedium,
          color: AppColors.textPrimary,
        ),

        const SizedBox(
          width: AppSpacing.md,
        ),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                'DESTINATION',
                style:
                    AppTextStyles.labelLarge,
              ),

              const SizedBox(
                height: AppSpacing.sm,
              ),

              Text(
                _viewModel.destination,
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
  // TIMELINE
  // =========================================================

  Widget _buildTimeline() {
    return Column(
      children: [
        _TimelineItem(
          title:
              'Booking confirmed',

          subtitle:
              _viewModel.bookingConfirmedTime,

          state:
              _TimelineState.completed,
        ),

        _TimelineItem(
          title:
              'Pickup completed',

          subtitle:
              _viewModel.pickupCompletedTime,

          state:
              _TimelineState.completed,
        ),

        _TimelineItem(
          title:
              'On the way',

          subtitle:
              _viewModel.arrivalText,

          state:
              _viewModel.currentStatus ==
                      DeliveryTripStatus.delivered
                  ? _TimelineState.completed
                  : _TimelineState.current,
        ),

        _TimelineItem(
          title: 'Delivered',

          state:
              _viewModel.currentStatus ==
                      DeliveryTripStatus.delivered
                  ? _TimelineState.completed
                  : _TimelineState.pending,

          showConnector: false,
        ),
      ],
    );
  }

  // =========================================================
  // CONTACT BUTTONS
  // =========================================================

  Widget _buildContactButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height:
                AppSpacing.buttonHeight,

            child: OutlinedButton.icon(
              onPressed:
                  _viewModel.callDriver,

              icon: const Icon(
                Icons.call_outlined,
                size:
                    AppSpacing.iconSmall,
              ),

              label: Text(
                'Call',
                style: AppTextStyles
                    .buttonTextDark,
              ),

              style:
                  OutlinedButton.styleFrom(
                foregroundColor:
                    AppColors.primary,

                side: const BorderSide(
                  color:
                      AppColors.primary,
                  width: AppSpacing
                      .borderThin,
                ),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    AppSpacing
                        .radiusButton,
                  ),
                ),
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

              style:
                  OutlinedButton.styleFrom(
                foregroundColor:
                    AppColors.primary,

                side: const BorderSide(
                  color:
                      AppColors.primary,
                  width: AppSpacing
                      .borderThin,
                ),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    AppSpacing
                        .radiusButton,
                  ),
                ),
              ),
            ),
          ),
        ),
        
      ],
    );
  }
}

// =====================================================================
// TIMELINE STATE
// =====================================================================

enum _TimelineState {
  completed,
  current,
  pending,
}

// =====================================================================
// TIMELINE ITEM
// =====================================================================

class _TimelineItem
    extends StatelessWidget {
  final String title;

  final String? subtitle;

  final _TimelineState state;

  final bool showConnector;

  const _TimelineItem({
    required this.title,
    this.subtitle,
    required this.state,
    this.showConnector = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool completed =
        state ==
            _TimelineState.completed;

    final bool current =
        state ==
            _TimelineState.current;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          SizedBox(
            width: 44,

            child: Column(
              children: [
                _buildIndicator(
                  completed,
                  current,
                ),

                if (showConnector)
                  Expanded(
                    child: Container(
                      width: 2,

                      color:
                          AppColors.border,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(
            width: AppSpacing.md,
          ),

          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(
                bottom:
                    AppSpacing.xxl,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  Text(
                    title,

                    style: current
                        ? AppTextStyles
                            .heading2
                        : completed
                            ? AppTextStyles
                                .bodyLarge
                            : AppTextStyles
                                .bodyLarge
                                .copyWith(
                                color:
                                    AppColors
                                        .textTertiary,
                              ),
                  ),

                  if (subtitle !=
                      null) ...[
                    const SizedBox(
                      height:
                          AppSpacing.xs,
                    ),

                    Text(
                      subtitle!,

                      style: current
                          ? AppTextStyles
                              .bodyMedium
                              .copyWith(
                              color:
                                  AppColors
                                      .primary,
                            )
                          : AppTextStyles
                              .bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(
    bool completed,
    bool current,
  ) {
    if (completed) {
      return Container(
        width: 30,
        height: 30,

        decoration:
            const BoxDecoration(
          shape: BoxShape.circle,
          color:
              AppColors.primary,
        ),

        child: const Icon(
          Icons.check_rounded,
          color: AppColors.white,
          size:
              AppSpacing.iconSmall,
        ),
      );
    }

    if (current) {
      return Container(
        width: 34,
        height: 34,

        alignment:
            Alignment.center,

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          color: AppColors.white,

          border: Border.all(
            color: AppColors.primary,
            width:
                AppSpacing.borderMedium,
          ),
        ),

        child: Container(
          width: 14,
          height: 14,

          decoration:
              const BoxDecoration(
            shape: BoxShape.circle,
            color:
                AppColors.primary,
          ),
        ),
      );
    }

    return Container(
      width: 30,
      height: 30,

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        color: AppColors.white,

        border: Border.all(
          color: AppColors.border,
          width:
              AppSpacing.borderMedium,
        ),
      ),
    );
  }
}

// =====================================================================
// DUMMY MAP
// =====================================================================

class _OnTheWayDummyMap
    extends StatelessWidget {
  const _OnTheWayDummyMap();

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          const Color(0xFFF2F2EF),

      child: Stack(
        children: [
          Positioned(
            top: 100,
            left: -50,
            right: -50,

            child:
                Transform.rotate(
              angle: -0.10,

              child: Container(
                height: 14,

                color:
                    AppColors.white
                        .withOpacity(
                  0.55,
                ),
              ),
            ),
          ),

          Positioned(
            top: 310,
            left: -70,
            right: -70,

            child:
                Transform.rotate(
              angle: 0.12,

              child: Container(
                height: 18,

                color:
                    AppColors.white
                        .withOpacity(
                  0.50,
                ),
              ),
            ),
          ),

          Positioned(
            top: -100,
            bottom: -100,
            left: 120,

            child:
                Transform.rotate(
              angle: 0.08,

              child: Container(
                width: 14,

                color:
                    AppColors.white
                        .withOpacity(
                  0.45,
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
// DESTINATION ON MAP
// =====================================================================

class _DestinationMapMarker
    extends StatelessWidget {
  const _DestinationMapMarker();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          const Alignment(
        0.40,
        -0.48,
      ),

      child: Column(
        mainAxisSize:
            MainAxisSize.min,

        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal:
                  AppSpacing.lg,
              vertical:
                  AppSpacing.sm,
            ),

            decoration:
                BoxDecoration(
              color:
                  AppColors.white,

              borderRadius:
                  BorderRadius.circular(
                AppSpacing
                    .radiusCircular,
              ),

              boxShadow: [
                BoxShadow(
                  color:
                      AppColors.black
                          .withOpacity(
                    AppColors
                        .opacityShadow,
                  ),
                  blurRadius: 10,
                ),
              ],
            ),

            child: Row(
              mainAxisSize:
                  MainAxisSize.min,

              children: [
                const Icon(
                  Icons.flag_outlined,
                  size: AppSpacing
                      .iconSmall,
                ),

                const SizedBox(
                  width:
                      AppSpacing.sm,
                ),

                Text(
                  'Destination',
                  style: AppTextStyles
                      .labelLarge,
                ),
              ],
            ),
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          Container(
            width: 50,
            height: 50,

            alignment:
                Alignment.center,

            decoration:
                BoxDecoration(
              color:
                  AppColors.white,

              shape:
                  BoxShape.circle,

              border: Border.all(
                color:
                    AppColors.border,
              ),
            ),

            child: const Icon(
              Icons
                  .location_on_outlined,
              size:
                  AppSpacing.iconLarge,
              color:
                  AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}