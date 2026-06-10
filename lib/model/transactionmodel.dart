import 'package:intl/intl.dart';

class TransactionModel {
  final String name;
  final dynamic amount;
  final String method;
  final String date;

  TransactionModel({
    required this.name,
    required this.amount,
    required this.method,
    required this.date,
  });
  double get parsedAmount {
    if (amount is num) return amount.toDouble();

    return double.tryParse(
          amount.toString().replaceAll('\$', ''),
        ) ??
        0.0;
  }

   String get formattedDate {
  try {
    if (date.toString().isEmpty) {
      return "Date not available";
    }

    final parsed = DateTime.parse(date.toString());

    final formatted =
        DateFormat("MMMM dd yyyy 'at' hh.mm a").format(parsed);

    return formatted[0].toUpperCase() +
        formatted.substring(1)
            .replaceAll('AM', 'am')
            .replaceAll('PM', 'pm');
  } catch (e) {
    return "Date not available"; 
  }
}
  factory TransactionModel.fromMap(Map<String, dynamic> json) {
    return TransactionModel(
      name: json['name'],
      amount: json['amount'],
      method: json['method'] ?? '',
      date: json['date'] ?? '', 
    );
  }

}