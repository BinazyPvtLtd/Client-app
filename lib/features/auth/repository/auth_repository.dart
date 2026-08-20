import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // =========================================================
  // SEND OTP
  // =========================================================

  Future<void> sendOtp({
    required String phoneNumber,

    required void Function(
      PhoneAuthCredential credential,
    ) verificationCompleted,

    required void Function(
      FirebaseAuthException error,
    ) verificationFailed,

    required void Function(
      String verificationId,
      int? resendToken,
    ) codeSent,

    required void Function(
      String verificationId,
    ) codeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,

      verificationCompleted: verificationCompleted,

      verificationFailed: verificationFailed,

      codeSent: codeSent,

      codeAutoRetrievalTimeout:
          codeAutoRetrievalTimeout,
    );
  }

  // =========================================================
  // SIGN IN WITH CREDENTIAL
  // =========================================================

  Future<UserCredential> signInWithCredential(
    PhoneAuthCredential credential,
  ) async {
    return await _auth.signInWithCredential(
      credential,
    );
  }

  // =========================================================
  // CURRENT USER
  // =========================================================

  User? get currentUser {
    return _auth.currentUser;
  }

  // =========================================================
  // SIGN OUT
  // =========================================================

  Future<void> signOut() async {
    await _auth.signOut();
  }
}