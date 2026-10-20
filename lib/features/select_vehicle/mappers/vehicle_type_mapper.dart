import 'package:client_app/features/select_vehicle/view/model/vehicle_model.dart';
import 'package:client_app/features/vehicle_types/models/vehicle_type_model.dart';

class VehicleTypeMapper {
  VehicleTypeMapper._();

  static VehicleModel toUiModel(VehicleTypeModel type) {
    return VehicleModel(
      id: type.id,
      name: type.name,

      // Display capacity
      maxWeight: type.capacity == null
          ? 'Capacity unavailable'
          : 'Max ${type.capacity}',

      // Numeric capacity for validation
      capacityKg: _parseCapacityKg(type.capacity),

      image: _getLocalImage(type.name),

      // Temporary display placeholders.
      // Replace with actual quote/ETA API data later.
      price: '—',
      arriving: 'ETA unavailable',
    );
  }

  static List<VehicleModel> toUiModels(List<VehicleTypeModel> types) {
    return types.map(toUiModel).toList();
  }

  // Convert capacity string to kilograms

  static double? _parseCapacityKg(String? capacity) {
    if (capacity == null || capacity.trim().isEmpty) {
      return null;
    }

    final match = RegExp(
      r'^(\d+(?:\.\d+)?)\s*(kg|tonnes|tonne|tons|ton|t)$',
      caseSensitive: false,
    ).firstMatch(capacity.trim());

    if (match == null) {
      return null;
    }

    final value = double.tryParse(match.group(1)!);

    if (value == null || !value.isFinite || value <= 0) {
      return null;
    }

    final unit = match.group(2)!.toLowerCase();

    return unit == 'kg' ? value : value * 1000;
  }

  static String _getLocalImage(String name) {
    final normalized = name.toLowerCase();

    if (normalized.contains('two wheeler') ||
        normalized.contains('2 wheeler') ||
        normalized.contains('scooter') ||
        normalized.contains('bike')) {
      return 'assets/images/2_wheeler.png';
    }

    if (normalized.contains('three wheeler') ||
        normalized.contains('3w') ||
        normalized.contains('auto')) {
      return 'assets/images/mini_3w.png';
    }

    if (normalized.contains('loader')) {
      return 'assets/images/e_loader.png';
    }

    // Existing screen handles missing asset images
    // using its errorBuilder fallback icon.
    return 'assets/images/mini_3w.png';
  }
}
