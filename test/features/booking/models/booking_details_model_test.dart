import 'package:client_app/features/booking/models/booking_details_model.dart';
import 'package:client_app/features/select_vehicle/view/model/vehicle_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BookingDetailsModel Tests', () {
    late VehicleModel selectedVehicle;

    setUp(() {
      selectedVehicle = VehicleModel(
        id: 3,
        name: 'Pickup',
        price: '—',
        maxWeight: 'Max 1000 kg',
        capacityKg: 1000,
        arriving: 'ETA unavailable',
        image: '',
      );
    });

    test('Should preserve selected vehicle information', () {
      final booking = BookingDetailsModel(
        selectedVehicle: selectedVehicle,
        category: 'Furniture',
        weightKg: 250,
        packages: 3,
        goodsValue: 15000,
      );

      expect(booking.vehicleTypeId, 3);
      expect(booking.vehicleName, 'Pickup');
      expect(booking.selectedVehicle.capacityKg, 1000);
    });

    test('Should preserve goods details', () {
      final booking = BookingDetailsModel(
        selectedVehicle: selectedVehicle,
        category: 'Electronics',
        weightKg: 50.5,
        packages: 2,
        goodsValue: 25000,
      );

      expect(booking.category, 'Electronics');
      expect(booking.weightKg, 50.5);
      expect(booking.packages, 2);
      expect(booking.goodsValue, 25000);
    });

    test('Should preserve decimal weight and goods value', () {
      final booking = BookingDetailsModel(
        selectedVehicle: selectedVehicle,
        category: 'Grocery',
        weightKg: 12.75,
        packages: 4,
        goodsValue: 1999.50,
      );

      expect(booking.weightKg, 12.75);
      expect(booking.goodsValue, 1999.50);
    });
  });
}
