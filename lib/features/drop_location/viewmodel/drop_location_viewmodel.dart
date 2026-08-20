import 'package:client_app/features/select_vehicle/view/select_vehicle_screen.dart';
import 'package:flutter/material.dart';


class DropLocationViewModel extends ChangeNotifier {
  DropLocationViewModel({
    required this.addressTitle,
    required this.addressSubtitle,
  }) {
    nameController.addListener(_onFormChanged);
    phoneController.addListener(_onFormChanged);
  }

  // =========================================================
  // ADDRESS
  // =========================================================

  String addressTitle;
  String addressSubtitle;

  // =========================================================
  // RECEIVER FORM
  // =========================================================

  final TextEditingController houseController =
      TextEditingController();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

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
    return nameController.text.trim().isNotEmpty &&
        phoneController.text.trim().length == 10;
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
          pickupAddress: '123 Logistics Hub, Industrial Area',
          dropAddress: addressTitle,
          dropAddressSubtitle: addressSubtitle,
          receiverName: nameController.text.trim(),
          receiverPhone: phoneController.text.trim(),
          houseNumber: houseController.text.trim(),
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