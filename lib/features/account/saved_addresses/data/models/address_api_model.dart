class AddressApiModel {
  const AddressApiModel({
    required this.id,
    required this.title,
    required this.fullAddress,
  });

  final String id;
  final String title;
  final String fullAddress;

  factory AddressApiModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final title = json['title'];
    final fullAddress = json['full_address'];

    if (id == null ||
        id.toString().trim().isEmpty ||
        title is! String ||
        title.trim().isEmpty ||
        fullAddress is! String ||
        fullAddress.trim().isEmpty) {
      throw const FormatException('Invalid address data');
    }

    return AddressApiModel(
      id: id.toString(),
      title: title,
      fullAddress: fullAddress,
    );
  }
}
