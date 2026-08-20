// import 'package:client_app/features/location/view/models/saved_address_model.dart';
// import 'package:flutter/material.dart';


// class SelectLocationViewModel extends ChangeNotifier {
//   SelectLocationViewModel() {
//     _filteredAddresses = List.of(_savedAddresses);
//     dropController.addListener(_onDropQueryChanged);
//   }

//   // =========================================================
//   // PICKUP
//   // =========================================================
//   // Mocked for now — wire this up to a real location service
//   // (e.g. geolocator + reverse geocoding) when ready.

//   final String _pickupName = 'Hasan Zafar';
//   final String _pickupPhone = '9721253815';
//   final String _pickupAddress =
//       'Sector B, Aliganj, Lucknow, Uttar Pradesh';

//   String get pickupName => _pickupName;
//   String get pickupPhone => _pickupPhone;
//   String get pickupAddress => _pickupAddress;

//   void onPickupTapped(BuildContext context) {
//     // TODO: navigate to edit / change pickup location.
//     debugPrint('Edit pickup location tapped');
//   }

//   // =========================================================
//   // DROP
//   // =========================================================

//   final TextEditingController dropController = TextEditingController();

//   final List<SavedAddressModel> _savedAddresses = const [
//     SavedAddressModel(
//       id: 'addr_1',
//       title: 'Jinnato Wali Masjid',
//       subtitle: 'Sarfarazganj, Sarfarazganj, Lucknow, Uttar Pradesh',
//       tag: 'HASAN ZAFAR',
//     ),
//     SavedAddressModel(
//       id: 'addr_2',
//       title: 'Home',
//       subtitle: 'Sector B, Aliganj, Lucknow, Uttar Pradesh',
//     ),
//     SavedAddressModel(
//       id: 'addr_3',
//       title: 'Office',
//       subtitle: 'Hazratganj, Lucknow, Uttar Pradesh',
//     ),
//   ];

//   late List<SavedAddressModel> _filteredAddresses;

//   List<SavedAddressModel> get filteredAddresses => _filteredAddresses;

//   SavedAddressModel? _selectedDropAddress;

//   SavedAddressModel? get selectedDropAddress => _selectedDropAddress;

//   bool get canContinue =>
//       _selectedDropAddress != null || dropController.text.trim().isNotEmpty;

//   void _onDropQueryChanged() {
//     final query = dropController.text.trim().toLowerCase();

//     _filteredAddresses = query.isEmpty
//         ? List.of(_savedAddresses)
//         : _savedAddresses
//             .where((address) =>
//                 address.title.toLowerCase().contains(query) ||
//                 address.subtitle.toLowerCase().contains(query))
//             .toList();

//     if (_selectedDropAddress != null &&
//         _selectedDropAddress!.title != dropController.text) {
//       _selectedDropAddress = null;
//     }

//     notifyListeners();
//   }

//   void selectSavedAddress(SavedAddressModel address) {
//     _selectedDropAddress = address;
//     dropController.text = address.title;
//     notifyListeners();
//   }

//   void clearDrop() {
//     _selectedDropAddress = null;
//     dropController.clear();
//   }

//   // =========================================================
//   // QUICK ACTIONS
//   // =========================================================

//   void onSelectOnMapPressed(BuildContext context) {
//     // TODO: navigate to the "select drop on map" screen.
//     debugPrint('Select on map tapped');
//   }

//   void onSavedAddressesPressed(BuildContext context) {
//     // TODO: navigate to the saved addresses screen.
//     debugPrint('Saved addresses tapped');
//   }

//   // =========================================================
//   // CONTINUE
//   // =========================================================

//   void onContinuePressed(BuildContext context) {
//     if (!canContinue) return;

//     // TODO: navigate to the Drop Location detail screen, passing the
//     // selected/entered drop address forward.
//     final dropText = _selectedDropAddress?.title ?? dropController.text;
//     debugPrint('Continue with drop: $dropText');
//   }

//   @override
//   void dispose() {
//     dropController.removeListener(_onDropQueryChanged);
//     dropController.dispose();
//     super.dispose();
//   }
// }


import 'package:client_app/features/drop_location/view/drop_location_screen.dart';
import 'package:client_app/features/location/view/models/saved_address_model.dart';
import 'package:flutter/material.dart';



class SelectLocationViewModel extends ChangeNotifier {
  SelectLocationViewModel() {
    _filteredAddresses = List.of(_savedAddresses);
    dropController.addListener(_onDropQueryChanged);
  }

  // =========================================================
  // PICKUP
  // =========================================================
  // Mocked for now — wire this up to a real location service
  // (e.g. geolocator + reverse geocoding) when ready.

  final String _pickupName = 'Hasan Zafar';
  final String _pickupPhone = '9721253815';
  final String _pickupAddress =
      'Sector B, Aliganj, Lucknow, Uttar Pradesh';

  String get pickupName => _pickupName;
  String get pickupPhone => _pickupPhone;
  String get pickupAddress => _pickupAddress;

  void onPickupTapped(BuildContext context) {
    // TODO: navigate to edit / change pickup location.
    debugPrint('Edit pickup location tapped');
  }

  // =========================================================
  // DROP
  // =========================================================

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
      _selectedDropAddress != null || dropController.text.trim().isNotEmpty;

  void _onDropQueryChanged() {
    final query = dropController.text.trim().toLowerCase();

    _filteredAddresses = query.isEmpty
        ? List.of(_savedAddresses)
        : _savedAddresses
            .where((address) =>
                address.title.toLowerCase().contains(query) ||
                address.subtitle.toLowerCase().contains(query))
            .toList();

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

  // =========================================================
  // QUICK ACTIONS
  // =========================================================

  void onSelectOnMapPressed(BuildContext context) {
    // TODO: navigate to the "select drop on map" screen.
    debugPrint('Select on map tapped');
  }

  void onSavedAddressesPressed(BuildContext context) {
    // TODO: navigate to the saved addresses screen.
    debugPrint('Saved addresses tapped');
  }

  // =========================================================
  // CONTINUE
  // =========================================================

  void onContinuePressed(BuildContext context) {
    if (!canContinue) return;

    final dropTitle = _selectedDropAddress?.title ?? dropController.text;
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