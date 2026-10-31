import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/storage/token_storage.dart';
import '../../auth/services/laravel_auth_service.dart';

class SplashViewModel extends ChangeNotifier {
  final LaravelAuthService _authService = LaravelAuthService();

  Timer? _navigationTimer;

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  void initialize({
    required void Function(bool isLoggedIn) onComplete,
  }) {
    if (_isInitialized) return;

    _isInitialized = true;

    _navigationTimer = Timer(
      const Duration(seconds: 3),
      () async {
        bool isLoggedIn = false;

        try {
          final token = await TokenStorage.getToken();

          if (token != null && token.isNotEmpty) {
            final response = await _authService.getCurrentUser();

            isLoggedIn = response is Map &&
                response['success'] == true;
          }
        } catch (e) {
          debugPrint('Session check failed: $e');

          // Do not delete the token here.
          // Temporary network errors must not log users out.
        }

        onComplete(isLoggedIn);
      },
    );
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }
}