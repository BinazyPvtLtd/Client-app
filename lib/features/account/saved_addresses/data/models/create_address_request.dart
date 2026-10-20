class CreateAddressRequest {
  const CreateAddressRequest({
    required this.label,
    required this.addressLine,
    required this.city,
    required this.state,
    required this.postalCode,
    this.latitude,
    this.longitude,
  });

  final String label;
  final String addressLine;
  final String city;
  final String state;
  final String postalCode;
  final double? latitude;
  final double? longitude;

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'address_line': addressLine,
      'city': city,
      'state': state,
      'postal_code': postalCode,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    };
  }
}
