import 'dart:async';

import 'package:client_app/features/home/view/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // =========================================================
  // OTP
  // =========================================================

  String _otp = '';

  String get otp => _otp;

  // =========================================================
  // LOADING
  // =========================================================

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // =========================================================
  // VERIFICATION ID
  // =========================================================

  String? _verificationId;

  String? get verificationId => _verificationId;

  // =========================================================
  // RESEND
  // =========================================================

  bool _canResend = false;

  bool get canResend => _canResend;

  int _resendSeconds = 30;

  int get resendSeconds => _resendSeconds;

  Timer? _timer;

  // =========================================================
  // RESEND TOKEN
  // =========================================================

  int? _resendToken;

  // =========================================================
  // CONSTRUCTOR
  // =========================================================

  OtpViewModel({
    required String verificationId,
  }) {
    _verificationId = verificationId;

    _startResendTimer();
  }

  // =========================================================
  // SET OTP
  // =========================================================

  void setOtp(String value) {
    _otp = value;
    notifyListeners();
  }

  // =========================================================
  // VERIFY OTP
  // =========================================================

 Future<void> verifyOtp(
  BuildContext context, {
  required String phoneNumber,
}) async {
  // ---------------------------------------------------------
  // VALIDATE OTP
  // ---------------------------------------------------------

  if (_otp.length != 6) {
    _showError(
      context,
      'Please enter the complete 6-digit OTP.',
    );

    return;
  }

  // ---------------------------------------------------------
  // CHECK VERIFICATION ID
  // ---------------------------------------------------------

  if (_verificationId == null ||
      _verificationId!.isEmpty) {
    _showError(
      context,
      'Verification session expired. Please request a new OTP.',
    );

    return;
  }

  _isLoading = true;
  notifyListeners();

  try {
    debugPrint('========================================');
    debugPrint('🔐 FIREBASE OTP VERIFICATION STARTED');
    debugPrint('PHONE: $phoneNumber');
    debugPrint('OTP LENGTH: ${_otp.length}');
    debugPrint(
      'VERIFICATION ID EXISTS: ${_verificationId != null}',
    );
    debugPrint('========================================');

    // -------------------------------------------------------
    // CREATE FIREBASE CREDENTIAL
    // -------------------------------------------------------

    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: _otp,
    );

    // -------------------------------------------------------
    // SIGN IN WITH FIREBASE
    // -------------------------------------------------------

    final UserCredential userCredential =
        await _auth.signInWithCredential(
      credential,
    );

    // -------------------------------------------------------
    // SUCCESS
    // -------------------------------------------------------

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

    // -------------------------------------------------------
    // NAVIGATE TO HOME
    // -------------------------------------------------------

   Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(
    builder: (_) => const HomeView(),
  ),
  (route) => false,
);
  } on FirebaseAuthException catch (e) {
    // -------------------------------------------------------
    // FIREBASE ERROR
    // -------------------------------------------------------

    debugPrint('========================================');
    debugPrint('❌ OTP VERIFICATION FAILED');
    debugPrint('CODE: ${e.code}');
    debugPrint('MESSAGE: ${e.message}');
    debugPrint('========================================');

    _isLoading = false;
    notifyListeners();

    if (!context.mounted) return;

    _showError(
      context,
      _firebaseErrorMessage(e),
    );
  } catch (e) {
    // -------------------------------------------------------
    // UNKNOWN ERROR
    // -------------------------------------------------------

    debugPrint(
      '❌ OTP VERIFICATION EXCEPTION: $e',
    );

    _isLoading = false;
    notifyListeners();

    if (!context.mounted) return;

    _showError(
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

        // -----------------------------------------------------
        // AUTOMATIC VERIFICATION
        // -----------------------------------------------------

        verificationCompleted:
            (PhoneAuthCredential credential) async {
          debugPrint(
            '✅ RESEND AUTO VERIFICATION COMPLETED',
          );

          try {
            final userCredential =
                await _auth.signInWithCredential(
              credential,
            );

            debugPrint(
              '✅ USER SIGNED IN AUTOMATICALLY',
            );

            debugPrint(
              'UID: ${userCredential.user?.uid}',
            );
          } catch (e) {
            debugPrint(
              '❌ AUTO SIGN-IN ERROR: $e',
            );
          }
        },

        // -----------------------------------------------------
        // VERIFICATION FAILED
        // -----------------------------------------------------

        verificationFailed:
            (FirebaseAuthException e) {
          debugPrint('========================================');
          debugPrint('❌ RESEND OTP FAILED');
          debugPrint('CODE: ${e.code}');
          debugPrint('MESSAGE: ${e.message}');
          debugPrint('========================================');

          _isLoading = false;
          _canResend = true;

          notifyListeners();

          if (!context.mounted) return;

          _showError(
            context,
            _firebaseErrorMessage(e),
          );
        },

        // -----------------------------------------------------
        // OTP SENT
        // -----------------------------------------------------

        codeSent: (
          String verificationId,
          int? resendToken,
        ) {
          debugPrint('========================================');
          debugPrint('✅ NEW OTP SENT');
          debugPrint('NEW VERIFICATION ID RECEIVED');
          debugPrint('========================================');

          // IMPORTANT:
          // Firebase gives a NEW verification ID.
          // We MUST replace the old one.
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

        // -----------------------------------------------------
        // AUTO RETRIEVAL TIMEOUT
        // -----------------------------------------------------

        codeAutoRetrievalTimeout:
            (String verificationId) {
          debugPrint(
            '⏱️ RESEND AUTO RETRIEVAL TIMEOUT',
          );

          _verificationId = verificationId;
        },
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(
        '❌ RESEND FIREBASE EXCEPTION: ${e.code}',
      );

      _isLoading = false;
      _canResend = true;

      notifyListeners();

      if (!context.mounted) return;

      _showError(
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

      _showError(
        context,
        'Unable to resend OTP. Please try again.',
      );
    }
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
  // FIREBASE ERROR
  // =========================================================

  String _firebaseErrorMessage(
    FirebaseAuthException e,
  ) {
    switch (e.code) {
      case 'invalid-verification-code':
        return 'The OTP you entered is incorrect.';

      case 'session-expired':
        return 'The OTP has expired. Please request a new one.';

      case 'invalid-verification-id':
        return 'The verification session is invalid. Please request a new OTP.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      case 'quota-exceeded':
        return 'SMS quota exceeded. Please try again later.';

      case 'invalid-phone-number':
        return 'The phone number is invalid.';

      case 'operation-not-allowed':
        return 'Phone authentication is not enabled in Firebase.';

      default:
        return e.message ?? 'OTP verification failed.';
    }
  }

  // =========================================================
  // ERROR MESSAGE
  // =========================================================

  void _showError(
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
  // SUCCESS MESSAGE
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
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}