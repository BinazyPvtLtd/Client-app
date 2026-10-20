import 'package:client_app/core/network/api_client.dart';
import 'package:client_app/core/network/api_exception.dart';
import 'package:client_app/features/auth/services/laravel_auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('GET /auth/me attaches bearer token', () async {
    final client = ApiClient(tokenReader: () async => 'test_token_123');

    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          expect(options.method, 'GET');
          expect(options.path, '/auth/me');
          expect(options.headers['Authorization'], 'Bearer test_token_123');

          handler.resolve(
            Response(
              requestOptions: options,
              statusCode: 200,
              data: {
                'success': true,
                'data': {'id': 1},
              },
            ),
          );
        },
      ),
    );

    try {
      final service = LaravelAuthService(apiClient: client);
      final result = await service.getCurrentUser();

      expect(result['success'], true);
    } finally {
      client.dio.close();
    }
  });

  test('401 response maps to ApiException', () async {
    final client = ApiClient(tokenReader: () async => 'expired_test_token');

    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.reject(
            DioException(
              requestOptions: options,
              response: Response(
                requestOptions: options,
                statusCode: 401,
                data: {'message': 'Unauthenticated.'},
              ),
              type: DioExceptionType.badResponse,
            ),
          );
        },
      ),
    );

    try {
      final service = LaravelAuthService(apiClient: client);

      await expectLater(
        service.getCurrentUser(),
        throwsA(
          isA<ApiException>().having(
            (error) => error.statusCode,
            'statusCode',
            401,
          ),
        ),
      );
    } finally {
      client.dio.close();
    }
  });
}
