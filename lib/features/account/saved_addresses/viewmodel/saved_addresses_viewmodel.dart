import 'package:client_app/features/account/saved_addresses/model/saved_address_model.dart';
import 'package:flutter/material.dart';


class SavedAddressesViewModel extends ChangeNotifier {
  // =========================================================
  // ADDRESSES
  // =========================================================

  final List<SavedAddressModel> _addresses = [
    const SavedAddressModel(
      id: 'home',
      title: 'Home',
      address:
          '12, HSR Layout, Sector 6, Bengaluru, Karnataka 560102',
      icon: Icons.home_outlined,
    ),

    const SavedAddressModel(
      id: 'work',
      title: 'Work',
      address:
          'Tech Park B, Phase 2, Electronic City, Bengaluru, Karnataka 560100',
      icon: Icons.work_outline_rounded,
    ),

    const SavedAddressModel(
      id: 'gym',
      title: 'Gym',
      address:
          'FitZone Arena, Koramangala 4th Block, Bengaluru, Karnataka 560034',
      icon: Icons.location_on_outlined,
    ),
  ];

  // =========================================================
  // GET ADDRESSES
  // =========================================================

  List<SavedAddressModel> get addresses =>
      List.unmodifiable(_addresses);

  // =========================================================
  // DELETE ADDRESS
  // =========================================================

  Future<void> deleteAddress(
    BuildContext context,
    SavedAddressModel address,
  ) async {
    final shouldDelete =
        await showDialog<bool>(
      context: context,
      builder: (
        dialogContext,
      ) {
        return AlertDialog(
          title: const Text(
            'Delete address?',
          ),

          content: Text(
            'Are you sure you want to remove ${address.title}?',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: const Text(
                'Cancel',
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              child: const Text(
                'Delete',
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    _addresses.removeWhere(
      (item) =>
          item.id == address.id,
    );

    notifyListeners();
  }

  // =========================================================
  // EDIT ADDRESS
  // =========================================================

  void editAddress(
    BuildContext context,
    SavedAddressModel address,
  ) {
    debugPrint(
      'Edit address: ${address.title}',
    );

    // Later:
    //
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) =>
    //         AddEditAddressScreen(
    //       address: address,
    //     ),
    //   ),
    // );
  }

  // =========================================================
  // ADD NEW ADDRESS
  // =========================================================

  void addNewAddress(
    BuildContext context,
  ) {
    debugPrint(
      'Add new address',
    );

    // Later:
    //
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) =>
    //         const AddEditAddressScreen(),
    //   ),
    // );
  }
}