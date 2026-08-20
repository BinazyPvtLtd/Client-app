import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _otp = '';

  bool _isLoading = false;

  bool _canResend = false;

  int _resendSeconds = 30;

  Timer? _timer;

  String? _verificationId;

  int? _resendToken;

  String get otp => _otp;

  bool get isLoading => _isLoading;

  bool get canResend => _canResend;

  int get resendSeconds => _resendSeconds;

  String? get verificationId => _verificationId;

  // =========================================================
  // SET OTP
  // =========================================================

  void setOtp(String value) {
    _otp = value;
    notifyListeners();
  }

  // =========================================================
  // SET VERIFICATION ID
  // =========================================================

  void setVerificationId(String verificationId) {
    _verificationId = verificationId;
  }

  // =========================================================
  // START RESEND TIMER
  // =========================================================

  void startResendTimer() {
    _timer?.cancel();

    _canResend = false;
    _resendSeconds = 30;

    notifyListeners();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_resendSeconds > 0) {
          _resendSeconds--;

          notifyListeners();
        } else {
          _canResend = true;

          timer.cancel();

          notifyListeners();
        }
      },
    );
  }

  // =========================================================
  // VERIFY OTP
  // =========================================================

  Future<void> verifyOtp(
    BuildContext context, {
    required String phoneNumber,
  }) async {
    if (_otp.length != 6) {
      _showMessage(
        context,
        'Please enter the complete 6-digit OTP.',
      );
      return;
    }

    if (_verificationId == null ||
        _verificationId!.isEmpty) {
      _showMessage(
        context,
        'OTP session expired. Please request a new OTP.',
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      debugPrint('========================================');
      debugPrint('🔐 FIREBASE OTP VERIFICATION STARTED');
      debugPrint('PHONE: $phoneNumber');
      debugPrint('OTP: $_otp');
      debugPrint('VERIFICATION ID EXISTS: true');
      debugPrint('========================================');

      // =======================================================
      // CREATE FIREBASE CREDENTIAL
      // =======================================================

      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _otp,
      );

      // =======================================================
      // SIGN IN WITH FIREBASE
      // =======================================================

      final UserCredential userCredential =
          await _auth.signInWithCredential(
        credential,
      );

      debugPrint('========================================');
      debugPrint('✅ OTP VERIFIED SUCCESSFULLY');
      debugPrint(
        'FIREBASE UID: ${userCredential.user?.uid}',
      );
      debugPrint(
        'PHONE: ${userCredential.user?.phoneNumber}',
      );
      debugPrint('========================================');

      _isLoading = false;
      notifyListeners();

      if (!context.mounted) return;

      _showMessage(
        context,
        'OTP verified successfully.',
      );

      // =======================================================
      // TODO:
      // Navigate to your next screen here.
      // =======================================================

      // Example:
      //
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) => const HomeScreen(),
      //   ),
      // );
    } on FirebaseAuthException catch (e) {
      debugPrint('========================================');
      debugPrint('❌ OTP VERIFICATION FAILED');
      debugPrint('CODE: ${e.code}');
      debugPrint('MESSAGE: ${e.message}');
      debugPrint('========================================');

      _isLoading = false;
      notifyListeners();

      if (!context.mounted) return;

      _showMessage(
        context,
        _firebaseErrorMessage(e),
      );
    } catch (e) {
      debugPrint(
        '❌ OTP VERIFICATION EXCEPTION: $e',
      );

      _isLoading = false;
      notifyListeners();

      if (!context.mounted) return;

      _showMessage(
        context,
        'Something went wrong. Please try again.',
      );
    }
  }

  // =========================================================
  // RESEND OTP
  // =========================================================

  Future<void> resendOtp(
    BuildContext context, {
    required String phoneNumber,
  }) async {
    if (!_canResend) {
      return;
    }

    _isLoading = true;
    _canResend = false;

    notifyListeners();

    debugPrint('========================================');
    debugPrint('🔄 RESENDING FIREBASE OTP');
    debugPrint('PHONE: $phoneNumber');
    debugPrint('========================================');

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,

        // =====================================================
        // AUTOMATIC VERIFICATION
        // =====================================================

        verificationCompleted:
            (PhoneAuthCredential credential) async {
          debugPrint(
            '✅ RESEND AUTO VERIFICATION COMPLETED',
          );

          try {
            await _auth.signInWithCredential(
              credential,
            );

            debugPrint(
              '✅ USER SIGNED IN AUTOMATICALLY',
            );
          } catch (e) {
            debugPrint(
              '❌ AUTO SIGN-IN ERROR: $e',
            );
          }
        },

        // =====================================================
        // VERIFICATION FAILED
        // =====================================================

        verificationFailed:
            (FirebaseAuthException e) {
          debugPrint(
            '❌ RESEND OTP FAILED',
          );

          debugPrint(
            'CODE: ${e.code}',
          );

          debugPrint(
            'MESSAGE: ${e.message}',
          );

          _isLoading = false;
          _canResend = true;

          notifyListeners();

          if (!context.mounted) return;

          _showMessage(
            context,
            _firebaseErrorMessage(e),
          );
        },

        // =====================================================
        // OTP SENT
        // =====================================================

        codeSent: (
          String verificationId,
          int? resendToken,
        ) {
          debugPrint(
            '✅ NEW OTP SENT',
          );

          debugPrint(
            'NEW VERIFICATION ID RECEIVED',
          );

          _verificationId = verificationId;

          _resendToken = resendToken;

          _isLoading = false;

          _startResendTimer();

          notifyListeners();

          if (!context.mounted) return;

          _showMessage(
            context,
            'A new OTP has been sent.',
          );
        },

        // =====================================================
        // TIMEOUT
        // =====================================================

        codeAutoRetrievalTimeout:
            (String verificationId) {
          debugPrint(
            '⏱️ RESEND AUTO RETRIEVAL TIMEOUT',
          );

          _verificationId = verificationId;
        },

        // =====================================================
        // RESEND TOKEN
        // =====================================================

        forceResendingToken: _resendToken,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(
        '❌ RESEND FIREBASE ERROR: ${e.code}',
      );

      _isLoading = false;
      _canResend = true;

      notifyListeners();

      if (!context.mounted) return;

      _showMessage(
        context,
        _firebaseErrorMessage(e),
      );
    } catch (e) {
      debugPrint(
        '❌ RESEND OTP EXCEPTION: $e',
      );

      _isLoading = false;
      _canResend = true;

      notifyListeners();

      if (!context.mounted) return;

      _showMessage(
        context,
        'Unable to resend OTP. Please try again.',
      );
    }
  }

  // =========================================================
  // FIREBASE ERROR MESSAGE
  // =========================================================

  String _firebaseErrorMessage(
    FirebaseAuthException e,
  ) {
    switch (e.code) {
      case 'invalid-verification-code':
        return 'The OTP you entered is incorrect.';

      case 'session-expired':
        return 'The OTP has expired. Please request a new OTP.';

      case 'invalid-verification-id':
        return 'The verification session is invalid. Please request a new OTP.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      case 'invalid-phone-number':
        return 'The phone number is invalid.';

      case 'quota-exceeded':
        return 'SMS quota exceeded. Please try again later.';

      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';

      default:
        return e.message ?? 'OTP verification failed.';
    }
  }

  // =========================================================
  // SHOW MESSAGE
  // =========================================================

  void _showMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }

  // =========================================================
  // TIMER
  // =========================================================

  void _startResendTimer() {
    _timer?.cancel();

    _canResend = false;
    _resendSeconds = 30;

    notifyListeners();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_resendSeconds > 0) {
          _resendSeconds--;

          notifyListeners();
        } else {
          _canResend = true;

          timer.cancel();

          notifyListeners();
        }
      },
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }
}