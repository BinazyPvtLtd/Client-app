import 'package:client_app/core/config/app_environment.dart';
import 'package:client_app/core/network/api_client.dart';
import 'package:client_app/features/vehicle_types/models/vehicle_type_model.dart';

class VehicleTypesRepository {
  VehicleTypesRepository({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  Future<List<VehicleTypeModel>> getVehicleTypes() async {
    if (AppEnvironment.isMockMode) {
      return _getMockVehicleTypes();
    }

    final response = await _apiClient.getVehicleTypes();

    final responseData = response.data;

    if (responseData is! Map<String, dynamic>) {
      throw const FormatException('Invalid vehicle types response');
    }

    final data = responseData['data'];

    if (data is! List) {
      throw const FormatException('Expected vehicle types list');
    }

    return data.map((item) {
      if (item is! Map) {
        throw const FormatException('Invalid vehicle type item');
      }

      return VehicleTypeModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();
  }

  List<VehicleTypeModel> _getMockVehicleTypes() {
    return const [
      VehicleTypeModel(
        id: 1,
        name: 'Two Wheeler',
        description: 'Small parcels and documents',
        capacity: '20 kg',
      ),
      VehicleTypeModel(
        id: 2,
        name: 'Three Wheeler',
        description: 'Small goods transportation',
        capacity: '500 kg',
      ),
      VehicleTypeModel(
        id: 3,
        name: 'Pickup',
        description: 'Medium-sized goods transportation',
        capacity: '1000 kg',
      ),
      VehicleTypeModel(
        id: 4,
        name: 'Mini Truck',
        description: 'Large goods transportation',
        capacity: '1500 kg',
      ),
    ];
  }
}
