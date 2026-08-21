import 'package:client_app/core/theme/app_colors.dart';
import 'package:client_app/core/theme/app_spacing.dart';
import 'package:client_app/core/theme/app_text_styles.dart';
import 'package:client_app/core/theme/app_typography.dart';
import 'package:client_app/features/booking/view/widgets/payment_method_sheet.dart';
import 'package:client_app/features/booking/viewmodel/review_booking_viewmodel.dart';


import 'package:flutter/material.dart';

class ReviewBookingScreen
    extends StatefulWidget {
  const ReviewBookingScreen({
    super.key,
  });

  @override
  State<ReviewBookingScreen>
      createState() =>
          _ReviewBookingScreenState();
}

class _ReviewBookingScreenState
    extends State<ReviewBookingScreen> {
  late final ReviewBookingViewModel
      _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel =
        ReviewBookingViewModel();
  }

  @override
  void dispose() {
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

        toolbarHeight: 90,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back_rounded,
            size:
                AppSpacing.iconLarge,
          ),
        ),

        title: Text(
          'Review Booking',
          style:
              AppTextStyles.reviewTitle,
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
                child:
                    SingleChildScrollView(
                  physics:
                      const BouncingScrollPhysics(),

                  padding:
                      const EdgeInsets.fromLTRB(
                    AppSpacing
                        .screenHorizontal,
                    AppSpacing.sm,
                    AppSpacing
                        .screenHorizontal,
                    AppSpacing.xxxl,
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [
                      _buildLoadingInfoCard(),

                      const SizedBox(
                        height:
                            AppSpacing.md,
                      ),

                      _buildGstinCard(),

                      const SizedBox(
                        height:
                            AppSpacing.md,
                      ),

                      if (_viewModel
                          .couponApplied) ...[
                        _buildCouponCard(),

                        const SizedBox(
                          height:
                              AppSpacing.md,
                        ),
                      ],

                      _buildGoodsDetailsCard(),

                      const SizedBox(
                        height:
                            AppSpacing.md,
                      ),

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

  // =========================================================
  // LOADING INFO
  // =========================================================

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

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusCard,
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: AppColors.primary,
            size:
                AppSpacing.iconMedium,
          ),

          const SizedBox(
            width: AppSpacing.lg,
          ),

          Expanded(
            child: Text(
              'Free 20 mins of loading-unloading time included.',
              style:
                  AppTextStyles.reviewBody,
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

      padding:
          const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.xl,
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
        children: [
          const Icon(
            Icons.receipt_long_outlined,
            color:
                AppColors.textSecondary,
            size:
                AppSpacing.iconLarge,
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
                  _viewModel.hasGstin
                      ? 'GST Number'
                      : 'Have a GST Number?',
                  style: AppTextStyles
                      .reviewAction,
                ),

                if (_viewModel.hasGstin)
                  Padding(
                    padding:
                        const EdgeInsets.only(
                      top: AppSpacing.xs,
                    ),

                    child: Text(
                      _viewModel.gstin!,
                      style:
                          AppTextStyles.bodyMedium,
                    ),
                  ),
              ],
            ),
          ),

          OutlinedButton(
            onPressed:
                _showGstinSheet,

            style:
                OutlinedButton.styleFrom(
              foregroundColor:
                  AppColors.primary,

              side: const BorderSide(
                color:
                    AppColors.primary,
              ),

              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  AppSpacing
                      .radiusCircular,
                ),
              ),
            ),

            child: Text(
              _viewModel.hasGstin
                  ? 'Change'
                  : 'Add GSTIN',

              style: AppTextStyles
                  .reviewAction,
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

      padding:
          const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
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
          color: AppColors.primaryLight
              .withOpacity(
            AppColors
                .opacityLightStrong,
          ),
        ),
      ),

      child: Row(
        children: [
          const Icon(
            Icons.local_offer_outlined,
            color: AppColors.primary,
          ),

          const SizedBox(
            width: AppSpacing.lg,
          ),

          Expanded(
            child: RichText(
              text: TextSpan(
                style:
                    AppTextStyles.reviewBody,

                children: [
                  TextSpan(
                    text:
                        'You saved ₹${_viewModel.couponDiscount.toInt()} with ',
                  ),

                  TextSpan(
                    text: _viewModel
                        .couponCode,

                    style:
                        AppTextStyles.reviewBody
                            .copyWith(
                      fontWeight:
                          AppTypography
                              .semiBold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          GestureDetector(
            onTap:
                _viewModel.removeCoupon,

            child: Text(
              'Remove',

              style: AppTextStyles
                  .reviewAction
                  .copyWith(
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

      padding: const EdgeInsets.all(
        AppSpacing.xxl,
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

      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Goods Details',

                  style: AppTextStyles
                      .reviewSectionTitle,
                ),
              ),

              GestureDetector(
                onTap: () {
                  _viewModel
                      .changeGoodsDetails(
                    context,
                  );
                },

                child: Text(
                  'Change',

                  style: AppTextStyles
                      .reviewAction,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.xxl,
          ),

          Row(
            children: [
              Expanded(
                child:
                    _buildGoodsItem(
                  title: 'Category',
                  value: _viewModel
                      .goodsCategory,
                ),
              ),

              Expanded(
                child:
                    _buildGoodsItem(
                  title: 'Weight',
                  value: _viewModel
                      .goodsWeight,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.xxl,
          ),

          Row(
            children: [
              Expanded(
                child:
                    _buildGoodsItem(
                  title: 'Packages',
                  value: _viewModel
                      .goodsPackages,
                ),
              ),

              Expanded(
                child:
                    _buildGoodsItem(
                  title: 'Value',
                  value: _viewModel
                      .goodsValue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoodsItem({
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Text(
          title,
          style:
              AppTextStyles.reviewLabel,
        ),

        const SizedBox(
          height: AppSpacing.sm,
        ),

        Text(
          value,
          style:
              AppTextStyles.reviewValue,
        ),
      ],
    );
  }

  // =========================================================
  // RESTRICTED ITEMS
  // =========================================================

  Widget _buildRestrictedItemsCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(
        AppSpacing.xxl,
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

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.primary,
              ),

              const SizedBox(
                width: AppSpacing.md,
              ),

              Expanded(
                child: Text(
                  'Do not send restricted items',

                  style: AppTextStyles
                      .reviewSectionTitle,
                ),
              ),

              GestureDetector(
                onTap:
                    _showRestrictedItems,

                child: Text(
                  'View List',

                  style: AppTextStyles
                      .reviewAction,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.xl,
          ),

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

  Widget _buildBullet(
    String text,
  ) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Text(
          '•',
          style: AppTextStyles
              .reviewSecondary,
        ),

        const SizedBox(
          width: AppSpacing.sm,
        ),

        Expanded(
          child: Text(
            text,

            style:
                AppTextStyles.bodyLarge
                    .copyWith(
              color: AppColors
                  .textSecondary,
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

      child: SafeArea(
        top: false,

        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                mainAxisSize:
                    MainAxisSize.min,

                children: [
                  InkWell(
                    onTap:
                        _showPaymentMethods,

                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min,

                      children: [
                        const Icon(
                          Icons
                              .payments_outlined,

                          size: AppSpacing
                              .iconMedium,
                        ),

                        const SizedBox(
                          width:
                              AppSpacing.sm,
                        ),

                        Text(
                          _viewModel
                              .paymentMethod,

                          style: AppTextStyles
                              .reviewSectionTitle,
                        ),

                        const Icon(
                          Icons
                              .keyboard_arrow_down_rounded,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height:
                        AppSpacing.xs,
                  ),

                  Text(
                    '₹${_viewModel.totalAmount.toInt()}',

                    style: AppTextStyles
                        .reviewPrice,
                  ),

                  GestureDetector(
                    onTap:
                        _showFareBreakup,

                    child: Text(
                      'View Breakup',

                      style: AppTextStyles
                          .reviewAction,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              width: AppSpacing.md,
            ),

            Expanded(
              child: SizedBox(
                height:
                    AppSpacing.buttonHeight,

                child: ElevatedButton(
                  onPressed: () {
                    _viewModel
                        .bookVehicle(
                      context,
                    );
                  },

                  child: Text(
                    'Book ${_viewModel.vehicleName}',

                    style: AppTextStyles
                        .reviewButton,
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
    final fare =
        _viewModel.fareBreakup;

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor:
          AppColors.transparent,

      barrierColor:
          AppColors.overlay,

      builder: (context) {
        return SafeArea(
          top: false,

          child: Container(
            padding:
                const EdgeInsets.all(
              AppSpacing.xxl,
            ),

            decoration:
                const BoxDecoration(
              color:
                  AppColors.background,

              borderRadius:
                  BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),

            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Center(
                  child: Container(
                    width: 60,
                    height: 5,

                    decoration:
                        BoxDecoration(
                      color:
                          AppColors.border,

                      borderRadius:
                          BorderRadius
                              .circular(100),
                    ),
                  ),
                ),

                const SizedBox(
                  height:
                      AppSpacing.xxl,
                ),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Fare Breakup',

                        style:
                            AppTextStyles
                                .heading1,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },

                      icon: const Icon(
                        Icons.close_rounded,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height:
                      AppSpacing.xxl,
                ),

                _fareRow(
                  'Trip Fare',
                  fare.tripFare,
                ),

                _fareRow(
                  'Distance Charge',
                  fare.distanceCharge,
                ),

                _fareRow(
                  'Platform Fee',
                  fare.platformFee,
                ),

                _fareRow(
                  'Taxes',
                  fare.taxes,
                ),

                if (fare.discount > 0)
                  _fareRow(
                    'Discount',
                    -fare.discount,
                  ),

                const Divider(),

                _fareRow(
                  'Amount Payable',
                  fare.total,

                  bold: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _fareRow(
    String title,
    double amount, {
    bool bold = false,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: AppSpacing.md,
      ),

      child: Row(
        children: [
          Expanded(
            child: Text(
              title,

              style: bold
                  ? AppTextStyles
                      .reviewSectionTitle
                  : AppTextStyles
                      .reviewFareTitle,
            ),
          ),

          Text(
            amount < 0
                ? '- ₹${amount.abs().toInt()}'
                : '₹${amount.toInt()}',

            style: bold
                ? AppTextStyles
                    .reviewPrice
                : AppTextStyles
                    .reviewFareValue,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // GSTIN SHEET
  // =========================================================

  void _showGstinSheet() {
    final controller =
        TextEditingController(
      text: _viewModel.gstin ?? '',
    );

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor:
          AppColors.background,

      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing
                .screenHorizontal,
            AppSpacing.xxl,
            AppSpacing
                .screenHorizontal,
            MediaQuery.of(context)
                    .viewInsets
                    .bottom +
                AppSpacing.xxl,
          ),

          child: Column(
            mainAxisSize:
                MainAxisSize.min,

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                'Add GSTIN',

                style:
                    AppTextStyles.heading1,
              ),

              const SizedBox(
                height: AppSpacing.xl,
              ),

              TextField(
                controller: controller,

                textCapitalization:
                    TextCapitalization
                        .characters,

                decoration:
                    const InputDecoration(
                  hintText:
                      'Enter GSTIN',
                ),
              ),

              const SizedBox(
                height: AppSpacing.xl,
              ),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
                    if (controller
                        .text
                        .trim()
                        .isEmpty) {
                      return;
                    }

                    _viewModel.saveGstin(
                      controller.text,
                    );

                    Navigator.pop(
                      context,
                    );
                  },

                  child: Text(
                    'Save GSTIN',

                    style: AppTextStyles
                        .buttonText,
                  ),
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
        amount: _viewModel.totalAmount,
        onSelected: (method) {
          _viewModel.changePaymentMethod(method);

          Navigator.pop(context);
        },
      );
    },
  );
}
  Widget _paymentOption(
    String method,
  ) {
    return ListTile(
      onTap: () {
        _viewModel
            .changePaymentMethod(
          method,
        );

        Navigator.pop(context);
      },

      leading: const Icon(
        Icons.payments_outlined,
      ),

      title: Text(method),

      trailing:
          _viewModel.paymentMethod ==
                  method
              ? const Icon(
                  Icons
                      .check_circle_rounded,
                )
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
            padding:
                const EdgeInsets.all(
              AppSpacing.xxl,
            ),

            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [
                Text(
                  'Restricted Items',

                  style:
                      AppTextStyles.heading1,
                ),

                const SizedBox(
                  height: AppSpacing.xl,
                ),

                for (final item in items)
                  Padding(
                    padding:
                        const EdgeInsets.only(
                      bottom:
                          AppSpacing.md,
                    ),

                    child: Text(
                      '• $item',

                      style: AppTextStyles
                          .bodyLarge,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}