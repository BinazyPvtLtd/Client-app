import 'package:client_app/features/trip_completed/view/trip_completed_screen.dart';
import 'package:flutter/material.dart';

enum DeliveryTripStatus {
  bookingConfirmed,
  pickupCompleted,
  onTheWay,
  delivered,
}

class OnTheWayViewModel extends ChangeNotifier {
  // =========================================================
  // DRIVER
  // =========================================================

  String get driverName => 'Rahul Kumar';

  String get driverRating => '4.8';

  String get vehicleName => 'Mini Truck (Tata Ace)';

  String get vehicleNumber => 'UP32 AB 1234';

  // =========================================================
  // DESTINATION
  // =========================================================

  String get destination =>
      '45, Industrial Area, Phase 2, Okhla';

  // =========================================================
  // TIMELINE
  // =========================================================

  String get bookingConfirmedTime => '10:15 AM';

  String get pickupCompletedTime => '10:45 AM';

  int get arrivalMinutes => 12;

  String get arrivalText =>
      'Arriving in ~$arrivalMinutes min';

  // =========================================================
  // CURRENT STATUS
  // =========================================================

  DeliveryTripStatus _currentStatus =
      DeliveryTripStatus.onTheWay;

  DeliveryTripStatus get currentStatus =>
      _currentStatus;

  bool get isDelivered =>
      _currentStatus == DeliveryTripStatus.delivered;

  // =========================================================
  // MARK DELIVERED
  // =========================================================

  Future<void> markDelivered(
    BuildContext context,
  ) async {
    // Already delivered ho chuka hai to dobara kuch mat karo.
    if (_currentStatus == DeliveryTripStatus.delivered) {
      return;
    }

    _currentStatus = DeliveryTripStatus.delivered;

    notifyListeners();

    debugPrint('================================');
    debugPrint('TRIP STATUS: DELIVERED');
    debugPrint('================================');

    // UI ko delivered state process karne ke liye ek frame do.
    await Future<void>.delayed(
      const Duration(milliseconds: 150),
    );

    if (!context.mounted) {
      return;
    }

    // Searching / On The Way screen ko history me rakhne ki
    // zarurat nahi, therefore pushReplacement.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) =>
            const TripCompletedScreen(),
      ),
    );
  }

  // =========================================================
  // CALL
  // =========================================================

  void callDriver() {
    debugPrint('Call driver');
  }

  // =========================================================
  // CHAT
  // =========================================================

  void openChat(
    BuildContext context,
  ) {
    debugPrint('Open chat');
  }

  // =========================================================
  // SUPPORT
  // =========================================================

  void openSupport(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (
        dialogContext,
      ) {
        return AlertDialog(
          title: const Text(
            'Need Help?',
          ),
          content: const Text(
            'Our support team can help you with your ongoing delivery.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },
              child: const Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }
}