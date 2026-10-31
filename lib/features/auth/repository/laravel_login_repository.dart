import '../../../core/storage/token_storage.dart';
import '../services/laravel_auth_service.dart';

class LaravelLoginRepository {
  final LaravelAuthService _authService = LaravelAuthService();

  Future<void> verifyAndLogin({
    required String phone,
    required String otp,
  }) async {
    final response = await _authService.verifyOtp(
      phone: phone,
      otp: otp,
    );

    if (response is! Map ||
        response['success'] != true) {
      throw Exception('OTP verification failed');
    }

    // Confirm the token location from the complete API response.
    final data = response['data'];

    if (data is! Map) {
      throw Exception('Invalid authentication response');
    }

    final token = data['token'];

    if (token is! String || token.isEmpty) {
      throw Exception('Authentication token missing');
    }

    await TokenStorage.saveToken(token);
  }
}