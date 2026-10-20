import 'package:flutter/foundation.dart';

import 'package:client_app/features/select_vehicle/view/model/vehicle_model.dart';
import 'package:client_app/features/select_vehicle/mappers/vehicle_type_mapper.dart';
import 'package:client_app/features/vehicle_types/repositories/vehicle_types_repository.dart';

class SelectVehicleViewModel extends ChangeNotifier {
  SelectVehicleViewModel({this.onProceed, VehicleTypesRepository? repository})
    : _repository = repository ?? VehicleTypesRepository();

  final void Function(VehicleModel selectedVehicle)? onProceed;
  final VehicleTypesRepository _repository;

  // Existing UI data remains available until loading succeeds.
  List<VehicleModel> _vehicles = const [
    VehicleModel(
      name: '2 Wheeler',
      price: '₹149',
      maxWeight: 'Max 20 kg',
      arriving: 'Arriving in 4 mins',
      image: 'assets/images/2_wheeler.png',
      offer: '₹15 OFF',
    ),
    VehicleModel(
      name: 'Scooter',
      price: '₹165',
      maxWeight: 'Max 20 kg',
      arriving: 'Arriving in 6 mins',
      image: 'assets/images/2_wheeler.png',
    ),
    VehicleModel(
      name: 'Mini 3W',
      price: '₹249',
      maxWeight: 'Max 90 kg',
      arriving: 'Arriving in 8 mins',
      image: 'assets/images/mini_3w.png',
    ),
    VehicleModel(
      name: 'E Loader',
      price: '₹399',
      maxWeight: 'Max 300 kg',
      arriving: 'Arriving in 12 mins',
      image: 'assets/images/e_loader.png',
    ),
  ];

  List<VehicleModel> get vehicles => List.unmodifiable(_vehicles);

  int _selectedVehicleIndex = 0;
  int get selectedVehicleIndex => _selectedVehicleIndex;

  VehicleModel get selectedVehicle => _vehicles[_selectedVehicleIndex];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadVehicles() async {
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final vehicleTypes = await _repository.getVehicleTypes();

      final mappedVehicles = VehicleTypeMapper.toUiModels(vehicleTypes);

      if (mappedVehicles.isEmpty) {
        throw StateError('No vehicles available');
      }

      _vehicles = mappedVehicles;
      _selectedVehicleIndex = 0;
    } catch (error) {
      _errorMessage = error.toString();
      // Preserve existing vehicles if loading fails.
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectVehicle(int index) {
    if (index < 0 || index >= _vehicles.length) return;
    if (_selectedVehicleIndex == index) return;

    _selectedVehicleIndex = index;
    notifyListeners();
  }

  void addStop() {
    debugPrint('Add stop tapped');
  }

  void editLocation() {
    debugPrint('Edit location tapped');
  }

  void proceedWithVehicle() {
    if (_isLoading || _errorMessage != null) return;

    final vehicle = selectedVehicle;

    debugPrint('Proceeding with: ${vehicle.name}');
    onProceed?.call(vehicle);
  }
}
