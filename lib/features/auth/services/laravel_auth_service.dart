import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';

class LaravelAuthService {
  LaravelAuthService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  Future<dynamic> sendOtp({required String phone}) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConfig.sendOtp,
        data: {'mobile_number': phone},
      );
      return response.data;
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  Future<dynamic> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConfig.verifyOtp,
        data: {'mobile_number': phone, 'otp': otp},
      );
      return response.data;
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  Future<dynamic> getCurrentUser() async {
    try {
      final response = await _apiClient.dio.get(ApiConfig.me);
      return response.data;
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }
}
