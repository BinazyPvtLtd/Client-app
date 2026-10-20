import 'package:flutter/foundation.dart';

import 'package:client_app/features/vehicle_types/models/vehicle_type_model.dart';
import 'package:client_app/features/vehicle_types/repositories/vehicle_types_repository.dart';

class VehicleTypesViewModel extends ChangeNotifier {
  VehicleTypesViewModel({VehicleTypesRepository? repository})
    : _repository = repository ?? VehicleTypesRepository();

  final VehicleTypesRepository _repository;

  List<VehicleTypeModel> _vehicles = [];
  bool _isLoading = false;
  String? _errorMessage;
  int? _selectedVehicleId;

  List<VehicleTypeModel> get vehicles => List.unmodifiable(_vehicles);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int? get selectedVehicleId => _selectedVehicleId;

  Future<void> loadVehicles() async {
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _repository.getVehicleTypes();
      _vehicles = result;

      if (_selectedVehicleId != null &&
          !_vehicles.any((vehicle) => vehicle.id == _selectedVehicleId)) {
        _selectedVehicleId = null;
      }
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectVehicle(int vehicleId) {
    if (!_vehicles.any((vehicle) => vehicle.id == vehicleId)) {
      return;
    }

    if (_selectedVehicleId == vehicleId) return;

    _selectedVehicleId = vehicleId;
    notifyListeners();
  }

  void clearSelection() {
    if (_selectedVehicleId == null) return;

    _selectedVehicleId = null;
    notifyListeners();
  }
}
