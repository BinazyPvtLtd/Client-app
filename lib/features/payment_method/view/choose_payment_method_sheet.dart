import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../model/payment_method_model.dart';
import '../viewmodel/payment_method_viewmodel.dart';

class ChoosePaymentMethodSheet extends StatefulWidget {
  final double amount;

  final PaymentMethodType initialMethod;

  const ChoosePaymentMethodSheet({
    super.key,
    required this.amount,
    this.initialMethod = PaymentMethodType.cash,
  });

  @override
  State<ChoosePaymentMethodSheet> createState() =>
      _ChoosePaymentMethodSheetState();
}

class _ChoosePaymentMethodSheetState
    extends State<ChoosePaymentMethodSheet> {
  late final PaymentMethodViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = PaymentMethodViewModel(
      initialMethod: widget.initialMethod,
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,

          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),

        child: ListenableBuilder(
          listenable: _viewModel,

          builder: (context, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                // =================================================
                // DRAG HANDLE
                // =================================================

                const SizedBox(
                  height: AppSpacing.md,
                ),

                Container(
                  width: 56,
                  height: 5,

                  decoration: BoxDecoration(
                    color: AppColors.border,

                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusCircular,
                    ),
                  ),
                ),

                const SizedBox(
                  height: AppSpacing.xl,
                ),

                // =================================================
                // HEADER
                // =================================================

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenHorizontal,
                  ),

                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Expanded(
                        child: Text(
                          'Choose Payment\nMethod',
                          style: AppTextStyles.heading1.copyWith(
                            height: 1.2,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        icon: const Icon(
                          Icons.close_rounded,
                          size: AppSpacing.iconLarge,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: AppSpacing.lg,
                ),

                const Divider(
                  height: 1,
                ),

                // =================================================
                // PAYMENT OPTIONS
                // =================================================

                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenHorizontal,
                    AppSpacing.xxl,
                    AppSpacing.screenHorizontal,
                    AppSpacing.xxl,
                  ),

                  child: Column(
                    children: [
                      for (int index = 0;
                          index <
                              _viewModel
                                  .paymentMethods.length;
                          index++) ...[
                        _PaymentMethodCard(
                          payment:
                              _viewModel.paymentMethods[index],

                          selected:
                              _viewModel.selectedMethod ==
                                  _viewModel
                                      .paymentMethods[index]
                                      .type,

                          onTap: () {
                            _viewModel.selectPaymentMethod(
                              _viewModel
                                  .paymentMethods[index]
                                  .type,
                            );
                          },
                        ),

                        if (index <
                            _viewModel.paymentMethods.length -
                                1)
                          const SizedBox(
                            height: AppSpacing.lg,
                          ),
                      ],
                    ],
                  ),
                ),

                const Divider(
                  height: 1,
                ),

                // =================================================
                // AMOUNT + CONFIRM
                // =================================================

                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenHorizontal,
                    AppSpacing.xl,
                    AppSpacing.screenHorizontal,
                    AppSpacing.lg,
                  ),

                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.end,

                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [
                                Text(
                                  'Amount',
                                  style:
                                      AppTextStyles.bodyMedium,
                                ),

                                const SizedBox(
                                  height: AppSpacing.xs,
                                ),

                                Text(
                                  'Payable',
                                  style:
                                      AppTextStyles.bodyLarge,
                                ),
                              ],
                            ),
                          ),

                          Text(
                            '₹${widget.amount.toInt()}',
                            style:
                                AppTextStyles.reviewPrice.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: AppSpacing.xl,
                      ),

                      SizedBox(
                        width: double.infinity,
                        height: AppSpacing.buttonHeight,

                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                              _viewModel.selectedMethod,
                            );
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.primary,

                            foregroundColor:
                                AppColors.white,

                            elevation: 0,

                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                AppSpacing.radiusButton,
                              ),
                            ),
                          ),

                          child: Text(
                            'Confirm',
                            style:
                                AppTextStyles.buttonText,
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
}

// =====================================================================
// PAYMENT METHOD CARD
// =====================================================================

class _PaymentMethodCard extends StatelessWidget {
  final PaymentMethodModel payment;

  final bool selected;

  final VoidCallback onTap;

  const _PaymentMethodCard({
    required this.payment,
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
          AppSpacing.radiusLarge,
        ),

        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 180,
          ),

          width: double.infinity,

          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.xl,
          ),

          decoration: BoxDecoration(
            color: selected
                ? AppColors.surface
                : AppColors.background,

            borderRadius: BorderRadius.circular(
              AppSpacing.radiusLarge,
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
              // =================================================
              // ICON
              // =================================================

              Container(
                width: 58,
                height: 58,

                alignment: Alignment.center,

                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                ),

                child: Icon(
                  payment.icon,
                  size: AppSpacing.iconMedium,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(
                width: AppSpacing.lg,
              ),

              // =================================================
              // TITLE / SUBTITLE
              // =================================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      payment.title,
                      style:
                          AppTextStyles.heading3.copyWith(
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.xs,
                    ),

                    Text(
                      payment.subtitle,
                      style:
                          AppTextStyles.bodyMedium.copyWith(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: AppSpacing.md,
              ),

              // =================================================
              // RADIO INDICATOR
              // =================================================

              _SelectionCircle(
                selected: selected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// SELECTION CIRCLE
// =====================================================================

class _SelectionCircle extends StatelessWidget {
  final bool selected;

  const _SelectionCircle({
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 180,
      ),

      width: 28,
      height: 28,

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        color: selected
            ? AppColors.primary
            : AppColors.transparent,

        border: Border.all(
          color: selected
              ? AppColors.primary
              : AppColors.border,

          width: AppSpacing.borderMedium,
        ),
      ),

      child: selected
          ? Center(
              child: Container(
                width: 8,
                height: 8,

                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }
}