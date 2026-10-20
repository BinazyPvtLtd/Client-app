import 'package:client_app/features/select_vehicle/mappers/vehicle_type_mapper.dart';
import 'package:client_app/features/vehicle_types/models/vehicle_type_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VehicleTypeMapper Tests', () {
    VehicleTypeModel createVehicle({
      String name = 'Two Wheeler',
      String? capacity,
    }) {
      return VehicleTypeModel(id: 1, name: name, capacity: capacity);
    }

    test('20 kg should convert to 20.0', () {
      final vehicle = VehicleTypeMapper.toUiModel(
        createVehicle(capacity: '20 kg'),
      );

      expect(vehicle.capacityKg, 20.0);
    });

    test('500 kg should convert to 500.0', () {
      final vehicle = VehicleTypeMapper.toUiModel(
        createVehicle(capacity: '500 kg'),
      );

      expect(vehicle.capacityKg, 500.0);
    });

    test('1.5 tonnes should convert to 1500.0', () {
      final vehicle = VehicleTypeMapper.toUiModel(
        createVehicle(capacity: '1.5 tonnes'),
      );

      expect(vehicle.capacityKg, 1500.0);
    });

    test('Missing capacity should return null', () {
      final vehicle = VehicleTypeMapper.toUiModel(createVehicle());

      expect(vehicle.capacityKg, isNull);
    });

    test('Invalid capacity should return null', () {
      final vehicle = VehicleTypeMapper.toUiModel(
        createVehicle(capacity: 'unknown'),
      );

      expect(vehicle.capacityKg, isNull);
    });

    test('Vehicle ID and name should remain unchanged', () {
      final vehicle = VehicleTypeMapper.toUiModel(
        createVehicle(name: 'Pickup', capacity: '1000 kg'),
      );

      expect(vehicle.id, 1);
      expect(vehicle.name, 'Pickup');
      expect(vehicle.capacityKg, 1000.0);
    });

    test('Zero capacity should be rejected', () {
      final vehicle = VehicleTypeMapper.toUiModel(
        createVehicle(capacity: '0 kg'),
      );

      expect(vehicle.capacityKg, isNull);
    });

    test('Negative capacity should be rejected', () {
      final vehicle = VehicleTypeMapper.toUiModel(
        createVehicle(capacity: '-20 kg'),
      );

      expect(vehicle.capacityKg, isNull);
    });
  });
}
