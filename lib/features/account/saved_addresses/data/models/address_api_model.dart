class AddressApiModel {
  final String id;
  final String title;
  final String fullAddress;

  const AddressApiModel({
    required this.id,
    required this.title,
    required this.fullAddress,
  });

  factory AddressApiModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final id = json['id'];

    if (id == null) {
      throw const FormatException(
        'Address ID is missing',
      );
    }

    final title =
        (json['label'] ?? json['title'] ?? 'Other')
            .toString();

    final formattedAddress =
        json['formatted_address']?.toString().trim();

    String fullAddress;

    if (formattedAddress != null &&
        formattedAddress.isNotEmpty) {
      fullAddress = formattedAddress;
    } else {
      fullAddress = [
        json['address_line'],
        json['landmark'],
        json['city'],
        json['state'],
        json['pincode'] ?? json['postal_code'],
      ]
          .where(
            (value) =>
                value != null &&
                value.toString().trim().isNotEmpty,
          )
          .map((value) => value.toString().trim())
          .join(', ');
    }

    return AddressApiModel(
      id: id.toString(),
      title: title,
      fullAddress: fullAddress,
    );
  }
}