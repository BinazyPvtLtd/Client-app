import 'package:client_app/features/select_vehicle/view/model/vehicle_model.dart';

class BookingDetailsModel {
  const BookingDetailsModel({
    required this.selectedVehicle,
    required this.category,
    required this.weightKg,
    required this.packages,
    required this.goodsValue,
    this.pickupAddress = '',
    this.pickupLatitude,
    this.pickupLongitude,
    this.dropAddress = '',
    this.dropAddressSubtitle = '',
    this.dropLatitude,
    this.dropLongitude,
    this.receiverName = '',
    this.receiverPhone = '',
    this.houseNumber = '',
  });

  final VehicleModel selectedVehicle;
  final String category;
  final double weightKg;
  final int packages;
  final double goodsValue;
  final String pickupAddress;
  final double? pickupLatitude;
  final double? pickupLongitude;
  final String dropAddress;
  final String dropAddressSubtitle;
  final double? dropLatitude;
  final double? dropLongitude;
  final String receiverName;
  final String receiverPhone;
  final String houseNumber;

  int? get vehicleTypeId => selectedVehicle.id;

  String get vehicleName => selectedVehicle.name;
}
