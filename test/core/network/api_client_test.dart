import 'package:flutter_test/flutter_test.dart';
import 'package:client_app/core/network/api_client.dart';

void main() {
  test('Patgolito Laravel health API', () async {
    final client = ApiClient(tokenReader: () async => null);

    try {
      final response = await client.healthCheck();

      expect(response.statusCode, 200);
      expect(response.data['success'], true);
    } finally {
      client.dio.close();
    }
  });
}
