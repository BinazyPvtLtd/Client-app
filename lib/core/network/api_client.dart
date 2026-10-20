import 'package:dio/dio.dart';

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
}
