import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/storage/token_storage.dart';
import '../../auth/services/laravel_auth_service.dart';
import '../../../custom_widget/main_navigation_screen.dart';

class OtpViewModel extends ChangeNotifier {
  final LaravelAuthService _authService = LaravelAuthService();

  String _otp = '';
  bool _isLoading = false;
  bool _canResend = false;
  int _resendSeconds = 30;

  Timer? _timer;

  String get otp => _otp;
  bool get isLoading => _isLoading;
  bool get canResend => _canResend;
  int get resendSeconds => _resendSeconds;

  OtpViewModel() {
    _startResendTimer();
  }

  void setOtp(String value) {
    _otp = value;
    notifyListeners();
  }

  Future<void> verifyOtp(
    BuildContext context, {
    required String phoneNumber,
  }) async {
    if (_otp.length != 6) {
      _showMessage(context, 'Enter a valid 6-digit OTP.');
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.verifyOtp(
        phone: phoneNumber,
        otp: _otp,
      );

      if (response is! Map || response['success'] != true) {
        throw Exception('OTP verification failed');
      }

      final data = response['data'];

      if (data is! Map) {
        throw Exception('Invalid authentication response');
      }

      // Confirm the exact token field in Postman.
      final token = data['token'];

      if (token is! String || token.isEmpty) {
        throw Exception(
          'OTP verified, but authentication token is missing.',
        );
      }

      await TokenStorage.saveToken(token);

      if (!context.mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const MainNavigationScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      if (context.mounted) {
        _showMessage(context, e.toString());
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resendOtp(
    BuildContext context, {
    required String phoneNumber,
  }) async {
    if (!_canResend || _isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.sendOtp(
        phone: phoneNumber,
      );

      if (response is! Map || response['success'] != true) {
        throw Exception('Failed to resend OTP');
      }

      _otp = '';
      _startResendTimer();

      if (context.mounted) {
        _showMessage(context, 'OTP sent successfully.');
      }
    } catch (e) {
      if (context.mounted) {
        _showMessage(context, e.toString());
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _startResendTimer() {
    _timer?.cancel();

    _canResend = false;
    _resendSeconds = 30;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_resendSeconds > 0) {
          _resendSeconds--;
        } else {
          _canResend = true;
          timer.cancel();
        }

        notifyListeners();
      },
    );

    notifyListeners();
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}