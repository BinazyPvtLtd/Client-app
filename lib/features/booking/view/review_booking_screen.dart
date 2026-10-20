import 'package:client_app/core/theme/app_colors.dart';
import 'package:client_app/core/theme/app_spacing.dart';
import 'package:client_app/core/theme/app_text_styles.dart';
import 'package:client_app/core/theme/app_typography.dart';
import 'package:client_app/features/booking/models/booking_details_model.dart';
import 'package:client_app/features/booking/view/widgets/payment_method_sheet.dart';
import 'package:client_app/features/booking/viewmodel/review_booking_viewmodel.dart';

import 'package:flutter/material.dart';

import 'widgets/fare_breakup_bottom_sheet.dart';

class ReviewBookingScreen extends StatefulWidget {
  final BookingDetailsModel bookingDetails;

  const ReviewBookingScreen({super.key, required this.bookingDetails});

  @override
  State<ReviewBookingScreen> createState() => _ReviewBookingScreenState();
}

List<BoxShadow> get _cardShadow => [
  BoxShadow(
    color: AppColors.black.withValues(alpha: 0.12),
    blurRadius: 16,
    spreadRadius: 0,
    offset: const Offset(0, 5),
  ),
];

class _ReviewBookingScreenState extends State<ReviewBookingScreen> {
  late final ReviewBookingViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = ReviewBookingViewModel(bookingDetails: widget.bookingDetails);
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

        toolbarHeight: 56,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: AppColors.border),
        ),

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back_rounded,
            size: AppSpacing.iconLarge,
          ),
        ),

        title: Text('Review Booking', style: AppTextStyles.reviewTitle),
      ),

      body: ListenableBuilder(
        listenable: _viewModel,

        builder: (context, _) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),

                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenHorizontal,
                    AppSpacing.sm,
                    AppSpacing.screenHorizontal,
                    AppSpacing.xxxl,
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      _buildTripDetailsCard(),

                      const SizedBox(height: AppSpacing.md),

                      _buildLoadingInfoCard(),

                      const SizedBox(height: AppSpacing.md),

                      _buildGstinCard(),

                      const SizedBox(height: AppSpacing.md),

                      if (_viewModel.couponApplied) ...[
                        _buildCouponCard(),

                        const SizedBox(height: AppSpacing.md),
                      ],

                      _buildGoodsDetailsCard(),

                      const SizedBox(height: AppSpacing.md),

                      _buildRestrictedItemsCard(),
                    ],
                  ),
                ),
              ),

              _buildBottomBookingBar(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTripDetailsCard() {
    final booking = widget.bookingDetails;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(color: AppColors.border),
        boxShadow: _cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trip Details', style: AppTextStyles.reviewSectionTitle),

          const SizedBox(height: AppSpacing.xl),

          _buildTripDetailRow(
            icon: Icons.trip_origin_rounded,
            label: 'Pickup',
            value: booking.pickupAddress,
          ),

          const SizedBox(height: AppSpacing.lg),

          _buildTripDetailRow(
            icon: Icons.location_on_outlined,
            label: 'Drop',
            value: booking.dropAddress,
            subtitle: booking.dropAddressSubtitle,
          ),

          const Divider(height: AppSpacing.xxxl),

          _buildTripDetailRow(
            icon: Icons.local_shipping_outlined,
            label: 'Vehicle',
            value: booking.vehicleName,
          ),

          const SizedBox(height: AppSpacing.lg),

          _buildTripDetailRow(
            icon: Icons.person_outline_rounded,
            label: 'Receiver',
            value: booking.receiverName,
            subtitle: booking.receiverPhone,
          ),

          if (booking.houseNumber.trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            _buildTripDetailRow(
              icon: Icons.home_outlined,
              label: 'House / Building',
              value: booking.houseNumber,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTripDetailRow({
    required IconData icon,
    required String label,
    required String value,
    String? subtitle,
  }) {
    final displayValue = value.trim().isEmpty ? 'Not provided' : value.trim();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: AppSpacing.iconMedium, color: AppColors.textPrimary),

        const SizedBox(width: AppSpacing.md),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.reviewLabel),

              const SizedBox(height: AppSpacing.xs),

              Text(displayValue, style: AppTextStyles.reviewValue),

              if (subtitle != null && subtitle.trim().isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(subtitle.trim(), style: AppTextStyles.reviewSecondary),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // =========================================================
  // LOADING INFO
  // =========================================================

  Widget _buildLoadingInfoCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(AppSpacing.md),

      decoration: BoxDecoration(
        color: AppColors.border.withOpacity(AppColors.opacityExtraLight),

        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        boxShadow: _cardShadow,
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: AppColors.primary,
            size: AppSpacing.iconMedium,
          ),

          const SizedBox(width: AppSpacing.lg),

          Expanded(
            child: Text(
              'Loading and unloading terms will be confirmed before booking.',
              style: AppTextStyles.reviewBody,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // GSTIN
  // =========================================================

  Widget _buildGstinCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),

        border: Border.all(color: AppColors.border),
        boxShadow: _cardShadow,
      ),

      child: Row(
        children: [
          const Icon(
            Icons.receipt_long_outlined,
            color: AppColors.textSecondary,
            size: AppSpacing.iconLarge,
          ),

          const SizedBox(width: AppSpacing.lg),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  _viewModel.hasGstin ? 'GST Number' : 'Have a GST Number?',
                  style: AppTextStyles.reviewAction,
                ),

                if (_viewModel.hasGstin)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.xs),

                    child: Text(
                      _viewModel.gstin!,
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
              ],
            ),
          ),

          OutlinedButton(
            onPressed: _showGstinSheet,

            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,

              side: const BorderSide(color: AppColors.primary),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
              ),
            ),

            child: Text(
              _viewModel.hasGstin ? 'Change' : 'Add GSTIN',

              style: AppTextStyles.reviewAction,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // COUPON
  // =========================================================

  Widget _buildCouponCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),

      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(AppColors.opacityExtraLight),

        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),

        border: Border.all(
          color: AppColors.primaryLight.withOpacity(
            AppColors.opacityLightStrong,
          ),
        ),
      ),

      child: Row(
        children: [
          const Icon(Icons.local_offer_outlined, color: AppColors.primary),

          const SizedBox(width: AppSpacing.lg),

          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.reviewBody,

                children: [
                  TextSpan(
                    text:
                        'You saved ₹${_viewModel.couponDiscount.toInt()} with ',
                  ),

                  TextSpan(
                    text: _viewModel.couponCode,

                    style: AppTextStyles.reviewBody.copyWith(
                      fontWeight: AppTypography.semiBold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          GestureDetector(
            onTap: _viewModel.removeCoupon,

            child: Text(
              'Remove',

              style: AppTextStyles.reviewAction.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // GOODS DETAILS
  // =========================================================

  Widget _buildGoodsDetailsCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(AppSpacing.lg),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),

        border: Border.all(color: AppColors.border),
        boxShadow: _cardShadow,
      ),

      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Goods Details',

                  style: AppTextStyles.reviewSectionTitle,
                ),
              ),

              GestureDetector(
                onTap: () {
                  _viewModel.changeGoodsDetails(context);
                },

                child: Text('Change', style: AppTextStyles.reviewAction),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.xxl),

          Row(
            children: [
              Expanded(
                child: _buildGoodsItem(
                  title: 'Category',
                  value: _viewModel.goodsCategory,
                ),
              ),

              Expanded(
                child: _buildGoodsItem(
                  title: 'Weight',
                  value: _viewModel.goodsWeight,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.xxl),

          Row(
            children: [
              Expanded(
                child: _buildGoodsItem(
                  title: 'Packages',
                  value: _viewModel.goodsPackages,
                ),
              ),

              Expanded(
                child: _buildGoodsItem(
                  title: 'Value',
                  value: _viewModel.goodsValue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoodsItem({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(title, style: AppTextStyles.reviewLabel),

        const SizedBox(height: AppSpacing.sm),

        Text(value, style: AppTextStyles.reviewValue),
      ],
    );
  }

  // =========================================================
  // RESTRICTED ITEMS
  // =========================================================

  Widget _buildRestrictedItemsCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(AppSpacing.lg),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),

        border: Border.all(color: AppColors.border),
        boxShadow: _cardShadow,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: AppColors.primary),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Text(
                  'Do not send restricted items',

                  style: AppTextStyles.reviewSectionTitle,
                ),
              ),

              GestureDetector(
                onTap: _showRestrictedItems,

                child: Text('View List', style: AppTextStyles.reviewAction),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.xl),

          _buildBullet(
            'No illegal goods, hazardous materials, or flammable items.',
          ),

          const SizedBox(height: AppSpacing.md),

          _buildBullet('Ensure items are properly packed to prevent damage.'),

          const SizedBox(height: AppSpacing.md),

          _buildBullet('Check the selected vehicle capacity before booking.'),
        ],
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text('•', style: AppTextStyles.reviewSecondary),

        const SizedBox(width: AppSpacing.sm),

        Expanded(
          child: Text(
            text,

            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // BOTTOM BAR
  // =========================================================

  Widget _buildBottomBookingBar() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.lg,
      ),

      decoration: BoxDecoration(
        color: AppColors.surface,

        border: const Border(top: BorderSide(color: AppColors.border)),

        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(AppColors.opacityShadow),

            blurRadius: AppSpacing.shadowBlur,

            offset: const Offset(0, -4),
          ),
        ],
      ),

      child: SafeArea(
        top: false,

        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisSize: MainAxisSize.min,

                children: [
                  InkWell(
                    onTap: null,

                    child: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        const Icon(
                          Icons.payments_outlined,

                          size: AppSpacing.iconMedium,
                        ),

                        const SizedBox(width: AppSpacing.sm),

                        Text(
                          'Payment pending',

                          style: AppTextStyles.reviewSectionTitle,
                        ),

                        // const Icon(Icons.keyboard_arrow_down_rounded),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xs),

                  Text('Fare unavailable', style: AppTextStyles.reviewPrice),

                  // GestureDetector(
                  //   onTap: _showFareBreakup,

                  //   child: Text(
                  //     'View Breakup',

                  //     style: AppTextStyles.reviewAction,
                  //   ),
                  // ),
                  Text(
                    'Awaiting fare from server',
                    style: AppTextStyles.reviewSecondary,
                  ),
                ],
              ),
            ),

            const SizedBox(width: AppSpacing.md),

            Expanded(
              flex: 2,
              child: SizedBox(
                height: AppSpacing.buttonHeight,
                child: ElevatedButton(
                  onPressed: null,
                  child: Text(
                    'Unavailable',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.reviewButton,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // FARE BREAKUP
  // =========================================================

  void _showFareBreakup() {
    final fare = _viewModel.fareBreakup;

    if (fare == null) return;

    FareBreakupBottomSheet.show(context, fare: fare);
  }

  // =========================================================
  // GSTIN SHEET
  // =========================================================

  void _showGstinSheet() {
    final controller = TextEditingController(text: _viewModel.gstin ?? '');

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: AppColors.background,

      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.xxl,
            AppSpacing.screenHorizontal,
            MediaQuery.of(context).viewInsets.bottom + AppSpacing.xxl,
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text('Add GSTIN', style: AppTextStyles.heading1),

              const SizedBox(height: AppSpacing.xl),

              TextField(
                controller: controller,

                textCapitalization: TextCapitalization.characters,

                decoration: const InputDecoration(hintText: 'Enter GSTIN'),
              ),

              const SizedBox(height: AppSpacing.xl),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
                    if (controller.text.trim().isEmpty) {
                      return;
                    }

                    _viewModel.saveGstin(controller.text);

                    Navigator.pop(context);
                  },

                  child: Text('Save GSTIN', style: AppTextStyles.buttonText),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // =========================================================
  // TEMP PAYMENT
  // =========================================================

  void _showPaymentMethods() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return PaymentMethodSheet(
          selectedMethod: _viewModel.paymentMethod,
          amount: _viewModel.totalAmount ?? 0,
          onSelected: (method) {
            _viewModel.changePaymentMethod(method);

            Navigator.pop(context);
          },
        );
      },
    );
  }

  Widget _paymentOption(String method) {
    return ListTile(
      onTap: () {
        _viewModel.changePaymentMethod(method);

        Navigator.pop(context);
      },

      leading: const Icon(Icons.payments_outlined),

      title: Text(method),

      trailing: _viewModel.paymentMethod == method
          ? const Icon(Icons.check_circle_rounded)
          : null,
    );
  }

  // =========================================================
  // RESTRICTED ITEMS SHEET
  // =========================================================

  void _showRestrictedItems() {
    const items = [
      'Illegal goods or prohibited substances',
      'Explosives and flammable materials',
      'Hazardous chemicals',
      'Weapons and ammunition',
      'Live animals',
      'Any item prohibited by applicable law',
    ];

    showModalBottomSheet(
      context: context,

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text('Restricted Items', style: AppTextStyles.heading1),

                const SizedBox(height: AppSpacing.xl),

                for (final item in items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),

                    child: Text('• $item', style: AppTextStyles.bodyLarge),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
