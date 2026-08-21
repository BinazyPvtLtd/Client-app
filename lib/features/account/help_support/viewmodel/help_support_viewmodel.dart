import 'package:flutter/material.dart';

import '../model/support_category_model.dart';

class HelpSupportViewModel extends ChangeNotifier {
  // =========================================================
  // SEARCH
  // =========================================================

  final TextEditingController searchController =
      TextEditingController();

  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  // =========================================================
  // CATEGORIES
  // =========================================================

  final List<SupportCategoryModel> _categories = const [
    SupportCategoryModel(
      id: 'booking',
      title: 'Booking',
      icon: Icons.event_available_outlined,
    ),
    SupportCategoryModel(
      id: 'payment',
      title: 'Payment',
      icon: Icons.payments_outlined,
    ),
    SupportCategoryModel(
      id: 'captain',
      title: 'Captain',
      icon: Icons.local_shipping_outlined,
    ),
    SupportCategoryModel(
      id: 'cancellation',
      title: 'Cancellation',
      icon: Icons.cancel_outlined,
    ),
    SupportCategoryModel(
      id: 'refund',
      title: 'Refund',
      icon: Icons.currency_exchange_rounded,
    ),
    SupportCategoryModel(
      id: 'account',
      title: 'Account',
      icon: Icons.person_outline_rounded,
    ),
  ];

  List<SupportCategoryModel> get categories {
    if (_searchQuery.trim().isEmpty) {
      return List.unmodifiable(
        _categories,
      );
    }

    final query =
        _searchQuery.toLowerCase().trim();

    return _categories
        .where(
          (item) => item.title
              .toLowerCase()
              .contains(query),
        )
        .toList();
  }

  // =========================================================
  // SEARCH
  // =========================================================

  void onSearchChanged(
    String value,
  ) {
    _searchQuery = value;

    notifyListeners();
  }

  // =========================================================
  // CATEGORY
  // =========================================================

  void openCategory(
    BuildContext context,
    SupportCategoryModel category,
  ) {
    debugPrint(
      'Support category: ${category.title}',
    );

    // Later:
    // Navigate to FAQ / support topics screen.
  }

  // =========================================================
  // CHAT SUPPORT
  // =========================================================

  void openChatSupport(
    BuildContext context,
  ) {
    debugPrint(
      'Open chat support',
    );

    // Later:
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) =>
    //         const SupportChatScreen(),
    //   ),
    // );
  }

  // =========================================================
  // CALL SUPPORT
  // =========================================================

  void callSupport(
    BuildContext context,
  ) {
    debugPrint(
      'Call support',
    );

    // Later:
    // Use url_launcher:
    //
    // launchUrl(
    //   Uri.parse('tel:+91XXXXXXXXXX'),
    // );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }
}