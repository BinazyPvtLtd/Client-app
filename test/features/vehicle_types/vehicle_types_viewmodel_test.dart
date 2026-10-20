import 'package:client_app/features/vehicle_types/viewmodels/vehicle_types_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('VehicleTypesViewModel', () {
    late VehicleTypesViewModel viewModel;

    setUp(() {
      viewModel = VehicleTypesViewModel();
    });

    tearDown(() {
      viewModel.dispose();
    });

    test('loads mock vehicles successfully', () async {
      await viewModel.loadVehicles();

      expect(viewModel.isLoading, false);
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.vehicles.length, 4);
      expect(viewModel.vehicles.first.name, 'Two Wheeler');
    });

    test('selects a valid vehicle', () async {
      await viewModel.loadVehicles();

      final vehicleId = viewModel.vehicles.first.id;

      viewModel.selectVehicle(vehicleId);

      expect(viewModel.selectedVehicleId, vehicleId);
    });

    test('ignores an invalid vehicle selection', () async {
      await viewModel.loadVehicles();

      viewModel.selectVehicle(-999);

      expect(viewModel.selectedVehicleId, isNull);
    });

    test('clears selected vehicle', () async {
      await viewModel.loadVehicles();

      viewModel.selectVehicle(viewModel.vehicles.first.id);
      viewModel.clearSelection();

      expect(viewModel.selectedVehicleId, isNull);
    });
  });
}
