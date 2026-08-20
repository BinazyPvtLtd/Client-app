// import 'package:flutter/foundation.dart';

// class ReviewBookingViewModel extends ChangeNotifier {
//   // =========================================================
//   // BOOKING DATA
//   // =========================================================

//   String _paymentMethod = 'Cash';

//   String get paymentMethod => _paymentMethod;

//   // =========================================================
//   // PAYMENT METHOD
//   // ============================================
//   void changePaymentMethod() {
//     if (_paymentMethod == 'Cash') {
//       _paymentMethod = 'Online';
//     } else {
//       _paymentMethod = 'Cash';
//     }

//     notifyListeners();
//   }

//   // =========================================================
//   // GST
//   // =========================================================

//   void addGSTIN() {
//     debugPrint('Add GSTIN tapped');
//   }

//   // =========================================================
//   // REMOVE OFFER
//   // =========================================================

//   void removeOffer() {
//     debugPrint('Offer removed');
//   }

//   // =========================================================
//   // CHANGE GOODS
//   // =========================================================

//   void changeGoods() {
//     debugPrint('Change goods tapped');
//   }

//   // =========================================================
//   // VIEW RESTRICTED ITEMS
//   // =========================================================

//   void viewRestrictedItems() {
//     debugPrint('View restricted items tapped');
//   }

//   // =========================================================
//   // VIEW BREAKUP
//   // =========================================================

//   void viewBreakup() {
//     debugPrint('View breakup tapped');
//   }

//   // =========================================================
//   // BOOK
//   // =========================================================

//   void bookVehicle() {
//     debugPrint('Booking vehicle...');
//   }
// }