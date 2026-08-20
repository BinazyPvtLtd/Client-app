import 'package:client_app/features/truck_section/view/models/truck_option_model.dart';
import 'package:flutter/material.dart';

import '../../../core/constant/app_assets.dart';

class BookTruckViewModel extends ChangeNotifier {
  BookTruckViewModel() {
    _selectedTruckId = _truckOptions.first.id;
  }

  final List<TruckOptionModel> _truckOptions = const [
    TruckOptionModel(
      id: 'mini_truck',
      name: 'Mini Truck',
      imagePath: AppAssets.miniTruck,
      price: 250,
      capacity: 'Up to 500 kg',
      description: 'Furniture, small electronics',
    ),
    TruckOptionModel(
      id: 'pickup',
      name: 'Pickup',
      imagePath: AppAssets.pickup,
      price: 450,
      capacity: 'Up to 1.2 Tons',
      description: 'Commercial goods, large items',
    ),
    TruckOptionModel(
      id: 'small_truck',
      name: 'Small Truck',
      imagePath: AppAssets.smallTruck,
      price: 850,
      capacity: 'Up to 2.5 Tons',
      description: 'Home shifting, bulk inventory',
    ),
    TruckOptionModel(
      id: 'large_truck',
      name: 'Large Truck',
      imagePath: AppAssets.largeTruck,
      price: 1350,
      capacity: 'Up to 5 Tons',
      description: 'Office relocation, wholesale loads',
    ),
  ];

  late String _selectedTruckId;

  List<TruckOptionModel> get truckOptions => _truckOptions;

  String get selectedTruckId => _selectedTruckId;

  TruckOptionModel get selectedTruck =>
      _truckOptions.firstWhere((truck) => truck.id == _selectedTruckId);

  void selectTruck(String id) {
    if (_selectedTruckId == id) return;
    _selectedTruckId = id;
    notifyListeners();
  }

  void onContinuePressed() {
    // TODO: navigate to the next step (e.g. pickup/drop location screen)
    debugPrint('Continue with ${selectedTruck.name} @ Rs.${selectedTruck.price}');
  }

  void onCompareVehiclesPressed() {
    // TODO: navigate to the vehicle comparison screen
    debugPrint('Compare vehicles tapped');
  }
}