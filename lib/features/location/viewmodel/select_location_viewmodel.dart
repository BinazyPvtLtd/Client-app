import 'package:client_app/features/drop_location/view/drop_location_screen.dart';
import 'package:client_app/features/location/view/models/saved_address_model.dart';
import 'package:client_app/features/location/view/pickup_location_picker_screen.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:geocoding/geocoding.dart' as geo;

class SelectLocationViewModel extends ChangeNotifier {
  SelectLocationViewModel() {
    _filteredAddresses = List.of(_savedAddresses);
    dropController.addListener(_onDropQueryChanged);
  }

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
      notifyListeners();
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

  final List<SavedAddressModel> _savedAddresses = const [
    SavedAddressModel(
      id: 'addr_1',
      title: 'Jinnato Wali Masjid',
      subtitle: 'Sarfarazganj, Sarfarazganj, Lucknow, Uttar Pradesh',
      tag: 'HASAN ZAFAR',
    ),
    SavedAddressModel(
      id: 'addr_2',
      title: 'Home',
      subtitle: 'Sector B, Aliganj, Lucknow, Uttar Pradesh',
    ),
    SavedAddressModel(
      id: 'addr_3',
      title: 'Office',
      subtitle: 'Hazratganj, Lucknow, Uttar Pradesh',
    ),
  ];

  late List<SavedAddressModel> _filteredAddresses;

  List<SavedAddressModel> get filteredAddresses => _filteredAddresses;

  SavedAddressModel? _selectedDropAddress;

  SavedAddressModel? get selectedDropAddress => _selectedDropAddress;

  bool get canContinue =>
      hasPickupLocation &&
      (_selectedDropAddress != null || dropController.text.trim().isNotEmpty);

  void _onDropQueryChanged() {
    final query = dropController.text.trim().toLowerCase();

    _filteredAddresses = query.isEmpty
        ? List.of(_savedAddresses)
        : _savedAddresses.where((address) {
            return address.title.toLowerCase().contains(query) ||
                address.subtitle.toLowerCase().contains(query);
          }).toList();

    if (_selectedDropAddress != null &&
        _selectedDropAddress!.title != dropController.text) {
      _selectedDropAddress = null;
    }

    notifyListeners();
  }

  void selectSavedAddress(SavedAddressModel address) {
    _selectedDropAddress = address;
    dropController.text = address.title;
    notifyListeners();
  }

  void clearDrop() {
    _selectedDropAddress = null;
    dropController.clear();
  }

  void onSelectOnMapPressed(BuildContext context) {
    // Existing drop map action is not connected yet.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Drop map selection is not configured yet.'),
      ),
    );
  }

  void onSavedAddressesPressed(BuildContext context) {
    debugPrint('Saved addresses tapped');
  }

  void onContinuePressed(BuildContext context) {
    if (!canContinue) return;

    final dropTitle = _selectedDropAddress?.title ?? dropController.text.trim();

    final dropSubtitle = _selectedDropAddress?.subtitle ?? '';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DropLocationScreen(
          addressTitle: dropTitle,
          addressSubtitle: dropSubtitle,
        ),
      ),
    );
  }

  @override
  void dispose() {
    dropController.removeListener(_onDropQueryChanged);
    dropController.dispose();
    super.dispose();
  }
}
