// import 'package:dio/dio.dart';

// import '../storage/token_storage.dart';
// import 'api_config.dart';

// typedef TokenReader = Future<String?> Function();

// class ApiClient {
//   ApiClient({TokenReader? tokenReader})
//     : _tokenReader = tokenReader ?? TokenStorage.getToken,
//       dio = Dio(
//         BaseOptions(
//           baseUrl: ApiConfig.baseUrl,
//           connectTimeout: const Duration(seconds: 15),
//           receiveTimeout: const Duration(seconds: 15),
//           headers: {
//             'Accept': 'application/json',
//             'Content-Type': 'application/json',
//           },
//         ),
//       ) {
//     dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           try {
//             final token = await _tokenReader();

//             if (token != null && token.isNotEmpty) {
//               options.headers['Authorization'] = 'Bearer $token';
//             }

//             handler.next(options);
//           } catch (error, stackTrace) {
//             handler.reject(
//               DioException(
//                 requestOptions: options,
//                 error: error,
//                 stackTrace: stackTrace,
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   final Dio dio;
//   final TokenReader _tokenReader;

//   Future<Response<dynamic>> healthCheck() async {
//     return dio.get(ApiConfig.health);
//   }

//   Future<Response<dynamic>> getVehicleTypes() async {
//     return dio.get(ApiConfig.vehicleTypes);
//   }
// }


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../storage/token_storage.dart';
import 'api_config.dart';

typedef TokenReader = Future<String?> Function();

class ApiClient {
  ApiClient({TokenReader? tokenReader})
      : _tokenReader = tokenReader ?? TokenStorage.getToken,
        dio = Dio(
          BaseOptions(
            baseUrl: ApiConfig.baseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          ),
        ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final token = await _tokenReader();

            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }

            if (kDebugMode) {
              debugPrint('================================');
              debugPrint('🚀 API REQUEST');
              debugPrint('METHOD: ${options.method}');
              debugPrint('URL: ${options.uri}');
              debugPrint(
                'BODY: ${_format(_redact(options.data))}',
              );
              debugPrint('================================');
            }

            handler.next(options);
          } catch (error, stackTrace) {
            handler.reject(
              DioException(
                requestOptions: options,
                error: error,
                stackTrace: stackTrace,
              ),
            );
          }
        },

        onResponse: (response, handler) {
          if (kDebugMode) {
            debugPrint('================================');
            debugPrint('✅ API RESPONSE');
            debugPrint(
              'STATUS: ${response.statusCode}',
            );
            debugPrint(
              'URL: ${response.requestOptions.uri}',
            );
            debugPrint(
              'RESPONSE: ${_format(_redact(response.data))}',
            );
            debugPrint('================================');
          }

          handler.next(response);
        },

        onError: (error, handler) {
          if (kDebugMode) {
            debugPrint('================================');
            debugPrint('❌ API ERROR');
            debugPrint(
              'METHOD: ${error.requestOptions.method}',
            );
            debugPrint(
              'URL: ${error.requestOptions.uri}',
            );
            debugPrint(
              'STATUS: ${error.response?.statusCode}',
            );
            debugPrint(
              'RESPONSE: ${_format(_redact(error.response?.data))}',
            );
            debugPrint('================================');
          }

          handler.next(error);
        },
      ),
    );
  }

  final Dio dio;
  final TokenReader _tokenReader;

  Future<Response<dynamic>> healthCheck() async {
    return dio.get(ApiConfig.health);
  }

  Future<Response<dynamic>> getVehicleTypes() async {
    return dio.get(ApiConfig.vehicleTypes);
  }

  static String _format(dynamic value) {
    try {
      return const JsonEncoder.withIndent('  ').convert(value);
    } catch (_) {
      return '[Unable to format response]';
    }
  }

  static dynamic _redact(dynamic value) {
    if (value is List) {
      return value.map(_redact).toList();
    }

    if (value is Map) {
      return value.map((key, item) {
        final field = key.toString().toLowerCase();

        const sensitiveFields = {
          'otp',
          'token',
          'access_token',
          'refresh_token',
          'authorization',
          'password',
          'mobile_number',
          'phone',
          'phone_number',
          'email',
          'address',
          'cookie',
          'secret',
        };

        if (sensitiveFields.contains(field) ||
            field.contains('token') ||
            field.contains('secret')) {
          return MapEntry(key, '[REDACTED]');
        }

        return MapEntry(key, _redact(item));
      });
    }

    return value;
  }
}