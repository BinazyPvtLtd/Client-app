import 'package:flutter/material.dart';

class ReadyToBookViewModel extends ChangeNotifier {
  // =========================================================
  // VEHICLE
  // =========================================================

  String get vehicleName => '2 Wheeler';

  // =========================================================
  // LOCATIONS
  // =========================================================

  String get pickupAddress =>
      'Current Location, Lucknow';

  String get dropAddress =>
      'Jinnato Wali Masjid, Sarfarazganj';

  // =========================================================
  // GOODS
  // =========================================================

  String get goodsCategory => 'Household';

  String get goodsWeight => '20 kg';

  // =========================================================
  // PAYMENT
  // =========================================================

  String get paymentMethod => 'Cash';

  // =========================================================
  // FARE
  // =========================================================

  double get finalFare => 45;

  // =========================================================
  // BOOK NOW
  // =========================================================

  void bookNow(BuildContext context) {
    debugPrint('================================');
    debugPrint('BOOKING CONFIRMED');
    debugPrint('Vehicle: $vehicleName');
    debugPrint('Pickup: $pickupAddress');
    debugPrint('Drop: $dropAddress');
    debugPrint('Goods: $goodsCategory');
    debugPrint('Payment: $paymentMethod');
    debugPrint('Fare: ₹${finalFare.toInt()}');
    debugPrint('================================');

    // Later:
    //
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) =>
    //         const SearchingDriverScreen(),
    //   ),
    // );
  }

  // =========================================================
  // EDIT BOOKING
  // =========================================================

  void editBooking(BuildContext context) {
    Navigator.pop(context);
  }
}