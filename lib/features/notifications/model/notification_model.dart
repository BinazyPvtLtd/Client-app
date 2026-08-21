import 'package:flutter/material.dart';

enum NotificationType {
  captainAssigned,
  captainArriving,
  captainArrived,
  tripStarted,
  deliveryCompleted,
  paymentSuccessful,
  bookingCancelled,
  serviceUpdate,
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final NotificationType type;
  final bool isUnread;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.type,
    this.isUnread = false,
  });

  NotificationModel copyWith({
    bool? isUnread,
  }) {
    return NotificationModel(
      id: id,
      title: title,
      message: message,
      time: time,
      icon: icon,
      type: type,
      isUnread: isUnread ?? this.isUnread,
    );
  }
}