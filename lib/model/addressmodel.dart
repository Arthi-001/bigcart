class AddressModel {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String zip;
  final String country;

  AddressModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.zip,
    required this.country,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'] ?? '',
        address: json['address'] ?? '',
        city: json['city'] ?? '',
        zip: json['zip'] ?? '',
        country: json['country'] ?? '',
      );
}