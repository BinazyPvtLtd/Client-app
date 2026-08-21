import 'dart:async';

import 'package:client_app/core/theme/app_colors.dart';
import 'package:client_app/features/searching_driver/cancel_booking/view/cancel_booking_sheet.dart';
import 'package:flutter/material.dart';

class SearchingDriverViewModel extends ChangeNotifier {
  // =========================================================
  // SEARCH STATE
  // =========================================================

  bool _isSearching = true;

  bool get isSearching => _isSearching;

  int _animationStep = 0;

  int get animationStep => _animationStep;

  Timer? _searchTimer;

  // =========================================================
  // BOOKING DATA
  // For now dummy data. Later pass real booking data.
  // =========================================================

  String get pickupAddress =>
      'Current Location, Lucknow';

  String get dropAddress =>
      'Jinnato Wali Masjid, Sarfarazganj';

  String get vehicleName =>
      '2 Wheeler';

  double get finalFare => 45;

  double get originalFare => 55;

  // =========================================================
  // CONSTRUCTOR
  // =========================================================

  SearchingDriverViewModel() {
    _startSearchingAnimation();
  }

  // =========================================================
  // SEARCH ANIMATION
  // =========================================================

  void _startSearchingAnimation() {
    _searchTimer = Timer.periodic(
      const Duration(milliseconds: 700),
      (_) {
        _animationStep++;

        if (_animationStep > 3) {
          _animationStep = 0;
        }

        notifyListeners();
      },
    );
  }

  // =========================================================
  // CANCEL REQUEST
  // =========================================================

  Future<void> cancelRequest(
  BuildContext context,
) async {
  final cancelled =
      await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    enableDrag: true,
    isDismissible: true,

    backgroundColor:
        AppColors.transparent,

    barrierColor:
        AppColors.overlay,

    builder: (
      sheetContext,
    ) {
      return const FractionallySizedBox(
        heightFactor: 0.88,
        child: CancelBookingSheet(),
      );
    },
  );

  // User ne Keep Booking kiya,
  // swipe down kiya ya outside tap karke sheet close ki.
  if (cancelled != true) {
    return;
  }

  // Actual cancellation confirmed.
  _isSearching = false;

  _searchTimer?.cancel();

  notifyListeners();

  debugPrint(
    'Searching request cancelled.',
  );

  if (!context.mounted) {
    return;
  }

  // Current SearchingDriverScreen close.
  Navigator.pop(context);
}

  // =========================================================
  // INFO
  // =========================================================

  void onInfoPressed(
    BuildContext context,
  ) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Searching for drivers',
          ),

          content: const Text(
            'We are checking for nearby available drivers.',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                'OK',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchTimer?.cancel();

    super.dispose();
  }
}