class AddressRequest {
  final String label;
  final String addressLine;
  final String city;
  final String state;
  final String postalCode;
  final double latitude;
  final double longitude;

  const AddressRequest({
    required this.label,
    required this.addressLine,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'address_line': addressLine,
      'city': city,
      'state': state,
      'postal_code': postalCode,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}