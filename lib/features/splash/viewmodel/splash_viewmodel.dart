import 'dart:async';

import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {
  Timer? _navigationTimer;

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // =========================================================
  // INITIALIZE SPLASH
  // =========================================================

  void initialize({
    required VoidCallback onComplete,
  }) {
    if (_isInitialized) return;

    _isInitialized = true;

    _navigationTimer = Timer(
      const Duration(milliseconds: 3200),
      onComplete,
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }
}