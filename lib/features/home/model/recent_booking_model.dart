import 'package:flutter/material.dart';

class RecentBookingModel {
  final String vehicleName;
  final String time;
  final String pickup;
  final String destination;
  final String amount;
  final String status;
  final IconData icon;

  const RecentBookingModel({
    required this.vehicleName,
    required this.time,
    required this.pickup,
    required this.destination,
    required this.amount,
    required this.status,
    required this.icon,
  });
}