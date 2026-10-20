import 'package:client_app/features/booking/models/booking_details_model.dart';
import 'package:client_app/features/booking/viewmodel/review_booking_viewmodel.dart';
import 'package:client_app/features/select_vehicle/view/model/vehicle_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ReviewBookingViewModel viewModel;

  setUp(() {
    final vehicle = VehicleModel(
      id: 3,
      name: 'Pickup',
      price: '—',
      maxWeight: 'Max 1000 kg',
      capacityKg: 1000,
      arriving: 'ETA unavailable',
      image: '',
    );

    final bookingDetails = BookingDetailsModel(
      selectedVehicle: vehicle,
      category: 'Furniture',
      weightKg: 250,
      packages: 3,
      goodsValue: 15000,
    );

    viewModel = ReviewBookingViewModel(bookingDetails: bookingDetails);
  });

  tearDown(() {
    viewModel.dispose();
  });

  group('ReviewBookingViewModel Tests', () {
    test('Should display correct vehicle name', () {
      expect(viewModel.vehicleName, 'Pickup');
    });

    test('Should display correct goods details', () {
      expect(viewModel.goodsCategory, 'Furniture');
      expect(viewModel.goodsWeight, '250.0 kg');
      expect(viewModel.goodsPackages, '3');
      expect(viewModel.goodsValue, '₹15000');
    });

    test('Default payment method should be Cash', () {
      expect(viewModel.paymentMethod, 'Cash');
    });

    test('Should change payment method', () {
      viewModel.changePaymentMethod('UPI');

      expect(viewModel.paymentMethod, 'UPI');
    });

    test('Coupon should not be applied by default', () {
      expect(viewModel.couponApplied, false);
      expect(viewModel.couponDiscount, 0);
    });

    test('Should save GSTIN', () {
      viewModel.saveGstin('09ABCDE1234F1Z5');

      expect(viewModel.hasGstin, true);
      expect(viewModel.gstin, '09ABCDE1234F1Z5');
    });

    test('Should remove GSTIN', () {
      viewModel.saveGstin('09ABCDE1234F1Z5');
      viewModel.removeGstin();

      expect(viewModel.hasGstin, false);
      expect(viewModel.gstin, isNull);
    });

    test('Empty GSTIN should not be saved', () {
      viewModel.saveGstin('   ');

      expect(viewModel.hasGstin, false);
    });

    test('Should notify listeners when payment method changes', () {
      var notificationCount = 0;

      viewModel.addListener(() {
        notificationCount++;
      });

      viewModel.changePaymentMethod('UPI');

      expect(notificationCount, 1);

      // Same payment method should not trigger another notification.
      viewModel.changePaymentMethod('UPI');

      expect(notificationCount, 1);
    });
  });
}
