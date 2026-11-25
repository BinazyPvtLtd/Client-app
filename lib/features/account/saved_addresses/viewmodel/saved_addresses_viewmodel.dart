import 'package:client_app/features/account/saved_addresses/data/models/address_api_model.dart';
import 'package:client_app/features/account/saved_addresses/data/repositories/addresses_repository.dart';
import 'package:client_app/features/account/saved_addresses/model/saved_address_model.dart';
import 'package:client_app/features/account/saved_addresses/view/add_address_screen.dart';
import 'package:flutter/material.dart';

class SavedAddressesViewModel extends ChangeNotifier {
  SavedAddressesViewModel({
    AddressesRepository? repository,
  }) : _repository = repository ?? AddressesRepository();

  final AddressesRepository _repository;

  // =====================================================
  // ADDRESS LIST
  // =====================================================

  final List<SavedAddressModel> _addresses = [];

  List<SavedAddressModel> get addresses =>
      List.unmodifiable(_addresses);

  // =====================================================
  // LOADING STATE
  // =====================================================

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  // =====================================================
  // ERROR STATE
  // =====================================================

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _apiError;
  String? get apiError => _apiError;

  // =====================================================
  // DISPOSE
  // =====================================================

  bool _isDisposed = false;

  void _notify() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  // =====================================================
  // 1. GET ALL ADDRESSES API
  // =====================================================

  Future<void> loadAddresses() async {
    if (_isLoading || _isDisposed) return;

    _isLoading = true;
    _errorMessage = null;
    _notify();

    try {
      debugPrint(
        '========== LOAD ADDRESSES ==========',
      );

      final result = await _repository.getAddresses();

      if (_isDisposed) return;

      _addresses
        ..clear()
        ..addAll(
          result.map(_mapToUiModel),
        );

      debugPrint(
        'ADDRESSES LOADED: ${_addresses.length}',
      );
    } catch (error) {
      if (_isDisposed) return;

      _errorMessage = 'Unable to load saved addresses.';

      debugPrint(
        'LOAD ADDRESSES ERROR: $error',
      );
    } finally {
      _isLoading = false;
      _notify();
    }
  }

  // =====================================================
  // ADDRESS API MODEL -> UI MODEL
  // =====================================================

  SavedAddressModel _mapToUiModel(
    AddressApiModel address,
  ) {
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

  // =====================================================
  // 2. CREATE ADDRESS API
  // =====================================================

  Future<bool> saveAddressToServer(
    Map<String, dynamic> payload,
  ) async {
    if (_isSaving || _isDisposed) return false;

    _isSaving = true;
    _apiError = null;
    _notify();

    try {
      debugPrint(
        '========== SAVE ADDRESS ==========',
      );

      await _repository.createAddressApi(payload);

      if (_isDisposed) return false;

      debugPrint(
        'ADDRESS SAVED SUCCESSFULLY',
      );

      await loadAddresses();

      return _errorMessage == null;
    } catch (error) {
      if (_isDisposed) return false;

      _apiError = error.toString();

      debugPrint(
        'SAVE ADDRESS ERROR: $error',
      );

      return false;
    } finally {
      _isSaving = false;
      _notify();
    }
  }

  // =====================================================
  // 3. GET SINGLE ADDRESS API
  // =====================================================

  Future<Map<String, dynamic>?> fetchAddressById(
    String id,
  ) async {
    if (_isDisposed) return null;

    _apiError = null;
    _notify();

    try {
      debugPrint(
        '========== FETCH ADDRESS BY ID ==========',
      );

      final response = await _repository.getAddressById(id);

      if (_isDisposed) return null;

      debugPrint(
        'SINGLE ADDRESS RESPONSE: $response',
      );

      return response;
    } catch (error) {
      if (_isDisposed) return null;

      _apiError = error.toString();

      debugPrint(
        'FETCH ADDRESS ERROR: $error',
      );

      _notify();

      return null;
    }
  }

  // =====================================================
  // 4. UPDATE ADDRESS API
  // =====================================================

  Future<bool> updateAddressOnServer({
    required String id,
    required Map<String, dynamic> payload,
  }) async {
    if (_isSaving || _isDisposed) return false;

    _isSaving = true;
    _apiError = null;
    _notify();

    try {
      debugPrint(
        '========== UPDATE ADDRESS ==========',
      );

      await _repository.updateAddressApi(
        id: id,
        payload: payload,
      );

      if (_isDisposed) return false;

      debugPrint(
        'ADDRESS UPDATED SUCCESSFULLY',
      );

      await loadAddresses();

      return _errorMessage == null;
    } catch (error) {
      if (_isDisposed) return false;

      _apiError = error.toString();

      debugPrint(
        'UPDATE ADDRESS ERROR: $error',
      );

      return false;
    } finally {
      _isSaving = false;
      _notify();
    }
  }

  // =====================================================
  // 5. DELETE ADDRESS API
  // =====================================================

  Future<bool> removeAddressFromServer(
    String id,
  ) async {
    if (_isSaving || _isDisposed) return false;

    _isSaving = true;
    _apiError = null;
    _notify();

    try {
      debugPrint(
        '========== DELETE ADDRESS ==========',
      );

      debugPrint(
        'ADDRESS ID: $id',
      );

      await _repository.deleteAddressApi(id);

      if (_isDisposed) return false;

      debugPrint(
        'ADDRESS DELETED SUCCESSFULLY',
      );

      await loadAddresses();

      return _errorMessage == null;
    } catch (error) {
      if (_isDisposed) return false;

      _apiError = error.toString();

      debugPrint(
        'DELETE ADDRESS ERROR: $error',
      );

      return false;
    } finally {
      _isSaving = false;
      _notify();
    }
  }

  // =====================================================
  // DELETE ADDRESS WITH CONFIRMATION
  // =====================================================

  Future<void> deleteAddress(
    BuildContext context,
    SavedAddressModel address,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete address?'),
          content: Text(
            'Are you sure you want to remove ${address.title}?',
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pop(dialogContext, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true || !context.mounted) {
      return;
    }

    final success = await removeAddressFromServer(
      address.id.toString(),
    );

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'Address deleted successfully'
              : (_apiError ??
                  'Unable to delete address'),
        ),
      ),
    );
  }

  // =====================================================
  // EDIT ADDRESS
  // =====================================================

  // =====================================================
// EDIT ADDRESS
// =====================================================

Future<void> editAddress(
  BuildContext context,
  SavedAddressModel address,
) async {
  debugPrint('========== EDIT ADDRESS ==========');
  debugPrint('ADDRESS ID: ${address.id}');

  final result = await Navigator.push<bool>(
    context,
    MaterialPageRoute(
      builder: (_) => AddAddressScreen(
        addressId: address.id.toString(),
      ),
    ),
  );

  if (result == true && !_isDisposed) {
    await loadAddresses();
  }
}

  // =====================================================
  // ADD NEW ADDRESS SCREEN
  // =====================================================

  Future<void> addNewAddress(
    BuildContext context,
  ) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => const AddAddressScreen(),
      ),
    );

    if (result == true && !_isDisposed) {
      await loadAddresses();
    }
  }
}