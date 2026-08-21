import 'package:flutter/material.dart';

class RideRatingViewModel extends ChangeNotifier {
  // =========================================================
  // DRIVER
  // =========================================================

  String get driverName => 'Rahul Kumar';

  String get driverRating => '4.8';

  String get driverRole => 'Captain';

  // =========================================================
  // RATING
  // =========================================================

  int _rating = 0;

  int get rating => _rating;

  void setRating(int value) {
    if (_rating == value) return;

    _rating = value;

    notifyListeners();
  }

  // =========================================================
  // FEEDBACK TAGS
  // =========================================================

  final List<String> feedbackOptions = const [
    'On time',
    'Professional',
    'Safe',
    'Good communication',
  ];

  final Set<String> _selectedFeedback = {};

  Set<String> get selectedFeedback =>
      _selectedFeedback;

  bool isFeedbackSelected(
    String feedback,
  ) {
    return _selectedFeedback.contains(
      feedback,
    );
  }

  void toggleFeedback(
    String feedback,
  ) {
    if (_selectedFeedback.contains(feedback)) {
      _selectedFeedback.remove(feedback);
    } else {
      _selectedFeedback.add(feedback);
    }

    notifyListeners();
  }

  // =========================================================
  // COMMENT
  // =========================================================

  String _comment = '';

  String get comment => _comment;

  void setComment(
    String value,
  ) {
    _comment = value;
  }

  // =========================================================
  // LOADING
  // =========================================================

  bool _isSubmitting = false;

  bool get isSubmitting =>
      _isSubmitting;

  // =========================================================
  // VALIDATION
  // =========================================================

  bool get canSubmit =>
      _rating > 0 &&
      !_isSubmitting;

  // =========================================================
  // SUBMIT REVIEW
  // =========================================================

  Future<void> submitReview(
    BuildContext context,
  ) async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Please select a rating.',
            ),
          ),
        );

      return;
    }

    _isSubmitting = true;

    notifyListeners();

    debugPrint(
      '================================',
    );
    debugPrint(
      'REVIEW SUBMITTED',
    );
    debugPrint(
      'Rating: $_rating',
    );
    debugPrint(
      'Feedback: $_selectedFeedback',
    );
    debugPrint(
      'Comment: $_comment',
    );
    debugPrint(
      '================================',
    );

    // Temporary delay for testing.
    //
    // Later:
    // await reviewRepository.submitReview(...);

    await Future<void>.delayed(
      const Duration(
        milliseconds: 600,
      ),
    );

    _isSubmitting = false;

    notifyListeners();

    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Thank you for your feedback.',
          ),
        ),
      );

    Navigator.pop(context);
  }
}