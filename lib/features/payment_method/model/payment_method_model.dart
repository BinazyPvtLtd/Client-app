import 'package:flutter/material.dart';

enum PaymentMethodType {
  cash,
  upi,
  card,
}

class PaymentMethodModel {
  final PaymentMethodType type;
  final String title;
  final String subtitle;
  final IconData icon;

  const PaymentMethodModel({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}