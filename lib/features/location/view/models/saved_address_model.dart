class SavedAddressModel {
  final String id;
  final String title;
  final String subtitle;
  final String? tag;

  const SavedAddressModel({
    required this.id,
    required this.title,
    required this.subtitle,
    this.tag,
  });
}
