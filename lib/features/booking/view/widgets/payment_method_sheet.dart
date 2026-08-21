import 'package:client_app/core/theme/app_colors.dart';
import 'package:client_app/core/theme/app_spacing.dart';
import 'package:client_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';



class PaymentMethodSheet extends StatefulWidget {
  final String selectedMethod;
  final double amount;
  final ValueChanged<String> onSelected;

  const PaymentMethodSheet({
    super.key,
    required this.selectedMethod,
    required this.amount,
    required this.onSelected,
  });

  @override
  State<PaymentMethodSheet> createState() =>
      _PaymentMethodSheetState();
}

class _PaymentMethodSheetState
    extends State<PaymentMethodSheet> {
  late String _selectedMethod;

  @override
  void initState() {
    super.initState();

    _selectedMethod = widget.selectedMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),

      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.md,
            AppSpacing.screenHorizontal,
            AppSpacing.xxl,
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // =============================================
              // DRAG HANDLE
              // =============================================

              Container(
                width: 55,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius:
                      BorderRadius.circular(100),
                ),
              ),

              const SizedBox(
                height: AppSpacing.xxl,
              ),

              // =============================================
              // HEADER
              // =============================================

              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Choose Payment\nMethod',
                      style:
                          AppTextStyles.heading1.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: AppSpacing.xxl,
              ),

              // =============================================
              // CASH
              // =============================================

              _buildPaymentOption(
                icon: Icons.payments_outlined,
                title: 'Cash',
                subtitle:
                    'Pay the captain after delivery',
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              // =============================================
              // UPI
              // =============================================

              _buildPaymentOption(
                icon: Icons.qr_code_rounded,
                title: 'UPI',
                subtitle: 'Pay securely using UPI',
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              // =============================================
              // CARD
              // =============================================

              _buildPaymentOption(
                icon: Icons.credit_card_rounded,
                title: 'Card',
                subtitle: 'Credit / Debit Card',
              ),

              const SizedBox(
                height: AppSpacing.xxxl,
              ),

              const Divider(),

              const SizedBox(
                height: AppSpacing.xl,
              ),

              // =============================================
              // AMOUNT
              // =============================================

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      'Amount\nPayable',
                      style:
                          AppTextStyles.bodyLarge.copyWith(
                        color:
                            AppColors.textSecondary,
                      ),
                    ),
                  ),

                  Text(
                    '₹${widget.amount.toInt()}',
                    style:
                        AppTextStyles.heading1.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: AppSpacing.xl,
              ),

              // =============================================
              // CONFIRM BUTTON
              // =============================================

              SizedBox(
                width: double.infinity,
                height: AppSpacing.buttonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onSelected(
                      _selectedMethod,
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.black,
                    foregroundColor:
                        AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        AppSpacing.radiusCircular,
                      ),
                    ),
                  ),

                  child: Text(
                    'Confirm',
                    style:
                        AppTextStyles.buttonText.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // PAYMENT OPTION
  // =========================================================

  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final bool selected =
        _selectedMethod == title;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedMethod = title;
        });
      },

      borderRadius: BorderRadius.circular(
        AppSpacing.radiusCard,
      ),

      child: Container(
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
            color: selected
                ? AppColors.black
                : AppColors.border,

            width: selected ? 2 : 1,
          ),
        ),

        child: Row(
          children: [
            // =============================================
            // ICON
            // =============================================

            Container(
              width: 52,
              height: 52,

              decoration: BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),

              child: Icon(
                icon,
                color: AppColors.black,
                size: AppSpacing.iconLarge,
              ),
            ),

            const SizedBox(
              width: AppSpacing.lg,
            ),

            // =============================================
            // TEXT
            // =============================================

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        AppTextStyles.heading3.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.xs,
                  ),

                  Text(
                    subtitle,
                    style:
                        AppTextStyles.bodyMedium.copyWith(
                      color:
                          AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              width: AppSpacing.md,
            ),

            // =============================================
            // RADIO
            // =============================================

            Container(
              width: 24,
              height: 24,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                border: Border.all(
                  color: selected
                      ? AppColors.black
                      : AppColors.border,

                  width: 2,
                ),

                color: selected
                    ? AppColors.black
                    : AppColors.white,
              ),

              child: selected
                  ? const Icon(
                      Icons.circle,
                      size: 9,
                      color: AppColors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}