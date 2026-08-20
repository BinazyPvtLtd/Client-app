import 'package:client_app/features/booking/view/models/fare_breakup_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class FareBreakupBottomSheet extends StatelessWidget {
  final FareBreakupModel fare;

  const FareBreakupBottomSheet({
    super.key,
    required this.fare,
  });

  static Future<void> show(
    BuildContext context, {
    required FareBreakupModel fare,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.30),
      builder: (_) {
        return FareBreakupBottomSheet(
          fare: fare,
        );
      },
    );
  }

  String _formatAmount(double amount) {
    if (amount == amount.roundToDouble()) {
      return '₹${amount.toInt()}';
    }

    return '₹${amount.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.82,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            36,
            14,
            36,
            24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 86,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8C7BA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Fare Breakup',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF202020),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 32,
                      color: Color(0xFF5A4A40),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 48),

              _FareRow(
                title: 'Trip Fare',
                amount: _formatAmount(fare.tripFare),
              ),

              const SizedBox(height: 32),

              _FareRow(
                title: 'Distance Charge',
                amount: _formatAmount(fare.distanceCharge),
              ),

              const SizedBox(height: 32),

              _FareRow(
                title: 'Loading/Unloading',
                amount: fare.loadingUnloadingCharge == 0
                    ? 'Free'
                    : _formatAmount(
                        fare.loadingUnloadingCharge,
                      ),
                amountColor: fare.loadingUnloadingCharge == 0
                    ? AppColors.primary
                    : null,
              ),

              const SizedBox(height: 32),

              _FareRow(
                title: 'Platform Fee',
                amount: _formatAmount(fare.platformFee),
              ),

              const SizedBox(height: 32),

              _FareRow(
                title: 'Taxes',
                amount: _formatAmount(fare.taxes),
              ),

              const SizedBox(height: 32),

              _FareRow(
                title: 'Discount (2W15OFF)',
                amount: '- ${_formatAmount(fare.discount)}',
                titleColor: AppColors.primary,
                amountColor: AppColors.primary,
              ),

              const SizedBox(height: 18),

              Divider(
                color: const Color(0xFFD8C7BA),
                thickness: 1.5,
              ),

              const SizedBox(height: 30),

              // Amount payable
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBF3EC),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFF0D9C4),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Amount Payable',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF202020),
                        ),
                      ),
                    ),
                    Text(
                      _formatAmount(fare.total),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 22,
                    color: const Color(0xFF4E433D),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Includes all applicable taxes and fees. '
                      'Final amount may vary based on actual wait '
                      'time or route changes.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        height: 1.5,
                        color: const Color(0xFF4E433D),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 34),

              // Done
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
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
}

class _FareRow extends StatelessWidget {
  final String title;
  final String amount;
  final Color? titleColor;
  final Color? amountColor;

  const _FareRow({
    required this.title,
    required this.amount,
    this.titleColor,
    this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: titleColor ?? const Color(0xFF51453E),
            ),
          ),
        ),
        Text(
          amount,
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: amountColor ?? const Color(0xFF202020),
          ),
        ),
      ],
    );
  }
}