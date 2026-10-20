import 'package:client_app/features/account/saved_addresses/data/models/address_api_model.dart';
import 'package:client_app/features/account/saved_addresses/data/repositories/addresses_repository.dart';
import 'package:client_app/features/account/saved_addresses/model/saved_address_model.dart';
import 'package:client_app/features/account/saved_addresses/view/add_address_screen.dart';
import 'package:flutter/material.dart';

class SavedAddressesViewModel extends ChangeNotifier {
  SavedAddressesViewModel({AddressesRepository? repository})
    : _repository = repository ?? AddressesRepository();

  final AddressesRepository _repository;

  final List<SavedAddressModel> _addresses = [];

  List<SavedAddressModel> get addresses => List.unmodifiable(_addresses);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> loadAddresses() async {
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _repository.getAddresses();

      if (_isDisposed) return;

      _addresses
        ..clear()
        ..addAll(result.map(_mapToUiModel));
    } catch (error) {
      if (_isDisposed) return;

      _errorMessage = 'Unable to load saved addresses.';
      debugPrint('Load addresses failed: $error');
    } finally {
      _isLoading = false;

      if (!_isDisposed) {
        notifyListeners();
      }
    }
  }

  SavedAddressModel _mapToUiModel(AddressApiModel address) {
    final title = address.title.toLowerCase();

    final IconData icon;

    if (title == 'home') {
      icon = Icons.home_outlined;
    } else if (title == 'work') {
      icon = Icons.work_outline_rounded;
    } else {
      icon = Icons.location_on_outlined;
    }

    return SavedAddressModel(
      id: address.id,
      title: address.title,
      address: address.fullAddress,
      icon: icon,
    );
  }

  Future<void> deleteAddress(
    BuildContext context,
    SavedAddressModel address,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete address?'),
          content: Text('Are you sure you want to remove ${address.title}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) return;

    if (_isDisposed) return;

    // Local-only deletion until DELETE /addresses/{id}
    // is integrated and verified.
    _addresses.removeWhere((item) => item.id == address.id);

    notifyListeners();
  }

  void editAddress(BuildContext context, SavedAddressModel address) {
    debugPrint('Edit address: ${address.title}');
  }

  Future<void> addNewAddress(BuildContext context) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const AddAddressScreen()),
    );

    if (result == true && !_isDisposed) {
      await loadAddresses();
    }
  }
}
