import 'package:client_app/core/config/app_environment.dart';
import 'package:client_app/core/network/api_client.dart';
import 'package:client_app/core/network/api_config.dart';

import 'package:client_app/features/account/saved_addresses/data/models/address_api_model.dart';
import 'package:client_app/features/account/saved_addresses/data/models/create_address_request.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AddressesRepository {
  AddressesRepository({
    ApiClient? apiClient,
  }) : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  // =====================================================
  // MOCK DATA
  // =====================================================

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

  // =====================================================
  // RESPONSE VALIDATION
  // =====================================================

  Map<String, dynamic> _validateResponse(
    dynamic responseData,
    String operation,
  ) {
    if (responseData is! Map) {
      throw FormatException(
        'Invalid $operation response',
      );
    }

    final body = Map<String, dynamic>.from(
      responseData,
    );

    if (body['success'] != true) {
      throw Exception(
        body['message']?.toString() ??
            '$operation failed',
      );
    }

    return body;
  }

  // =====================================================
  // 1. GET ALL ADDRESSES
  // GET /addresses
  // =====================================================

  Future<List<AddressApiModel>> getAddresses() async {
    if (AppEnvironment.isMockMode) {
      debugPrint(
        'ADDRESS LIST: MOCK MODE',
      );

      return List.unmodifiable(_mockAddresses);
    }

    try {
      debugPrint(
        '========== GET ADDRESSES API ==========',
      );

      final response = await _apiClient.dio.get(
        ApiConfig.getAddresses,
      );

      debugPrint(
        'STATUS CODE: ${response.statusCode}',
      );

      debugPrint(
        'RESPONSE: ${response.data}',
      );

      final body = _validateResponse(
        response.data,
        'Get addresses',
      );

      final data = body['data'];

      if (data is! List) {
        throw const FormatException(
          'Expected addresses list',
        );
      }

      final addresses = data.map((item) {
        if (item is! Map) {
          throw const FormatException(
            'Invalid address item',
          );
        }

        return AddressApiModel.fromJson(
          Map<String, dynamic>.from(item),
        );
      }).toList();

      debugPrint(
        'TOTAL ADDRESSES: ${addresses.length}',
      );

      return addresses;
    } on DioException catch (error) {
      debugPrint(
        'GET ADDRESSES ERROR: ${error.response?.data}',
      );

      rethrow;
    }
  }

  // =====================================================
  // 2. CREATE ADDRESS
  // POST /addresses
  // =====================================================

  Future<AddressApiModel> createAddress(
    CreateAddressRequest request,
  ) async {
    if (AppEnvironment.isMockMode) {
      final address = AddressApiModel(
        id: 'mock_${_nextMockId++}',
        title: request.label,
        fullAddress: [
          request.addressLine,
          request.city,
          request.state,
          request.postalCode,
        ]
            .where(
              (value) => value.trim().isNotEmpty,
            )
            .join(', '),
      );

      _mockAddresses.add(address);

      debugPrint(
        'MOCK ADDRESS CREATED: ${address.id}',
      );

      return address;
    }

    final body = await createAddressApi(
      request.toJson(),
    );

    final data = body['data'];

    if (data is! Map) {
      throw const FormatException(
        'Expected created address object',
      );
    }

    return AddressApiModel.fromJson(
      Map<String, dynamic>.from(data),
    );
  }

  // =====================================================
  // CREATE ADDRESS API
  // =====================================================

  Future<Map<String, dynamic>> createAddressApi(
    Map<String, dynamic> payload,
  ) async {
    try {
      debugPrint(
        '========== CREATE ADDRESS API ==========',
      );

      debugPrint(
        'REQUEST: $payload',
      );

      final response = await _apiClient.dio.post(
        ApiConfig.createAddress,
        data: payload,
      );

      debugPrint(
        'STATUS CODE: ${response.statusCode}',
      );

      debugPrint(
        'RESPONSE: ${response.data}',
      );

      final body = _validateResponse(
        response.data,
        'Create address',
      );

      debugPrint(
        'ADDRESS CREATED SUCCESSFULLY',
      );

      return body;
    } on DioException catch (error) {
      debugPrint(
        'CREATE ADDRESS STATUS: '
        '${error.response?.statusCode}',
      );

      debugPrint(
        'CREATE ADDRESS ERROR: '
        '${error.response?.data}',
      );

      rethrow;
    }
  }

  // =====================================================
  // 3. GET SINGLE ADDRESS
  // GET /addresses/{id}
  // =====================================================

  Future<Map<String, dynamic>> getAddressById(
    String id,
  ) async {
    try {
      debugPrint(
        '========== GET ADDRESS BY ID ==========',
      );

      debugPrint(
        'ADDRESS ID: $id',
      );

      final response = await _apiClient.dio.get(
        ApiConfig.getAddressById(id),
      );

      debugPrint(
        'STATUS CODE: ${response.statusCode}',
      );

      debugPrint(
        'RESPONSE: ${response.data}',
      );

      final body = _validateResponse(
        response.data,
        'Get address',
      );

      return body;
    } on DioException catch (error) {
      debugPrint(
        'GET ADDRESS ERROR: ${error.response?.data}',
      );

      rethrow;
    }
  }

  // =====================================================
  // 4. UPDATE ADDRESS
  // PATCH /addresses/{id}
  // =====================================================

  Future<Map<String, dynamic>> updateAddressApi({
    required String id,
    required Map<String, dynamic> payload,
  }) async {
    try {
      debugPrint(
        '========== UPDATE ADDRESS API ==========',
      );

      debugPrint(
        'ADDRESS ID: $id',
      );

      debugPrint(
        'REQUEST: $payload',
      );

      final response = await _apiClient.dio.patch(
        ApiConfig.updateAddress(id),
        data: payload,
      );

      debugPrint(
        'STATUS CODE: ${response.statusCode}',
      );

      debugPrint(
        'RESPONSE: ${response.data}',
      );

      final body = _validateResponse(
        response.data,
        'Update address',
      );

      debugPrint(
        'ADDRESS UPDATED SUCCESSFULLY',
      );

      return body;
    } on DioException catch (error) {
      debugPrint(
        'UPDATE ADDRESS STATUS: '
        '${error.response?.statusCode}',
      );

      debugPrint(
        'UPDATE ADDRESS ERROR: '
        '${error.response?.data}',
      );

      rethrow;
    }
  }

  // =====================================================
  // 5. DELETE ADDRESS
  // DELETE /addresses/{id}
  // =====================================================

  Future<void> deleteAddressApi(
    String id,
  ) async {
    if (AppEnvironment.isMockMode) {
      _mockAddresses.removeWhere(
        (address) => address.id == id,
      );

      debugPrint(
        'MOCK ADDRESS DELETED: $id',
      );

      return;
    }

    try {
      debugPrint(
        '========== DELETE ADDRESS API ==========',
      );

      debugPrint(
        'ADDRESS ID: $id',
      );

      final response = await _apiClient.dio.delete(
        ApiConfig.deleteAddress(id),
      );

      debugPrint(
        'STATUS CODE: ${response.statusCode}',
      );

      debugPrint(
        'RESPONSE: ${response.data}',
      );

      // HTTP 204 means successful deletion
      // with no response body.
      if (response.statusCode == 204) {
        debugPrint(
          'ADDRESS DELETED SUCCESSFULLY',
        );

        return;
      }

      if (response.data is Map) {
        _validateResponse(
          response.data,
          'Delete address',
        );
      } else if (response.data != null &&
          response.data.toString().isNotEmpty) {
        throw const FormatException(
          'Unexpected delete response',
        );
      }

      debugPrint(
        'ADDRESS DELETED SUCCESSFULLY',
      );
    } on DioException catch (error) {
      debugPrint(
        'DELETE ADDRESS STATUS: '
        '${error.response?.statusCode}',
      );

      debugPrint(
        'DELETE ADDRESS ERROR: '
        '${error.response?.data}',
      );

      rethrow;
    }
  }
  
}