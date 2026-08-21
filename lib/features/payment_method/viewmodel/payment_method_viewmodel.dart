import 'package:flutter/material.dart';

import '../model/payment_method_model.dart';

class PaymentMethodViewModel extends ChangeNotifier {
  PaymentMethodType _selectedMethod;

  PaymentMethodViewModel({
    PaymentMethodType initialMethod = PaymentMethodType.cash,
  }) : _selectedMethod = initialMethod;

  PaymentMethodType get selectedMethod => _selectedMethod;

  // =========================================================
  // PAYMENT OPTIONS
  // =========================================================

  final List<PaymentMethodModel> paymentMethods = const [
    PaymentMethodModel(
      type: PaymentMethodType.cash,
      title: 'Cash',
      subtitle: 'Pay the captain after delivery',
      icon: Icons.payments_outlined,
    ),

    PaymentMethodModel(
      type: PaymentMethodType.upi,
      title: 'UPI',
      subtitle: 'Pay securely using UPI',
      icon: Icons.qr_code_2_rounded,
    ),

    PaymentMethodModel(
      type: PaymentMethodType.card,
      title: 'Card',
      subtitle: 'Credit / Debit Card',
      icon: Icons.credit_card_rounded,
    ),
  ];

  // =========================================================
  // SELECT PAYMENT METHOD
  // =========================================================

  void selectPaymentMethod(
    PaymentMethodType type,
  ) {
    if (_selectedMethod == type) return;

    _selectedMethod = type;

    notifyListeners();
  }

  // =========================================================
  // DISPLAY NAME
  // =========================================================

  String get selectedMethodName {
    switch (_selectedMethod) {
      case PaymentMethodType.cash:
        return 'Cash';

      case PaymentMethodType.upi:
        return 'UPI';

      case PaymentMethodType.card:
        return 'Card';
    }
  }
}