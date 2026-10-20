import 'package:client_app/core/network/api_client.dart';
import 'package:client_app/features/auth/services/laravel_auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Laravel send OTP request uses correct endpoint and body', () async {
    final client = ApiClient(tokenReader: () async => null);

    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          expect(options.method, 'POST');
          expect(options.path, '/auth/send-otp');
          expect(options.data, {'mobile_number': '9999999999'});

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

    final service = LaravelAuthService(apiClient: client);

    try {
      final result = await service.sendOtp(phone: '9999999999');

      expect(result['success'], true);
    } finally {
      client.dio.close();
    }
  });

  test('Laravel verify OTP request uses correct endpoint and body', () async {
    final client = ApiClient(tokenReader: () async => null);

    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          expect(options.method, 'POST');
          expect(options.path, '/auth/verify-otp');
          expect(options.data, {
            'mobile_number': '9999999999',
            'otp': '123456',
          });

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

    final service = LaravelAuthService(apiClient: client);

    try {
      final result = await service.verifyOtp(
        phone: '9999999999',
        otp: '123456',
      );

      expect(result['success'], true);
    } finally {
      client.dio.close();
    }
  });
}
