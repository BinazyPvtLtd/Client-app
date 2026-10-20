import 'package:client_app/core/config/app_environment.dart';
import 'package:client_app/core/network/api_client.dart';
import 'package:client_app/core/network/api_config.dart';
import 'package:client_app/features/account/saved_addresses/data/models/address_api_model.dart';
import 'package:client_app/features/account/saved_addresses/data/models/create_address_request.dart';

class AddressesRepository {
  AddressesRepository({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  // Shared mock data across repository instances.
  // In-memory only: resets when the app restarts.
  static final List<AddressApiModel> _mockAddresses = [
    const AddressApiModel(
      id: 'home',
      title: 'Home',
      fullAddress: 'Lucknow, Uttar Pradesh',
    ),
    const AddressApiModel(
      id: 'work',
      title: 'Work',
      fullAddress: 'Gomti Nagar, Lucknow, Uttar Pradesh',
    ),
    const AddressApiModel(
      id: 'other',
      title: 'Other',
      fullAddress: 'Hazratganj, Lucknow, Uttar Pradesh',
    ),
  ];

  static int _nextMockId = 1;

  Future<List<AddressApiModel>> getAddresses() async {
    if (AppEnvironment.isMockMode) {
      return List.unmodifiable(_mockAddresses);
    }

    final response = await _apiClient.dio.get(ApiConfig.addresses);

    final responseData = response.data;

    if (responseData is! Map<String, dynamic>) {
      throw const FormatException('Invalid addresses response');
    }

    if (responseData['success'] == false) {
      throw const FormatException('Addresses request was unsuccessful');
    }

    final data = responseData['data'];

    if (data is! List) {
      throw const FormatException('Expected addresses list');
    }

    return data.map((item) {
      if (item is! Map) {
        throw const FormatException('Invalid address item');
      }

      return AddressApiModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();
  }

  Future<AddressApiModel> createAddress(CreateAddressRequest request) async {
    if (AppEnvironment.isMockMode) {
      final address = AddressApiModel(
        id: 'mock_${_nextMockId++}',
        title: request.label,
        fullAddress: [
          request.addressLine,
          request.city,
          request.state,
          request.postalCode,
        ].where((value) => value.trim().isNotEmpty).join(', '),
      );

      _mockAddresses.add(address);

      return address;
    }

    // Real POST /addresses is intentionally disabled until
    // the Laravel validation and response contract are verified.
    throw UnsupportedError('Real address creation is not configured yet.');
  }
}
