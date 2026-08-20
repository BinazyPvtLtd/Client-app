// import 'package:flutter/material.dart';

// class GoodsDetailsViewModel extends ChangeNotifier {
//   // =========================================================
//   // CONTROLLERS
//   // =========================================================

//   final TextEditingController weightController =
//       TextEditingController();

//   final TextEditingController packageController =
//       TextEditingController();

//   final TextEditingController valueController =
//       TextEditingController();

//   // =========================================================
//   // CATEGORIES
//   // =========================================================

//   final List<String> categories = const [
//     'Household',
//     'Furniture',
//     'Electronics',
//     'Grocery',
//     'Clothing',
//     'Documents',
//     'Pharma',
//     'Construction',
//     'Other',
//   ];

//   final List<IconData> categoryIcons = const [
//     Icons.weekend_outlined,
//     Icons.table_restaurant_outlined,
//     Icons.devices_other_outlined,
//     Icons.shopping_cart_outlined,
//     Icons.checkroom_outlined,
//     Icons.description_outlined,
//     Icons.medical_services_outlined,
//     Icons.construction_outlined,
//     Icons.more_horiz,
//   ];

//   // =========================================================
//   // SELECTED CATEGORY
//   // =========================================================

//   int _selectedCategoryIndex = 0;

//   int get selectedCategoryIndex => _selectedCategoryIndex;

//   String get selectedCategory =>
//       categories[_selectedCategoryIndex];

//   // =========================================================
//   // INITIALIZATION
//   // =========================================================

//   GoodsDetailsViewModel() {
//     weightController.addListener(_onFormChanged);
//     packageController.addListener(_onFormChanged);
//     valueController.addListener(_onFormChanged);
//   }

//   // =========================================================
//   // CATEGORY
//   // =========================================================

//   void selectCategory(int index) {
//     if (index < 0 || index >= categories.length) {
//       return;
//     }

//     _selectedCategoryIndex = index;

//     notifyListeners();
//   }

//   // =========================================================
//   // VALIDATION
//   // =========================================================

//   bool get canContinue {
//     return weightController.text.trim().isNotEmpty &&
//         packageController.text.trim().isNotEmpty &&
//         valueController.text.trim().isNotEmpty;
//   }

//   // =========================================================
//   // CONTINUE
//   // =========================================================

//   void onContinuePressed(BuildContext context) {
//     if (!canContinue) {
//       _showValidationMessage(context);
//       return;
//     }

//     debugPrint(
//       'Category: $selectedCategory',
//     );

//     debugPrint(
//       'Weight: ${weightController.text}',
//     );

//     debugPrint(
//       'Packages: ${packageController.text}',
//     );

//     debugPrint(
//       'Goods Value: ${valueController.text}',
//     );

//     // TODO:
//     // Navigate to the next screen.
//   }

//   // =========================================================
//   // VALIDATION MESSAGE
//   // =========================================================

//   void _showValidationMessage(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text(
//           'Please enter all goods details',
//         ),
//       ),
//     );
//   }

//   // =========================================================
//   // FORM LISTENER
//   // =========================================================

//   void _onFormChanged() {
//     notifyListeners();
//   }

//   // =========================================================
//   // DISPOSE
//   // =========================================================

//   @override
//   void dispose() {
//     weightController.removeListener(_onFormChanged);
//     packageController.removeListener(_onFormChanged);
//     valueController.removeListener(_onFormChanged);

//     weightController.dispose();
//     packageController.dispose();
//     valueController.dispose();

//     super.dispose();
//   }
// }

import 'package:client_app/features/booking/view/review_booking_screen.dart';
import 'package:client_app/features/select_vehicle/view/model/vehicle_model.dart';
import 'package:flutter/material.dart';

class GoodsDetailsViewModel extends ChangeNotifier {
  // =========================================================
  // SELECTED VEHICLE
  // =========================================================

  final VehicleModel selectedVehicle;

  GoodsDetailsViewModel({
    required this.selectedVehicle,
  }) {
    weightController.addListener(_onFormChanged);
    packageController.addListener(_onFormChanged);
    valueController.addListener(_onFormChanged);
  }

  // =========================================================
  // CONTROLLERS
  // =========================================================

  final TextEditingController weightController =
      TextEditingController();

  final TextEditingController packageController =
      TextEditingController();

  final TextEditingController valueController =
      TextEditingController();

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

  String get selectedCategory =>
      categories[_selectedCategoryIndex];

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

  bool get canContinue {
    return weightController.text.trim().isNotEmpty &&
        packageController.text.trim().isNotEmpty &&
        valueController.text.trim().isNotEmpty;
  }

  // =========================================================
  // CONTINUE
  // =========================================================

  // void onContinuePressed(BuildContext context) {
  //   if (!canContinue) {
  //     _showValidationMessage(context);
  //     return;
  //   }

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => ReviewScreen(
  //         selectedVehicle: selectedVehicle,

  //         category: selectedCategory,

  //         weight: weightController.text.trim(),

  //         packages: packageController.text.trim(),

  //         goodsValue: valueController.text.trim(),
  //       ),
  //     ),
  //   );
  // }

  void onContinuePressed(
  BuildContext context,
  VehicleModel selectedVehicle,
) {
  if (!canContinue) {
    _showValidationMessage(context);
    return;
  }

  debugPrint(
    'Category: $selectedCategory',
  );

  debugPrint(
    'Weight: ${weightController.text}',
  );

  debugPrint(
    'Packages: ${packageController.text}',
  );

  debugPrint(
    'Goods Value: ${valueController.text}',
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ReviewBookingScreen(
        // vehicleName: selectedVehicle.name,
        // category: selectedCategory,
        // weight: weightController.text.trim(),
        // packages: packageController.text.trim(),
        // goodsValue: '₹${valueController.text.trim()}',
        // price: selectedVehicle.price,
        // offer: selectedVehicle.offer,
      ),
    ),
  );
}

  // =========================================================
  // VALIDATION MESSAGE
  // =========================================================

  void _showValidationMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Please enter all goods details',
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
    weightController.removeListener(_onFormChanged);
    packageController.removeListener(_onFormChanged);
    valueController.removeListener(_onFormChanged);

    weightController.dispose();
    packageController.dispose();
    valueController.dispose();

    super.dispose();
  }
}