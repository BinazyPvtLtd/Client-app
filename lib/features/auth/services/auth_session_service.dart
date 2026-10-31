import '../../../core/storage/token_storage.dart';
import '../services/laravel_auth_service.dart';

class AuthSessionService {
  final LaravelAuthService _authService = LaravelAuthService();

  Future<bool> isLoggedIn() async {
    final token = await TokenStorage.getToken();

    if (token == null || token.isEmpty) {
      return false;
    }

    try {
      final response = await _authService.getCurrentUser();

      return response is Map &&
          response['success'] == true;
    } catch (_) {
      // A network failure doesn't necessarily mean
      // the token has expired.
      return false;
    }
  }
}