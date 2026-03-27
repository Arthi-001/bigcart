class CardModel {
  final String type; // Visa / MasterCard
  final String number;
  final String expiry;
  final String cvv;

  CardModel({
    required this.type,
    required this.number,
    required this.expiry,
    required this.cvv,
  });
}