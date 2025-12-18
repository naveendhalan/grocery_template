class AddressEntity {
  final String id;
  final String title;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String pincode;
  final String phone;
  final bool isDefault;

  const AddressEntity({
    required this.id,
    required this.title,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.pincode,
    required this.phone,
    this.isDefault = false,
  });

  String get fullAddress =>
      '$addressLine1, $addressLine2, $city, $state - $pincode';
}
