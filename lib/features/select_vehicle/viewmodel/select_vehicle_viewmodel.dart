import 'package:client_app/features/select_vehicle/repository/quote_repository.dart';
import 'package:flutter/foundation.dart';

import 'package:client_app/features/select_vehicle/view/model/vehicle_model.dart';
import 'package:client_app/features/select_vehicle/mappers/vehicle_type_mapper.dart';
import 'package:client_app/features/vehicle_types/repositories/vehicle_types_repository.dart';

class SelectVehicleViewModel extends ChangeNotifier {
  SelectVehicleViewModel({this.onProceed, VehicleTypesRepository? repository})
    : _repository = repository ?? VehicleTypesRepository();

  final void Function(VehicleModel selectedVehicle)? onProceed;
  final VehicleTypesRepository _repository;

  final QuoteRepository _quoteRepository = QuoteRepository();

Map<String, dynamic>? _quoteData;

Map<String, dynamic>? get quoteData => _quoteData;

bool _isQuoteLoading = false;

int _quoteRequestVersion = 0;

bool get isQuoteLoading => _isQuoteLoading;

String? _quoteError;

String? get quoteError => _quoteError;

Future<void> generateQuote({
  required String pickupAddress,
  required double pickupLatitude,
  required double pickupLongitude,
  required String dropAddress,
  required double dropLatitude,
  required double dropLongitude,
}) async {
  final vehicle = selectedVehicle;
  final requestVersion = ++_quoteRequestVersion;

  if (vehicle.id == null) {
    _quoteError = 'Vehicle type ID unavailable';
    notifyListeners();
    return;
  }

  _isQuoteLoading = true;
  _quoteError = null;
  _quoteData = null;
  notifyListeners();

  try {
    final result = await _quoteRepository.createQuote(
      vehicleTypeId: vehicle.id!,
      pickupAddress: pickupAddress,
      pickupLatitude: pickupLatitude,
      pickupLongitude: pickupLongitude,
      dropAddress: dropAddress,
      dropLatitude: dropLatitude,
      dropLongitude: dropLongitude,
    );

    // Ignore response if user selected another vehicle.
    if (requestVersion != _quoteRequestVersion) return;

    _quoteData = result;

    debugPrint('========== QUOTE GENERATED ==========');
    debugPrint('QUOTE ID: ${result['id']}');
    debugPrint('QUOTE PRICING: ${result['pricing']}');
  } catch (error) {
    if (requestVersion == _quoteRequestVersion) {
      _quoteError = error.toString();
      debugPrint('QUOTE ERROR: $error');
    }
  } finally {
    if (requestVersion == _quoteRequestVersion) {
      _isQuoteLoading = false;
      notifyListeners();
    }
  }
}
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

  // Purani quote invalidate karo
  _quoteRequestVersion++;

  _quoteData = null;
  _quoteError = null;
  _isQuoteLoading = false;

  notifyListeners();
}

  double? _parseNumber(dynamic value) {
  if (value == null) return null;
  return double.tryParse(value.toString());
}

double? get totalFare {
  final pricing = _quoteData?['pricing'];

  if (pricing is! Map) return null;

  return _parseNumber(pricing['total_fare']);
}

double? get estimatedDistanceKm {
  return _parseNumber(
    _quoteData?['estimated_distance_km'],
  );
}

double? get estimatedDurationMinutes {
  return _parseNumber(
    _quoteData?['estimated_duration_minutes'],
  );
}

String get fareText {
  final fare = totalFare;

  if (fare == null) return 'Fare unavailable';

  return '₹${fare.toStringAsFixed(2)}';
}

String get distanceText {
  final distance = estimatedDistanceKm;

  if (distance == null) return 'Distance unavailable';

  return '${distance.toStringAsFixed(1)} km';
}

String get etaText {
  final duration = estimatedDurationMinutes;

  if (duration == null) return 'ETA unavailable';

  final minutes = duration.round();

  if (minutes < 60) {
    return '$minutes min';
  }

  final hours = minutes ~/ 60;
  final remainingMinutes = minutes % 60;

  return remainingMinutes == 0
      ? '$hours hr'
      : '$hours hr $remainingMinutes min';
}

bool get canProceed {
  return !_isLoading &&
      !_isQuoteLoading &&
      _errorMessage == null &&
      _quoteError == null &&
      totalFare != null &&
      selectedVehicle.id != null;
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
Future<void> initializeWithQuote({
  required String pickupAddress,
  required double? pickupLatitude,
  required double? pickupLongitude,
  required String dropAddress,
  required double? dropLatitude,
  required double? dropLongitude,
}) async {
  await loadVehicles();

  if (_errorMessage != null || _vehicles.isEmpty) return;

  if (pickupLatitude == null ||
      pickupLongitude == null ||
      dropLatitude == null ||
      dropLongitude == null) {
    _quoteError = 'Pickup or drop coordinates are missing';
    notifyListeners();
    return;
  }

  await generateQuote(
    pickupAddress: pickupAddress,
    pickupLatitude: pickupLatitude,
    pickupLongitude: pickupLongitude,
    dropAddress: dropAddress,
    dropLatitude: dropLatitude,
    dropLongitude: dropLongitude,
  );
}


}
