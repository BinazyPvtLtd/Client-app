import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/storage/token_storage.dart';
import 'laravel_auth_service.dart';

class LogoutService {
  final LaravelAuthService _authService = LaravelAuthService();

  Future<void> logout() async {
    try {
      debugPrint('🚪 Logout started');

      // 1. Revoke token on Laravel server.
      await _authService.logout();

      debugPrint('✅ Laravel logout successful');
    } catch (error) {
      debugPrint('⚠️ Logout API error: $error');

      // If the token is already invalid, local logout
      // should still proceed.
      //
      // For other errors, we also allow local logout.
      // The server token might remain valid until expiry.
    } finally {
      // 2. Always remove the local token.
      await TokenStorage.deleteToken();

      debugPrint('🗑️ Local authentication token deleted');
    }
  }
}