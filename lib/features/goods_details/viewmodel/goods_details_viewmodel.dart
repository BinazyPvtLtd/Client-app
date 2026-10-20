import 'package:client_app/features/booking/models/booking_details_model.dart';
import 'package:client_app/features/booking/view/review_booking_screen.dart';
import 'package:client_app/features/select_vehicle/view/model/vehicle_model.dart';
import 'package:flutter/material.dart';

class GoodsDetailsViewModel extends ChangeNotifier {
  // =========================================================
  // SELECTED VEHICLE
  // =========================================================

  final VehicleModel selectedVehicle;

  final String pickupAddress;
  final String dropAddress;
  final String dropAddressSubtitle;
  final String receiverName;
  final String receiverPhone;
  final String houseNumber;

  final double? pickupLatitude;
  final double? pickupLongitude;
  final double? dropLatitude;
  final double? dropLongitude;

  GoodsDetailsViewModel({
    required this.selectedVehicle,
    this.pickupAddress = '',
    this.dropAddress = '',
    this.dropAddressSubtitle = '',
    this.receiverName = '',
    this.receiverPhone = '',
    this.houseNumber = '',
    this.pickupLatitude,
    this.pickupLongitude,
    this.dropLatitude,
    this.dropLongitude,
  }) {
    weightController.addListener(_onFormChanged);
    packageController.addListener(_onFormChanged);
    valueController.addListener(_onFormChanged);
  }

  // =========================================================
  // CONTROLLERS
  // =========================================================

  final TextEditingController weightController = TextEditingController();

  final TextEditingController packageController = TextEditingController();

  final TextEditingController valueController = TextEditingController();

  // =========================================================
  // CATEGORIES
  // =========================================================

  final List<String> categories = const [
    'Household',
    'Furniture',
    'Electronics',
    'Grocery',
    'Clothing',
    'Documents',
    'Pharma',
    'Construction',
    'Other',
  ];

  final List<IconData> categoryIcons = const [
    Icons.weekend_outlined,
    Icons.table_restaurant_outlined,
    Icons.devices_other_outlined,
    Icons.shopping_cart_outlined,
    Icons.checkroom_outlined,
    Icons.description_outlined,
    Icons.medical_services_outlined,
    Icons.construction_outlined,
    Icons.more_horiz,
  ];

  // =========================================================
  // SELECTED CATEGORY
  // =========================================================

  int _selectedCategoryIndex = 0;

  int get selectedCategoryIndex => _selectedCategoryIndex;

  String get selectedCategory => categories[_selectedCategoryIndex];

  // =========================================================
  // CATEGORY
  // =========================================================

  void selectCategory(int index) {
    if (index < 0 || index >= categories.length) {
      return;
    }

    _selectedCategoryIndex = index;

    notifyListeners();
  }

  // =========================================================
  // VALIDATION
  // =========================================================

  double? get maxAllowedWeightKg {
    return selectedVehicle.capacityKg;
  }

  String? get weightError {
    final input = weightController.text.trim();

    if (input.isEmpty) return null;

    final weight = double.tryParse(input);

    if (weight == null || !weight.isFinite || weight <= 0) {
      return 'Enter a valid weight greater than 0 kg';
    }

    final maxWeight = maxAllowedWeightKg;

    if (maxWeight == null) {
      return 'Vehicle capacity is unavailable';
    }

    if (weight > maxWeight) {
      return 'Maximum allowed weight is ${maxWeight.toStringAsFixed(0)} kg';
    }

    return null;
  }

  String? get packagesError {
    final input = packageController.text.trim();

    if (input.isEmpty) return null;

    final packages = int.tryParse(input);

    if (packages == null || packages <= 0) {
      return 'Enter a valid number of packages';
    }

    return null;
  }

  String? get goodsValueError {
    final input = valueController.text.trim();

    if (input.isEmpty) return null;

    final value = double.tryParse(input);

    if (value == null || !value.isFinite || value <= 0) {
      return 'Enter a valid goods value greater than ₹0';
    }

    return null;
  }

  bool get canContinue {
    final weight = double.tryParse(weightController.text.trim());
    final packages = int.tryParse(packageController.text.trim());
    final goodsValue = double.tryParse(valueController.text.trim());

    if (weight == null || !weight.isFinite || weight <= 0) {
      return false;
    }

    if (packages == null || packages <= 0) {
      return false;
    }

    if (goodsValue == null || !goodsValue.isFinite || goodsValue <= 0) {
      return false;
    }

    final maxWeight = maxAllowedWeightKg;

    // Unknown capacity: do not allow booking to proceed.
    if (maxWeight == null || weight > maxWeight) {
      return false;
    }

    return true;
  }

  void onContinuePressed(BuildContext context, VehicleModel selectedVehicle) {
    if (!canContinue) {
      _showValidationMessage(context);
      return;
    }

    
final bookingDetails = BookingDetailsModel(
  selectedVehicle: selectedVehicle,
  category: selectedCategory,
  weightKg: double.parse(weightController.text.trim()),
  packages: int.parse(packageController.text.trim()),
  goodsValue: double.parse(valueController.text.trim()),

  // Pickup
  pickupAddress: pickupAddress,
  pickupLatitude: pickupLatitude,
  pickupLongitude: pickupLongitude,

  // Drop
  dropAddress: dropAddress,
  dropAddressSubtitle: dropAddressSubtitle,
  dropLatitude: dropLatitude,
  dropLongitude: dropLongitude,

  // Receiver
  receiverName: receiverName,
  receiverPhone: receiverPhone,
  houseNumber: houseNumber,
);


    debugPrint('Vehicle: ${bookingDetails.vehicleName}');
    debugPrint('Category: ${bookingDetails.category}');
    debugPrint('Weight: ${bookingDetails.weightKg}');
    debugPrint('Packages: ${bookingDetails.packages}');
    debugPrint('Goods Value: ${bookingDetails.goodsValue}');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReviewBookingScreen(bookingDetails: bookingDetails),
      ),
    );
  }

  // =========================================================
  // VALIDATION MESSAGE
  // =========================================================

  void _showValidationMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter all goods details')),
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
    weightController.removeListener(_onFormChanged);
    packageController.removeListener(_onFormChanged);
    valueController.removeListener(_onFormChanged);

    weightController.dispose();
    packageController.dispose();
    valueController.dispose();

    super.dispose();
  }
}
