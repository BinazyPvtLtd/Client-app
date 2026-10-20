import 'package:client_app/features/select_vehicle/view/select_vehicle_screen.dart';
import 'package:flutter/material.dart';

class DropLocationViewModel extends ChangeNotifier {
  DropLocationViewModel({
    required this.addressTitle,
    required this.addressSubtitle,
    this.pickupAddress,
    this.pickupLatitude,
    this.pickupLongitude,
    this.dropLatitude,
    this.dropLongitude,
  }) {
    nameController.addListener(_onFormChanged);
    phoneController.addListener(_onFormChanged);
  }

  // =========================================================
  // ADDRESS
  // =========================================================

  String addressTitle;
  String addressSubtitle;

  final String? pickupAddress;
  final double? pickupLatitude;
  final double? pickupLongitude;
  final double? dropLatitude;
  final double? dropLongitude;

  bool get hasValidCoordinates =>
      pickupLatitude != null &&
      pickupLongitude != null &&
      dropLatitude != null &&
      dropLongitude != null;

  // =========================================================
  // RECEIVER FORM
  // =========================================================

  final TextEditingController houseController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  bool useMyMobileNumber = false;

  static const String _myMobileNumber = '9721253815';

  // =========================================================
  // ACTIONS
  // =========================================================

  void onLocateMePressed() {
    debugPrint('Locate me tapped');
  }

  void onChangeAddressPressed(BuildContext context) {
    Navigator.of(context).maybePop();
  }

  // =========================================================
  // MOBILE NUMBER
  // =========================================================

  void toggleUseMyMobileNumber(bool? value) {
    useMyMobileNumber = value ?? false;

    if (useMyMobileNumber) {
      phoneController.text = _myMobileNumber;
    } else {
      phoneController.clear();
    }

    notifyListeners();
  }

  // =========================================================
  // VALIDATION
  // =========================================================

  bool get canConfirm {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();

    return name.isNotEmpty && RegExp(r'^[0-9]{10}$').hasMatch(phone);
  }

  // =========================================================
  // CONFIRM DROP LOCATION
  // =========================================================

  void onConfirmPressed(BuildContext context) {
    if (!canConfirm) {
      return;
    }

    debugPrint(
      'Confirmed drop: '
      '$addressTitle | '
      '$addressSubtitle | '
      '${houseController.text} | '
      '${nameController.text} | '
      '${phoneController.text}',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SelectVehicleScreen(
          pickupAddress: pickupAddress ?? '',
          dropAddress: addressTitle,
          dropAddressSubtitle: addressSubtitle,
          receiverName: nameController.text.trim(),
          receiverPhone: phoneController.text.trim(),
          houseNumber: houseController.text.trim(),
          pickupLatitude: pickupLatitude,
          pickupLongitude: pickupLongitude,
          dropLatitude: dropLatitude,
          dropLongitude: dropLongitude,
        ),
      ),
    );
  }

  // =========================================================
  // FORM LISTENER
  // =========================================================

  void _onFormChanged() {
    notifyListeners();
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    nameController.removeListener(_onFormChanged);
    phoneController.removeListener(_onFormChanged);

    houseController.dispose();
    nameController.dispose();
    phoneController.dispose();

    super.dispose();
  }
}
