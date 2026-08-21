import 'package:flutter/material.dart';

import '../model/notification_model.dart';

class NotificationViewModel extends ChangeNotifier {
  // =========================================================
  // NOTIFICATIONS
  // =========================================================

  final List<NotificationModel> _notifications = [
    const NotificationModel(
      id: '1',
      title: 'Captain assigned',
      message:
          'Rahul Kumar is on the way for your trip #PG-982734.',
      time: 'Now',
      icon: Icons.person_outline_rounded,
      type: NotificationType.captainAssigned,
      isUnread: true,
    ),

    const NotificationModel(
      id: '2',
      title: 'Captain arriving',
      message:
          'Your captain is 2 mins away. Get your goods ready!',
      time: '2m ago',
      icon: Icons.local_shipping_outlined,
      type: NotificationType.captainArriving,
    ),

    const NotificationModel(
      id: '3',
      title: 'Captain arrived',
      message:
          'Rahul Kumar has reached the pickup location.',
      time: '10m ago',
      icon: Icons.person_outline_rounded,
      type: NotificationType.captainArrived,
    ),

    const NotificationModel(
      id: '4',
      title: 'Trip started',
      message:
          'Your goods are safely on the move.',
      time: '15m ago',
      icon: Icons.local_shipping_outlined,
      type: NotificationType.tripStarted,
    ),

    const NotificationModel(
      id: '5',
      title: 'Delivery completed',
      message:
          'Trip #PG-981122 successfully delivered.',
      time: '1h ago',
      icon: Icons.check_circle_outline_rounded,
      type: NotificationType.deliveryCompleted,
      isUnread: true,
    ),

    const NotificationModel(
      id: '6',
      title: 'Payment successful',
      message:
          'Received ₹450 for Trip #PG-982734 via UPI.',
      time: '1h ago',
      icon: Icons.payments_outlined,
      type: NotificationType.paymentSuccessful,
    ),

    const NotificationModel(
      id: '7',
      title: 'Booking cancelled',
      message:
          'Trip #PG-980055 has been cancelled.',
      time: 'Yesterday',
      icon: Icons.cancel_outlined,
      type: NotificationType.bookingCancelled,
    ),

    const NotificationModel(
      id: '8',
      title: 'Service update',
      message:
          'New vehicle category "XL Container" is now available.',
      time: '2d ago',
      icon: Icons.info_outline_rounded,
      type: NotificationType.serviceUpdate,
    ),
  ];

  // =========================================================
  // GETTERS
  // =========================================================

  List<NotificationModel> get notifications =>
      List.unmodifiable(_notifications);

  int get unreadCount =>
      _notifications
          .where(
            (notification) =>
                notification.isUnread,
          )
          .length;

  // =========================================================
  // OPEN NOTIFICATION
  // =========================================================

  void openNotification(
    BuildContext context,
    NotificationModel notification,
  ) {
    markAsRead(notification.id);

    debugPrint(
      'Notification clicked: ${notification.title}',
    );

    // Later:
    // Notification type ke according
    // corresponding booking/trip screen open karna.
  }

  // =========================================================
  // MARK SINGLE AS READ
  // =========================================================

  void markAsRead(String id) {
    final index = _notifications.indexWhere(
      (item) => item.id == id,
    );

    if (index == -1) return;

    if (!_notifications[index].isUnread) {
      return;
    }

    _notifications[index] =
        _notifications[index].copyWith(
      isUnread: false,
    );

    notifyListeners();
  }

  // =========================================================
  // MARK ALL AS READ
  // =========================================================

  void markAllAsRead() {
    bool changed = false;

    for (int i = 0;
        i < _notifications.length;
        i++) {
      if (_notifications[i].isUnread) {
        _notifications[i] =
            _notifications[i].copyWith(
          isUnread: false,
        );

        changed = true;
      }
    }

    if (changed) {
      notifyListeners();
    }
  }

  // =========================================================
  // MORE OPTIONS
  // =========================================================

  void showMoreOptions(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          child: Container(
            margin: const EdgeInsets.all(12),
            padding:
                const EdgeInsets.symmetric(
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.done_all_rounded,
              ),
              title: const Text(
                'Mark all as read',
              ),
              onTap: () {
                Navigator.pop(
                  sheetContext,
                );

                markAllAsRead();
              },
            ),
          ),
        );
      },
    );
  }
}