class VehicleModel {
  final String name;
  final String price;
  final String maxWeight;
  final String arriving;
  final String image;
  final String? offer;

  const VehicleModel({
    required this.name,
    required this.price,
    required this.maxWeight,
    required this.arriving,
    required this.image,
    this.offer,
  });
}