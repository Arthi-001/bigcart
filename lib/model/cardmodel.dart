class CardModel {
  final int? id;
  final String type;
  final String last4;
  final String expiry;

  CardModel({
    this.id,
    required this.type,
    required this.last4,
    required this.expiry,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      type: json['card_type'] ?? '',
      last4: json['card_last4'] ?? '',
      expiry: json['expiry'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'card_type': type,
      'card_last4': last4,
      'expiry': expiry,
    };
  }
}