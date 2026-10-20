import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:client_app/core/network/api_client.dart';

void main() {
  test('Bearer token is attached to API requests', () async {
    final client = ApiClient(tokenReader: () async => 'test_token_123');

    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          expect(options.headers['Authorization'], 'Bearer test_token_123');

          handler.resolve(
            Response(
              requestOptions: options,
              statusCode: 200,
              data: {'success': true},
            ),
          );
        },
      ),
    );

    try {
      final response = await client.getVehicleTypes();

      expect(response.statusCode, 200);
      expect(response.data['success'], true);
    } finally {
      client.dio.close();
    }
  });
}
