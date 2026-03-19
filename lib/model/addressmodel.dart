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
   Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "city": city,
      "zip": zip,
      "country": country,
    };
  }

  // 🔥 Convert from Map
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      address: json["address"],
      city: json["city"],
      zip: json["zip"],
      country: json["country"],
    );
  }
}
