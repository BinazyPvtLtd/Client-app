class VehicleTypeModel {
  const VehicleTypeModel({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.capacity,
  });

  final int id;
  final String name;
  final String? description;
  final String? imageUrl;
  final String? capacity;

  factory VehicleTypeModel.fromJson(Map<String, dynamic> json) {
    return VehicleTypeModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description']?.toString(),
      imageUrl: json['image_url']?.toString(),
      capacity: json['capacity']?.toString(),
    );
  }
}
