import 'package:client_app/features/account/help_support/view/help_support_screen.dart';
import 'package:client_app/features/account/profile/view/my_profile_screen.dart';
import 'package:client_app/features/account/saved_addresses/view/saved_addresses_screen.dart';
import 'package:flutter/material.dart';

class AccountViewModel extends ChangeNotifier {
  // =========================================================
  // USER
  // =========================================================

  String get userName => 'Rohan Sharma';

  String get phoneNumber => '+91 98999 99999';

  // =========================================================
  // MENU ACTIONS
  // =========================================================

  void openMyProfile(
  BuildContext context,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) =>
          const MyProfileScreen(),
    ),
  );
}

  void openSavedAddresses(
  BuildContext context,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) =>
          const SavedAddressesScreen(),
    ),
  );
}

  void openPaymentMethods(BuildContext context) {
    debugPrint('Open Payment Methods');
  }

  void openOrders(BuildContext context) {
    debugPrint('Open Orders');

    // Since Orders is a main navigation tab,
    // later we'll switch main navigation index instead of push.
  }

  void openNotifications(BuildContext context) {
    debugPrint('Open Notifications');
  }

  void openHelpSupport(
  BuildContext context,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) =>
          const HelpSupportScreen(),
    ),
  );
}

  void openTermsPrivacy(BuildContext context) {
    debugPrint('Open Terms & Privacy');
  }

  void openMenu(BuildContext context) {
    debugPrint('Open menu');
  }
}