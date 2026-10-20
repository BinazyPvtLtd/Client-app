import 'package:dio/dio.dart';

class ApiException implements Exception {
  const ApiException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  factory ApiException.fromDio(DioException error) {
    final statusCode = error.response?.statusCode;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException(
          message: 'Connection timed out. Please try again.',
        );

      case DioExceptionType.connectionError:
        return const ApiException(
          message: 'Unable to connect. Please check your internet connection.',
        );

      case DioExceptionType.badCertificate:
        return const ApiException(message: 'Secure connection failed.');

      case DioExceptionType.cancel:
        return const ApiException(message: 'Request was cancelled.');

      default:
        break;
    }

    switch (statusCode) {
      case 400:
        return const ApiException(
          message: 'Invalid request. Please try again.',
          statusCode: 400,
        );

      case 401:
        return const ApiException(
          message: 'Your session has expired. Please log in again.',
          statusCode: 401,
        );

      case 403:
        return const ApiException(
          message: 'You do not have permission to perform this action.',
          statusCode: 403,
        );

      case 404:
        return const ApiException(
          message: 'Requested resource was not found.',
          statusCode: 404,
        );

      case 422:
        return const ApiException(
          message: 'Please check the information you entered.',
          statusCode: 422,
        );

      case 429:
        return const ApiException(
          message: 'Too many requests. Please try again later.',
          statusCode: 429,
        );

      case 500:
      case 502:
      case 503:
      case 504:
        return ApiException(
          message: 'Server is temporarily unavailable. Please try again.',
          statusCode: statusCode,
        );

      default:
        return ApiException(
          message: 'Something went wrong. Please try again.',
          statusCode: statusCode,
        );
    }
  }

  @override
  String toString() => message;
}
