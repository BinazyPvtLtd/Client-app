import 'package:client_app/features/booking/models/booking_details_model.dart';
import 'package:client_app/features/booking/view/models/fare_breakup_model.dart';
import 'package:flutter/material.dart';

class ReviewBookingViewModel extends ChangeNotifier {
  final BookingDetailsModel bookingDetails;

  ReviewBookingViewModel({required this.bookingDetails});

  // =========================================================
  // PAYMENT
  // =========================================================

  String _paymentMethod = 'Cash';

  String get paymentMethod => _paymentMethod;

  void changePaymentMethod(String method) {
    if (_paymentMethod == method) return;

    _paymentMethod = method;
    notifyListeners();
  }
  // =========================================================
  // COUPON
  // =========================================================

  bool _couponApplied = false;

  bool get couponApplied => _couponApplied;

  String get couponCode => '2W15OFF';

  double get couponDiscount => _couponApplied ? 15 : 0;

  void removeCoupon() {
    _couponApplied = false;
    notifyListeners();
  }

  // =========================================================
  // GOODS DETAILS
  // =========================================================

  String get goodsCategory => bookingDetails.category;

  String get goodsWeight => '${bookingDetails.weightKg} kg';

  String get goodsPackages => bookingDetails.packages.toString();

  String get goodsValue => '₹${bookingDetails.goodsValue.toStringAsFixed(0)}';

  // =========================================================
  // VEHICLE
  // =========================================================

  String get vehicleName => bookingDetails.vehicleName;
  // =========================================================
  // FARE
  // =========================================================

  // FareBreakupModel get fareBreakup {
  //   return FareBreakupModel(
  //     tripFare: 120,
  //     distanceCharge: 45,
  //     loadingUnloadingCharge: 0,
  //     platformFee: 5,
  //     taxes: 15,
  //     discount: couponDiscount,
  //   );
  // }

  // double get totalAmount => fareBreakup.total;

  // =========================================================
  // FARE — WAITING FOR BACKEND
  // =========================================================

  FareBreakupModel? _fareBreakup;

  FareBreakupModel? get fareBreakup => _fareBreakup;

  double? get totalAmount => _fareBreakup?.total;

  bool get hasFare => _fareBreakup != null;

  bool get canBook =>
      hasFare &&
      bookingDetails.pickupAddress.trim().isNotEmpty &&
      bookingDetails.dropAddress.trim().isNotEmpty &&
      bookingDetails.receiverName.trim().isNotEmpty &&
      RegExp(r'^[0-9]{10}$').hasMatch(bookingDetails.receiverPhone.trim()) &&
      bookingDetails.pickupLatitude != null &&
      bookingDetails.pickupLongitude != null &&
      bookingDetails.dropLatitude != null &&
      bookingDetails.dropLongitude != null;

  // =========================================================
  // GSTIN
  // =========================================================

  String? _gstin;

  String? get gstin => _gstin;

  bool get hasGstin => _gstin != null && _gstin!.isNotEmpty;

  void saveGstin(String value) {
    final trimmed = value.trim();

    if (trimmed.isEmpty) return;

    _gstin = trimmed;

    notifyListeners();
  }

  void removeGstin() {
    _gstin = null;
    notifyListeners();
  }

  // =========================================================
  // GOODS ACTION
  // =========================================================

  void changeGoodsDetails(BuildContext context) {
    Navigator.pop(context);
  }

  // =========================================================
  // BOOK VEHICLE
  // =========================================================

  void bookVehicle(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Booking is unavailable until the booking API is connected.',
        ),
      ),
    );
  }
}
