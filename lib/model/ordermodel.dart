class Order {
  final String orderId;
  final int itemCount;
  final double total;
  final Map<String, String?> statusDates; 
   final List<dynamic> items; 

  Order({
    required this.orderId,
    required this.itemCount,
    required this.total,
    required this.statusDates,
    required this.items
  });
}