import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import 'package:client_app/core/network/api_config.dart';

class QuoteRepository {
  final Dio _dio = ApiClient().dio;

  Future<Map<String, dynamic>> createQuote({
    required int vehicleTypeId,
    required String pickupAddress,
    required double pickupLatitude,
    required double pickupLongitude,
    required String dropAddress,
    required double dropLatitude,
    required double dropLongitude,
    String? pickupLandmark,
    String? dropLandmark,
  }) async {
    try {
      debugPrintQuote('========== CREATE QUOTE API ==========');

      final requestBody = {
        'vehicle_type_id': vehicleTypeId,
        'pickup_address_line': pickupAddress,
        if (pickupLandmark != null && pickupLandmark.isNotEmpty)
          'pickup_landmark': pickupLandmark,
        'pickup_latitude': pickupLatitude,
        'pickup_longitude': pickupLongitude,
        'drop_address_line': dropAddress,
        if (dropLandmark != null && dropLandmark.isNotEmpty)
          'drop_landmark': dropLandmark,
        'drop_latitude': dropLatitude,
        'drop_longitude': dropLongitude,
      };

      debugPrintQuote('REQUEST: $requestBody');

      final response = await _dio.post(
  ApiConfig.quotes,
  data: requestBody,
);

      debugPrintQuote('STATUS CODE: ${response.statusCode}');
      debugPrintQuote('RESPONSE: ${response.data}');

      final body = Map<String, dynamic>.from(
        response.data as Map,
      );

      if (body['success'] != true) {
        throw Exception(
          body['message'] ?? 'Quote creation failed',
        );
      }

      final data = Map<String, dynamic>.from(
        body['data'] as Map,
      );

      debugPrintQuote('QUOTE ID: ${data['id']}');
      debugPrintQuote('STATUS: ${data['status']}');
      debugPrintQuote('PRICING: ${data['pricing']}');

      return data;
    } on DioException catch (error) {
      debugPrintQuote(
        'QUOTE API ERROR: ${error.response?.data}',
      );

      rethrow;
    }
  }
}

void debugPrintQuote(String message) {
  // Keep logs visible during development.
  assert(() {
    // ignore: avoid_print
    print(message);
    return true;
  }());
}