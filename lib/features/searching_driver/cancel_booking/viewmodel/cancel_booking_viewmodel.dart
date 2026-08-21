import 'package:flutter/material.dart';

class CancelBookingViewModel extends ChangeNotifier {
  final List<String> reasons = const [
    'Captain is taking too long',
    'Changed my plans',
    'Wrong pickup/drop',
    'Fare is too high',
    'Other',
  ];

  String? _selectedReason;

  String? get selectedReason => _selectedReason;

  bool get hasSelectedReason => _selectedReason != null;

  bool _isCancelling = false;

  bool get isCancelling => _isCancelling;

  void selectReason(String reason) {
    if (_selectedReason == reason) return;

    _selectedReason = reason;
    notifyListeners();
  }

  bool isSelected(String reason) {
    return _selectedReason == reason;
  }

  Future<void> confirmCancellation(
    BuildContext context,
  ) async {
    if (_selectedReason == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Please select a reason for cancellation.',
            ),
          ),
        );

      return;
    }

    if (_isCancelling) return;

    _isCancelling = true;
    notifyListeners();

    debugPrint('==============================');
    debugPrint('BOOKING CANCELLED');
    debugPrint('Reason: $_selectedReason');
    debugPrint('==============================');

    // TODO:
    // Replace this with your backend/API request.
    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    _isCancelling = false;
    notifyListeners();

    if (!context.mounted) return;

    // true means cancellation was confirmed.
    Navigator.pop(context, true);
  }
}