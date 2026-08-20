import 'package:client_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:client_app/core/theme/app_colors.dart';
import 'package:client_app/core/theme/app_spacing.dart';
import 'package:client_app/core/theme/app_text_styles.dart';

class ReviewBookingScreen extends StatefulWidget {
  const ReviewBookingScreen({
    super.key,
  });

  @override
  State<ReviewBookingScreen> createState() =>
      _ReviewBookingScreenState();
}

class _ReviewBookingScreenState extends State<ReviewBookingScreen> {
  // =========================================================
  // BOOKING DATA
  // =========================================================

  String paymentMethod = 'Cash';

  bool couponApplied = true;

  final String couponCode = '2W15OFF';

  // =========================================================
  // GOODS DATA
  // Replace these later with your existing ViewModel data.
  // =========================================================

  final String goodsCategory = 'Household';
  final String goodsWeight = '20 kg';
  final String goodsPackages = '3';
  final String goodsValue = '₹2,500';

  // =========================================================
  // FARE DATA
  // =========================================================

  final double tripFare = 120;
  final double distanceCharge = 45;
  final double loadingUnloadingCharge = 0;
  final double platformFee = 5;
  final double taxes = 15;

  double get discount => couponApplied ? 15 : 0;

  double get totalAmount {
    return tripFare +
        distanceCharge +
        loadingUnloadingCharge +
        platformFee +
        taxes -
        discount;
  }

  // =========================================================
  // SCREEN
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // =======================================================
      // APP BAR
      // =======================================================

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
            size: AppSpacing.iconLarge,
          ),
        ),

        title: Text(
          'Review Booking',
          style: AppTextStyles.reviewTitle,
        ),

        toolbarHeight: 90,
      ),

      // =======================================================
      // BODY
      // =======================================================

      body: Column(
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
                  // =================================================
                  // LOADING / UNLOADING
                  // =================================================

                  _buildLoadingInfoCard(),

                  const SizedBox(
                    height: AppSpacing.xs,
                  ),

                  // =================================================
                  // GSTIN
                  // =================================================

                  _buildGstinCard(),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  // =================================================
                  // COUPON
                  // =================================================

                  if (couponApplied) ...[
                    _buildCouponCard(),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),
                  ],

                  // =================================================
                  // GOODS DETAILS
                  // =================================================

                  _buildGoodsDetailsCard(),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  // =================================================
                  // RESTRICTED ITEMS
                  // =================================================

                  _buildRestrictedItemsCard(),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),
                ],
              ),
            ),
          ),

          // =======================================================
          // FIXED BOTTOM BOOKING BAR
          // =======================================================

          _buildBottomBookingBar(),
        ],
      ),
    );
  }

  // ============================================================
  // LOADING INFO CARD
  // ============================================================

  Widget _buildLoadingInfoCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(
        AppSpacing.xxl,
      ),

      decoration: BoxDecoration(
        color: AppColors.border.withOpacity(
          AppColors.opacityExtraLight,
        ),
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusCard,
        ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: AppColors.primary,
            size: AppSpacing.iconMedium,
          ),

          const SizedBox(
            width: AppSpacing.lg,
          ),

          Expanded(
            child: Text(
              'Free 20 mins of loading-unloading time included.',
              style: AppTextStyles.reviewBody,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // GSTIN CARD
  // ============================================================

  Widget _buildGstinCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.xl,
      ),

      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusCard,
        ),
        border: Border.all(
          color: AppColors.border,
          width: AppSpacing.borderThin,
        ),
      ),

      child: Row(
        children: [
          const Icon(
            Icons.receipt_long_outlined,
            color: AppColors.textSecondary,
            size: AppSpacing.iconLarge,
          ),

          const SizedBox(
            width: AppSpacing.lg,
          ),

          Expanded(
            child: Text(
              'Have a GST Number?',
              style: AppTextStyles.reviewAction,
            ),
          ),

          OutlinedButton(
            onPressed: _showGstinSheet,

            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,

              side: const BorderSide(
                color: AppColors.primary,
                width: AppSpacing.borderMedium,
              ),

              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppSpacing.radiusCircular,
                ),
              ),
            ),

            child: Text(
              'Add GSTIN',
              style: AppTextStyles.reviewAction,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // COUPON CARD
  // ============================================================

  Widget _buildCouponCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.xl,
      ),

      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(
          AppColors.opacityExtraLight,
        ),
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusCard,
        ),
        border: Border.all(
          color: AppColors.primaryLight.withOpacity(
            AppColors.opacityLightStrong,
          ),
        ),
      ),

      child: Row(
        children: [
          const Icon(
            Icons.local_offer_outlined,
            color: AppColors.primary,
            size: AppSpacing.iconLarge,
          ),

          const SizedBox(
            width: AppSpacing.lg,
          ),

          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.reviewBody,

                children: [
                  const TextSpan(
                    text: 'You saved ₹15 with ',
                  ),

                  TextSpan(
                    text: couponCode,
                    style: AppTextStyles.reviewBody.copyWith(
  fontWeight: AppTypography.semiBold,
),
                  ),
                ],
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              setState(() {
                couponApplied = false;
              });
            },

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

  // ============================================================
  // GOODS DETAILS CARD
  // ============================================================

  Widget _buildGoodsDetailsCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(
        AppSpacing.xxl,
      ),

      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusCard,
        ),
        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Column(
        children: [
          // ------------------------------------------------------
          // TITLE
          // ------------------------------------------------------

          Row(
            children: [
              Expanded(
                child: Text(
                  'Goods Details',
                  style: AppTextStyles.reviewSectionTitle,
                ),
              ),

              GestureDetector(
                onTap: _changeGoodsDetails,

                child: Text(
                  'Change',
                  style: AppTextStyles.reviewAction,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.xxl,
          ),

          // ------------------------------------------------------
          // ROW 1
          // ------------------------------------------------------

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildGoodsItem(
                  title: 'Category',
                  value: goodsCategory,
                ),
              ),

              Expanded(
                child: _buildGoodsItem(
                  title: 'Weight',
                  value: goodsWeight,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.xxl,
          ),

          // ------------------------------------------------------
          // ROW 2
          // ------------------------------------------------------

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildGoodsItem(
                  title: 'Packages',
                  value: goodsPackages,
                ),
              ),

              Expanded(
                child: _buildGoodsItem(
                  title: 'Value',
                  value: goodsValue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // GOODS ITEM
  // ============================================================

  Widget _buildGoodsItem({
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.reviewLabel,
        ),

        const SizedBox(
          height: AppSpacing.sm,
        ),

        Text(
          value,
          style: AppTextStyles.reviewValue,
        ),
      ],
    );
  }

  // ============================================================
  // RESTRICTED ITEMS CARD
  // ============================================================

  Widget _buildRestrictedItemsCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(
        AppSpacing.xxl,
      ),

      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusCard,
        ),
        border: Border.all(
          color: AppColors.error.withOpacity(
            AppColors.opacityLight,
          ),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------------------------------------------------------
          // HEADER
          // ------------------------------------------------------

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.error,
                size: AppSpacing.iconLarge,
              ),

              const SizedBox(
                width: AppSpacing.lg,
              ),

              Expanded(
                child: Text(
                  'Do not send restricted items',
                  style: AppTextStyles.reviewSectionTitle.copyWith(
  color: AppColors.error,
),
                ),
              ),

              GestureDetector(
                onTap: _showRestrictedItems,

                child: Text(
                  'View List',
                  style: AppTextStyles.reviewAction,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.xl,
          ),

          // ------------------------------------------------------
          // BULLETS
          // ------------------------------------------------------

          _buildBullet(
            'No illegal goods, hazardous materials, or flammable items.',
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          _buildBullet(
            'Ensure items are properly packed to prevent damage.',
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          _buildBullet(
            'Maximum weight limit for 2 Wheeler is strictly 20kg.',
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BULLET
  // ============================================================

  Widget _buildBullet(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '•',
          style: AppTextStyles.reviewSecondary,
        ),

        const SizedBox(
          width: AppSpacing.sm,
        ),

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

  // ============================================================
  // BOTTOM BOOKING BAR
  // ============================================================

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

        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(
            AppSpacing.radiusCard,
          ),
        ),

        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(
              AppColors.opacityShadow,
            ),
            blurRadius: AppSpacing.shadowBlur,
            offset: const Offset(0, -5),
          ),
        ],
      ),

      child: SafeArea(
        top: false,

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ==================================================
            // PAYMENT + PRICE
            // ==================================================

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _showPaymentMethods,

                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.payments_outlined,
                          color: AppColors.primary,
                          size: AppSpacing.iconMedium,
                        ),

                        const SizedBox(
                          width: AppSpacing.sm,
                        ),

                        Text(
                          paymentMethod,
                          style: AppTextStyles.reviewSectionTitle,
                        ),

                        const SizedBox(
                          width: AppSpacing.xs,
                        ),

                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: AppSpacing.iconMedium,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.xs,
                  ),

                  Text(
                    '₹${totalAmount.toInt()}',
                    style: AppTextStyles.reviewPrice,
                  ),

                  GestureDetector(
                    onTap: _showFareBreakup,

                    child: Text(
                      'View Breakup',
                      style: AppTextStyles.reviewAction,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              width: AppSpacing.md,
            ),

            // ==================================================
            // BOOK BUTTON
            // ==================================================

            Expanded(
              child: SizedBox(
                height: AppSpacing.buttonHeight,

                child: ElevatedButton(
                  onPressed: _bookVehicle,

                  child: Text(
                    'Book 2 Wheeler',
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

  // ============================================================
  // FARE BREAKUP BOTTOM SHEET
  // ============================================================

  void _showFareBreakup() {
    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: AppColors.transparent,

      barrierColor: AppColors.overlay,

      builder: (context) {
        return SafeArea(
          top: false,

          child: Container(
            width: double.infinity,

            constraints: BoxConstraints(
              maxHeight:
                  MediaQuery.of(context).size.height * 0.85,
            ),

            decoration: const BoxDecoration(
              color: AppColors.surface,

              borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                  30,
                ),
              ),
            ),

            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.md,
                AppSpacing.screenHorizontal,
                AppSpacing.xxl,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =================================================
                  // DRAG HANDLE
                  // =================================================

                  Center(
                    child: Container(
                      width: 86,
                      height: 5,

                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius:
                            BorderRadius.circular(
                          AppSpacing.radiusCircular,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.xxl,
                  ),

                  // =================================================
                  // HEADER
                  // =================================================

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Fare Breakup',
                          style: AppTextStyles.heading1.copyWith(
                            fontWeight:
                                AppTypography.extraBold,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        icon: const Icon(
                          Icons.close_rounded,
                          size: AppSpacing.iconMedium,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: AppSpacing.xxxl,
                  ),

                  // =================================================
                  // FARE ROWS
                  // =================================================

                  _buildFareRow(
                    'Trip Fare',
                    '₹${tripFare.toInt()}',
                  ),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  _buildFareRow(
                    'Distance Charge',
                    '₹${distanceCharge.toInt()}',
                  ),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  _buildFareRow(
                    'Loading/Unloading',
                    loadingUnloadingCharge == 0
                        ? 'Free'
                        : '₹${loadingUnloadingCharge.toInt()}',
                    valueColor:
                        loadingUnloadingCharge == 0
                            ? AppColors.primary
                            : AppColors.textPrimary,
                  ),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  _buildFareRow(
                    'Platform Fee',
                    '₹${platformFee.toInt()}',
                  ),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  _buildFareRow(
                    'Taxes',
                    '₹${taxes.toInt()}',
                  ),

                  if (couponApplied) ...[
                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    _buildFareRow(
                      'Discount ($couponCode)',
                      '- ₹${discount.toInt()}',
                      titleColor: AppColors.primary,
                      valueColor: AppColors.primary,
                    ),
                  ],

                  const SizedBox(
                    height: AppSpacing.lg,
                  ),

                  const Divider(),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  // =================================================
                  // AMOUNT PAYABLE
                  // =================================================

                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                      vertical: AppSpacing.xl,
                    ),

                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(
                        AppColors.opacityExtraLight,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        AppSpacing.radiusCard,
                      ),

                      border: Border.all(
                        color:
                            AppColors.primaryLight.withOpacity(
                          AppColors.opacityLightStrong,
                        ),
                      ),
                    ),

                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Amount Payable',
                            style:
                                AppTextStyles.heading2.copyWith(
                              fontWeight:
                                  AppTypography.bold,
                            ),
                          ),
                        ),

                        Text(
                          '₹${totalAmount.toInt()}',
                          style:
                              AppTextStyles.displayMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight:
                                AppTypography.extraBold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.lg,
                  ),

                  // =================================================
                  // INFORMATION
                  // =================================================

                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        size: AppSpacing.iconSmall,
                        color: AppColors.textSecondary,
                      ),

                      const SizedBox(
                        width: AppSpacing.md,
                      ),

                      Expanded(
                        child: Text(
                          'Includes all applicable taxes and fees. '
                          'Final amount may vary based on actual '
                          'wait time or route changes.',
                          style:
                              AppTextStyles.bodyMedium.copyWith(
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: AppSpacing.xxl,
                  ),

                  // =================================================
                  // DONE
                  // =================================================

                  SizedBox(
                    width: double.infinity,
                    height: AppSpacing.buttonHeight,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: Text(
                        'Done',
                        style: AppTextStyles.buttonText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // FARE ROW
  // ============================================================

  Widget _buildFareRow(
    String title,
    String value, {
    Color? titleColor,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,

            style: AppTextStyles.heading3.copyWith(
              color:
                  titleColor ?? AppColors.textSecondary,
            ),
          ),
        ),

        Text(
          value,

          style: AppTextStyles.heading3.copyWith(
            color:
                valueColor ?? AppColors.textPrimary,
            fontWeight: AppTypography.semiBold,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // GSTIN SHEET
  // ============================================================

  void _showGstinSheet() {
    final gstController = TextEditingController();

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: AppColors.surface,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            AppSpacing.radiusCard,
          ),
        ),
      ),

      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.xxl,
            AppSpacing.screenHorizontal,
            MediaQuery.of(context).viewInsets.bottom +
                AppSpacing.xxl,
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                'Add GSTIN',
                style: AppTextStyles.heading1,
              ),

              const SizedBox(
                height: AppSpacing.xl,
              ),

              TextField(
                controller: gstController,

                textCapitalization:
                    TextCapitalization.characters,

                decoration: const InputDecoration(
                  hintText: 'Enter GSTIN',
                ),
              ),

              const SizedBox(
                height: AppSpacing.xl,
              ),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
                    final gstin =
                        gstController.text.trim();

                    if (gstin.isEmpty) {
                      return;
                    }

                    Navigator.pop(context);
                  },

                  child: Text(
                    'Save GSTIN',
                    style: AppTextStyles.buttonText,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // PAYMENT METHODS
  // ============================================================

  void _showPaymentMethods() {
    showModalBottomSheet(
      context: context,

      backgroundColor: AppColors.surface,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            AppSpacing.radiusCard,
          ),
        ),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(
              AppSpacing.xxl,
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  'Payment Method',
                  style: AppTextStyles.heading1,
                ),

                const SizedBox(
                  height: AppSpacing.xl,
                ),

                _buildPaymentOption(
                  icon: Icons.payments_outlined,
                  title: 'Cash',
                  selected:
                      paymentMethod == 'Cash',
                  onTap: () {
                    setState(() {
                      paymentMethod = 'Cash';
                    });

                    Navigator.pop(context);
                  },
                ),

                const SizedBox(
                  height: AppSpacing.md,
                ),

                _buildPaymentOption(
                  icon:
                      Icons.account_balance_wallet_outlined,
                  title: 'Online Payment',
                  selected:
                      paymentMethod == 'Online Payment',
                  onTap: () {
                    setState(() {
                      paymentMethod =
                          'Online Payment';
                    });

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // PAYMENT OPTION
  // ============================================================

  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(
        AppSpacing.radiusMedium,
      ),

      child: Container(
        width: double.infinity,

        padding: const EdgeInsets.all(
          AppSpacing.lg,
        ),

        decoration: BoxDecoration(
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
            Icon(
              icon,
              color: AppColors.primary,
              size: AppSpacing.iconMedium,
            ),

            const SizedBox(
              width: AppSpacing.lg,
            ),

            Expanded(
              child: Text(
                title,
                style: AppTextStyles.heading3,
              ),
            ),

            if (selected)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: AppSpacing.iconMedium,
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // RESTRICTED ITEMS
  // ============================================================

  void _showRestrictedItems() {
    const restrictedItems = [
      'Illegal goods or prohibited substances',
      'Explosives and flammable materials',
      'Hazardous chemicals',
      'Weapons and ammunition',
      'Live animals',
      'Any item prohibited by applicable law',
    ];

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: AppColors.surface,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            AppSpacing.radiusCard,
          ),
        ),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xxl,
              AppSpacing.xxl,
              AppSpacing.xxl,
              AppSpacing.xxl,
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Restricted Items',
                        style:
                            AppTextStyles.heading1,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: const Icon(
                        Icons.close_rounded,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: AppSpacing.xl,
                ),

                ...restrictedItems.map(
                  (item) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: AppSpacing.lg,
                      ),

                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          const Icon(
                            Icons.close_rounded,
                            color: AppColors.error,
                            size: AppSpacing.iconSmall,
                          ),

                          const SizedBox(
                            width: AppSpacing.md,
                          ),

                          Expanded(
                            child: Text(
                              item,
                              style:
                                  AppTextStyles.bodyLarge.copyWith(
                                color:
                                    AppColors.textSecondary,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(
                  height: AppSpacing.sm,
                ),

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: Text(
                      'Got It',
                      style:
                          AppTextStyles.buttonText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // CHANGE GOODS
  // ============================================================

  void _changeGoodsDetails() {
    // ----------------------------------------------------------
    // Connect this with your existing Goods Details screen.
    //
    // Example:
    //
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => const GoodsDetailsScreen(),
    //   ),
    // );
    // ----------------------------------------------------------

    debugPrint('Change Goods Details');
  }

  // ============================================================
  // BOOK VEHICLE
  // ============================================================

  void _bookVehicle() {
    // ----------------------------------------------------------
    // Connect this with your existing booking ViewModel/API.
    //
    // Example:
    //
    // context.read<BookingViewModel>().createBooking(...);
    //
    // ----------------------------------------------------------

    debugPrint('================================');
    debugPrint('BOOKING STARTED');
    debugPrint('Vehicle: 2 Wheeler');
    debugPrint('Payment: $paymentMethod');
    debugPrint(
      'Amount: ₹${totalAmount.toInt()}',
    );
    debugPrint('================================');
  }
}