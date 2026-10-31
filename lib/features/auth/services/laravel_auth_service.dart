import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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
      _logApiResponse('SEND OTP RESPONSE', response.data);

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
      _logApiResponse('VERIFY OTP RESPONSE', response.data);
      
      return response.data;
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  Future<dynamic> getCurrentUser() async {
    try {
      final response = await _apiClient.dio.get(ApiConfig.me);
      _logApiResponse('CURRENT USER RESPONSE', response.data);
      return response.data;
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  Future<void> logout() async {
  try {
    final response = await _apiClient.dio.post(
      ApiConfig.logout,
    );

    _logApiResponse('LOGOUT RESPONSE', response.data);

    final data = response.data;

    if (data is! Map || data['success'] != true) {
      throw Exception('Logout failed');
    }
  } on DioException catch (error) {
    throw ApiException.fromDio(error);
  }
}

void _logApiResponse(String apiName, dynamic response) {
  if (!kDebugMode) return;

  final safeResponse = _redactSensitiveData(response);

  final formattedResponse = const JsonEncoder.withIndent('  ')
      .convert(safeResponse);

  debugPrint('========== $apiName ==========');
  debugPrint(formattedResponse);
  debugPrint('================================');
}

dynamic _redactSensitiveData(dynamic value) {
  if (value is List) {
    return value.map(_redactSensitiveData).toList();
  }

  if (value is Map) {
    return value.map((key, item) {
      final field = key.toString().toLowerCase();

      if (field.contains('token') ||
          field.contains('secret') ||
          field.contains('password') ||
          field == 'otp' ||
          field == 'authorization' ||
          field == 'cookie') {
        return MapEntry(key, '[REDACTED]');
      }

      if (field == 'mobile_number' || field == 'phone') {
        return MapEntry(key, '[REDACTED]');
      }

      return MapEntry(key, _redactSensitiveData(item));
    });
  }

  return value;
}

}
