// import 'package:client_app/features/select_vehicle/view/model/vehicle_model.dart';
// import 'package:flutter/foundation.dart';

// class SelectVehicleViewModel extends ChangeNotifier {
//   // =========================================================
//   // CALLBACK
//   // =========================================================

//   SelectVehicleViewModel({
//     this.onProceed,
//   });

//   final VoidCallback? onProceed;

//   // =======================================a==================
//   // VEHICLES
//   // =========================================================

//   final List<VehicleModel> vehicles = const [
//     VehicleModel(
//       name: '2 Wheeler',
//       price: '₹149',
//       maxWeight: 'Max 20 kg',
//       arriving: 'Arriving in 4 mins',
//       image: 'assets/images/2_wheeler.png',
//       offer: '₹15 OFF',
//     ),

//     VehicleModel(
//       name: 'Scooter',
//       price: '₹165',
//       maxWeight: 'Max 20 kg',
//       arriving: 'Arriving in 6 mins',
//       image: 'assets/images/2_wheeler.png',
//     ),

//     VehicleModel(
//       name: 'Mini 3W',
//       price: '₹249',
//       maxWeight: 'Max 90 kg',
//       arriving: 'Arriving in 8 mins',
//       image: 'assets/images/mini_3w.png',
//     ),

//     VehicleModel(
//       name: 'E Loader',
//       price: '₹399',
//       maxWeight: 'Max 300 kg',
//       arriving: 'Arriving in 12 mins',
//       image: 'assets/images/e_loader.png',
//     ),
//   ];

//   // =========================================================
//   // SELECTED VEHICLE
//   // =========================================================

//   int _selectedVehicleIndex = 0;

//   int get selectedVehicleIndex => _selectedVehicleIndex;

//   VehicleModel get selectedVehicle =>
//       vehicles[_selectedVehicleIndex];

//   // =========================================================
//   // SELECT VEHICLE
//   // =========================================================

//   void selectVehicle(int index) {
//     if (index < 0 || index >= vehicles.length) {
//       return;
//     }

//     if (_selectedVehicleIndex == index) {
//       return;
//     }

//     _selectedVehicleIndex = index;

//     notifyListeners();
//   }

//   // =========================================================
//   // ADD STOP
//   // =========================================================

//   void addStop() {
//     debugPrint('Add stop tapped');
//   }

//   // =========================================================
//   // EDIT LOCATION
//   // =========================================================

//   void editLocation() {
//     debugPrint('Edit location tapped');
//   }

//   // =========================================================
//   // PROCEED
//   // =========================================================

//   void proceedWithVehicle() {
//     debugPrint(
//       'Proceeding with: ${selectedVehicle.name}',
//     );

//     // Tell the View that the user wants to proceed.
//     onProceed?.call();
//   }
// }


import 'package:client_app/features/select_vehicle/view/model/vehicle_model.dart';
import 'package:flutter/foundation.dart';

class SelectVehicleViewModel extends ChangeNotifier {
  // =========================================================
  // CALLBACK
  // =========================================================

  SelectVehicleViewModel({
    this.onProceed,
  });

  final void Function(VehicleModel selectedVehicle)? onProceed;

  // =========================================================
  // VEHICLES
  // =========================================================

  final List<VehicleModel> vehicles = const [
    VehicleModel(
      name: '2 Wheeler',
      price: '₹149',
      maxWeight: 'Max 20 kg',
      arriving: 'Arriving in 4 mins',
      image: 'assets/images/2_wheeler.png',
      offer: '₹15 OFF',
    ),

    VehicleModel(
      name: 'Scooter',
      price: '₹165',
      maxWeight: 'Max 20 kg',
      arriving: 'Arriving in 6 mins',
      image: 'assets/images/2_wheeler.png',
    ),

    VehicleModel(
      name: 'Mini 3W',
      price: '₹249',
      maxWeight: 'Max 90 kg',
      arriving: 'Arriving in 8 mins',
      image: 'assets/images/mini_3w.png',
    ),

    VehicleModel(
      name: 'E Loader',
      price: '₹399',
      maxWeight: 'Max 300 kg',
      arriving: 'Arriving in 12 mins',
      image: 'assets/images/e_loader.png',
    ),
  ];

  // =========================================================
  // SELECTED VEHICLE
  // =========================================================

  int _selectedVehicleIndex = 0;

  int get selectedVehicleIndex => _selectedVehicleIndex;

  VehicleModel get selectedVehicle =>
      vehicles[_selectedVehicleIndex];

  // =========================================================
  // SELECT VEHICLE
  // =========================================================

  void selectVehicle(int index) {
    if (index < 0 || index >= vehicles.length) {
      return;
    }

    if (_selectedVehicleIndex == index) {
      return;
    }

    _selectedVehicleIndex = index;

    notifyListeners();
  }

  // =========================================================
  // ADD STOP
  // =========================================================

  void addStop() {
    debugPrint('Add stop tapped');
  }

  // =========================================================
  // EDIT LOCATION
  // =========================================================

  void editLocation() {
    debugPrint('Edit location tapped');
  }

  // =========================================================
  // PROCEED
  // =========================================================

  void proceedWithVehicle() {
    debugPrint(
      'Proceeding with: ${selectedVehicle.name}',
    );

    onProceed?.call(selectedVehicle);
  }
}