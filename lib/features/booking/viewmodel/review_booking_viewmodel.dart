import 'package:client_app/features/booking/view/models/fare_breakup_model.dart';
import 'package:client_app/features/searching_driver/view/searching_driver_screen.dart';
import 'package:flutter/material.dart';


class ReviewBookingViewModel extends ChangeNotifier {
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

  bool _couponApplied = true;

  bool get couponApplied => _couponApplied;

  String get couponCode => '2W15OFF';

  double get couponDiscount =>
      _couponApplied ? 15 : 0;

  void removeCoupon() {
    _couponApplied = false;
    notifyListeners();
  }

  // =========================================================
  // GOODS DETAILS
  // =========================================================

  String get goodsCategory => 'Household';

  String get goodsWeight => '20 kg';

  String get goodsPackages => '3';

  String get goodsValue => '₹2,500';

  // =========================================================
  // VEHICLE
  // =========================================================

  String get vehicleName => '2 Wheeler';

  // =========================================================
  // FARE
  // =========================================================

  FareBreakupModel get fareBreakup {
    return FareBreakupModel(
      tripFare: 120,
      distanceCharge: 45,
      loadingUnloadingCharge: 0,
      platformFee: 5,
      taxes: 15,
      discount: couponDiscount,
    );
  }

  double get totalAmount =>
      fareBreakup.total;

  // =========================================================
  // GSTIN
  // =========================================================

  String? _gstin;

  String? get gstin => _gstin;

  bool get hasGstin =>
      _gstin != null &&
      _gstin!.isNotEmpty;

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

  void changeGoodsDetails(
    BuildContext context,
  ) {
    debugPrint('Change Goods Details');

    // Later:
    //
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) =>
    //         const GoodsDetailsScreen(),
    //   ),
    // );
  }

  // =========================================================
  // BOOK VEHICLE
  // =========================================================

  void bookVehicle(
  BuildContext context,
) {
  debugPrint('================================');
  debugPrint('BOOKING CONFIRMED');
  debugPrint('Vehicle: $vehicleName');
  debugPrint('Payment: $paymentMethod');
  debugPrint(
    'Amount: ₹${totalAmount.toInt()}',
  );
  debugPrint('================================');

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) =>
          const SearchingDriverScreen(),
    ),
  );
}
}