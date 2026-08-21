import 'package:flutter/material.dart';

class MyProfileViewModel extends ChangeNotifier {
  // =========================================================
  // CONTROLLERS
  // =========================================================

  final TextEditingController nameController =
      TextEditingController(
    text: 'Rohan Sharma',
  );

  final TextEditingController emailController =
      TextEditingController(
    text: 'rohan.sharma@example.com',
  );

  // Mobile number is verified and read-only.
  String get mobileNumber =>
      '+91 98999 99999';

  // =========================================================
  // LOADING
  // =========================================================

  bool _isSaving = false;

  bool get isSaving => _isSaving;

  // =========================================================
  // CHANGE PHOTO
  // =========================================================

  void changePhoto(
    BuildContext context,
  ) {
    debugPrint('Change profile photo');

    // Later:
    // image_picker / camera / gallery
  }

  // =========================================================
  // SAVE
  // =========================================================

  Future<void> saveChanges(
    BuildContext context,
  ) async {
    final name =
        nameController.text.trim();

    final email =
        emailController.text.trim();

    if (name.isEmpty) {
      _showMessage(
        context,
        'Please enter your full name.',
      );
      return;
    }

    if (email.isEmpty) {
      _showMessage(
        context,
        'Please enter your email address.',
      );
      return;
    }

    if (_isSaving) return;

    _isSaving = true;
    notifyListeners();

    // Later replace with API call.
    await Future<void>.delayed(
      const Duration(
        milliseconds: 600,
      ),
    );

    _isSaving = false;
    notifyListeners();

    if (!context.mounted) {
      return;
    }

    _showMessage(
      context,
      'Profile updated successfully.',
    );
  }

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
    nameController.dispose();
    emailController.dispose();

    super.dispose();
  }
}