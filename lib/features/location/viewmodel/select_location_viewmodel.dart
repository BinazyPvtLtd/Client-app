import 'package:client_app/features/account/saved_addresses/data/models/address_api_model.dart';
import 'package:client_app/features/account/saved_addresses/view/saved_addresses_screen.dart';
import 'package:client_app/features/drop_location/view/drop_location_screen.dart';
import 'package:client_app/features/location/view/models/saved_address_model.dart';
import 'package:client_app/features/location/view/pickup_location_picker_screen.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:client_app/features/account/saved_addresses/data/repositories/addresses_repository.dart';

import 'package:geocoding/geocoding.dart' as geo;

class SelectLocationViewModel extends ChangeNotifier {
  SelectLocationViewModel({AddressesRepository? addressesRepository})
    : _addressesRepository = addressesRepository ?? AddressesRepository() {
    dropController.addListener(_onDropQueryChanged);
  }

  final AddressesRepository _addressesRepository;

  // PICKUP

  final String _pickupName = 'Hasan Zafar';
  final String _pickupPhone = '9721253815';

  String _pickupAddress = 'Detecting current location...';
  double? _pickupLatitude;
  double? _pickupLongitude;

  bool _isLoadingPickup = false;
  String? _pickupError;

  String get pickupName => _pickupName;
  String get pickupPhone => _pickupPhone;
  String get pickupAddress => _pickupAddress;

  double? get pickupLatitude => _pickupLatitude;
  double? get pickupLongitude => _pickupLongitude;

  bool get isLoadingPickup => _isLoadingPickup;
  String? get pickupError => _pickupError;

  bool get hasPickupLocation =>
      _pickupLatitude != null && _pickupLongitude != null;

  Future<void> loadCurrentPickupLocation() async {
    if (_isLoadingPickup) return;

    _isLoadingPickup = true;
    _pickupError = null;
    notifyListeners();

    try {
      final enabled = await Geolocator.isLocationServiceEnabled();

      if (!enabled) {
        throw Exception('Please enable GPS.');
      }

      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('Location permission is required.');
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 20),
        ),
      );

      final places = await geo.Geocoding().placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String address =
          '${position.latitude.toStringAsFixed(6)}, '
          '${position.longitude.toStringAsFixed(6)}';

      if (places.isNotEmpty) {
        final place = places.first;

        final parts =
            [
                  place.street,
                  place.subLocality,
                  place.locality,
                  place.administrativeArea,
                  place.postalCode,
                ]
                .whereType<String>()
                .where((value) => value.trim().isNotEmpty)
                .toSet()
                .toList();

        if (parts.isNotEmpty) {
          address = parts.join(', ');
        }
      }

      _pickupLatitude = position.latitude;
      _pickupLongitude = position.longitude;
      _pickupAddress = address;
    } catch (error) {
      _pickupError = error.toString().replaceFirst('Exception: ', '');

      _pickupAddress = 'Tap to select pickup location';
    } finally {
      _isLoadingPickup = false;
      if (!_isDisposed) {
        notifyListeners();
      }
    }
  }

  Future<void> onPickupTapped(BuildContext context) async {
    final result = await Navigator.of(context).push<PickupLocationResult>(
      MaterialPageRoute(
        builder: (_) => PickupLocationPickerScreen(
          initialLatitude: _pickupLatitude,
          initialLongitude: _pickupLongitude,
        ),
      ),
    );

    if (result == null) return;

    _pickupAddress = result.address;
    _pickupLatitude = result.latitude;
    _pickupLongitude = result.longitude;
    _pickupError = null;

    notifyListeners();
  }

  // DROP

  final TextEditingController dropController = TextEditingController();

  List<SavedAddressModel> _savedAddresses = [];
  List<SavedAddressModel> _filteredAddresses = [];

  bool _isLoadingAddresses = false;
  bool get isLoadingAddresses => _isLoadingAddresses;

  String? _addressesError;
  String? get addressesError => _addressesError;

  bool _isDisposed = false;

  double? _dropLatitude;
  double? _dropLongitude;

  double? get dropLatitude => _dropLatitude;
  double? get dropLongitude => _dropLongitude;

  bool get hasDropLocation => _dropLatitude != null && _dropLongitude != null;

  Future<void> loadSavedAddresses() async {
    if (_isLoadingAddresses || _isDisposed) return;

    _isLoadingAddresses = true;
    _addressesError = null;
    notifyListeners();

    try {
      final result = await _addressesRepository.getAddresses();

      if (_isDisposed) return;

      _savedAddresses = result.map(_mapAddress).toList();
      _refreshFilteredAddresses();
    } catch (error) {
      if (_isDisposed) return;

      _addressesError = 'Unable to load saved addresses.';
      debugPrint('Saved addresses error: $error');
    } finally {
      _isLoadingAddresses = false;

      if (!_isDisposed) {
        notifyListeners();
      }
    }
  }

  SavedAddressModel _mapAddress(AddressApiModel address) {
    return SavedAddressModel(
      id: address.id,
      title: address.title,
      subtitle: address.fullAddress,
    );
  }

  // late List<SavedAddressModel> _filteredAddresses;

  List<SavedAddressModel> get filteredAddresses => _filteredAddresses;

  SavedAddressModel? _selectedDropAddress;

  SavedAddressModel? get selectedDropAddress => _selectedDropAddress;

  bool _isResolvingDrop = false;

  bool get isResolvingDrop => _isResolvingDrop;

  String? _dropSearchError;

  String? get dropSearchError => _dropSearchError;

  bool get canContinue =>
      hasPickupLocation &&
      dropController.text.trim().isNotEmpty &&
      !_isResolvingDrop;
  void _onDropQueryChanged() {
    final query = dropController.text.trim().toLowerCase();

    _filteredAddresses = query.isEmpty
        ? List.of(_savedAddresses)
        : _savedAddresses.where((address) {
            return address.title.toLowerCase().contains(query) ||
                address.subtitle.toLowerCase().contains(query);
          }).toList();

    // User manually edits the text, so previous selection is invalid.
    _selectedDropAddress = null;
    _dropLatitude = null;
    _dropLongitude = null;

    notifyListeners();
  }

  void _refreshFilteredAddresses() {
    final query = dropController.text.trim().toLowerCase();

    _filteredAddresses = query.isEmpty
        ? List.of(_savedAddresses)
        : _savedAddresses.where((address) {
            return address.title.toLowerCase().contains(query) ||
                address.subtitle.toLowerCase().contains(query);
          }).toList();

    notifyListeners();
  }

  Future<bool> resolveManualDropAddress() async {
    final query = dropController.text.trim();

    if (query.isEmpty) return false;

    // Already confirmed from map, and text unchanged.
    if (hasDropLocation) return true;

    _isResolvingDrop = true;
    _dropSearchError = null;
    notifyListeners();

    try {
      final results = await geo.Geocoding().locationFromAddress(
        '$query, Lucknow, Uttar Pradesh, India',
      );

      if (_isDisposed) return false;

      if (results.isEmpty) {
        _dropSearchError = 'No address found. Please try another location.';
        return false;
      }

      _dropLatitude = results.first.latitude;
      _dropLongitude = results.first.longitude;

      return true;
    } catch (_) {
      if (_isDisposed) return false;

      _dropSearchError =
          'No address found. Enter a valid location or select on map.';
      return false;
    } finally {
      _isResolvingDrop = false;

      if (!_isDisposed) notifyListeners();
    }
  }

  void selectSavedAddress(SavedAddressModel address) {
    // Text update triggers the search listener.
    dropController.text = address.title;

    // Save selection after the listener runs.
    _selectedDropAddress = address;

    // Saved address coordinates are not available yet.
    _dropLatitude = null;
    _dropLongitude = null;

    notifyListeners();
  }

  void clearDrop() {
    _selectedDropAddress = null;
    _dropLatitude = null;
    _dropLongitude = null;

    dropController.clear();
    notifyListeners();
  }

  Future<void> onSelectOnMapPressed(BuildContext context) async {
    final result = await Navigator.of(context).push<PickupLocationResult>(
      MaterialPageRoute(
        builder: (_) => PickupLocationPickerScreen(
          isDropLocation: true,
          initialLatitude: _dropLatitude ?? _pickupLatitude,
          initialLongitude: _dropLongitude ?? _pickupLongitude,
        ),
      ),
    );

    if (result == null || _isDisposed) return;

    // First update text. Its listener may clear the old selection.
    dropController.text = result.address;

    // Then store the confirmed map coordinates.
    _selectedDropAddress = null;
    _dropLatitude = result.latitude;
    _dropLongitude = result.longitude;

    notifyListeners();
  }

  Future<void> onSavedAddressesPressed(BuildContext context) async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const SavedAddressesScreen()));

    if (_isDisposed) return;

    await loadSavedAddresses();
  }

  Future<void> onContinuePressed(BuildContext context) async {
    if (!canContinue) return;

    final resolved = await resolveManualDropAddress();

    if (!resolved || !context.mounted || _isDisposed) return;

    final dropTitle = _selectedDropAddress?.title ?? dropController.text.trim();

    final dropSubtitle = _selectedDropAddress?.subtitle ?? '';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DropLocationScreen(
          addressTitle: dropTitle,
          addressSubtitle: dropSubtitle,
          pickupAddress: _pickupAddress,
          pickupLatitude: _pickupLatitude,
          pickupLongitude: _pickupLongitude,
          dropLatitude: _dropLatitude,
          dropLongitude: _dropLongitude,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    dropController.removeListener(_onDropQueryChanged);
    dropController.dispose();
    super.dispose();
  }
}
