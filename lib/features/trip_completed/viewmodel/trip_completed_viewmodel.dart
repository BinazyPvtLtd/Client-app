import 'package:client_app/features/ride_rating/view/ride_rating_screen.dart';
import 'package:flutter/material.dart';

class TripCompletedViewModel extends ChangeNotifier {
  // =========================================================
  // TRIP
  // =========================================================

  String get tripId => '#PG-982734';

  double get totalFare => 450;

  // =========================================================
  // VEHICLE
  // =========================================================

  String get vehicleName => 'Mini Truck (Tata Ace)';

  String get vehicleNumber => 'UP32 AB 1234';

  // =========================================================
  // LOCATIONS
  // =========================================================

  String get pickupAddress =>
      '12, HSR Layout, Sector 6, Bengaluru';

  String get dropAddress =>
      '45, Industrial Area, Phase 2, Okhla';

  // =========================================================
  // TRIP SUMMARY
  // =========================================================

  String get distance => '12.4 km';

  String get duration => '45 mins';

  String get paymentMethod => 'UPI';

  // =========================================================
  // RATE
  // =========================================================

  void rateExperience(
  BuildContext context,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) =>
          const RideRatingScreen(),
    ),
  );
}

  // =========================================================
  // TRIP DETAILS
  // =========================================================

  void viewTripDetails(
    BuildContext context,
  ) {
    debugPrint('View trip details');

    // Later:
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => const TripDetailsScreen(),
    //   ),
    // );
  }
}