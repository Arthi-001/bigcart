import 'package:flutter/material.dart';
import 'package:bigcart/model/ordermodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [];
  List<Order> get orders => _orders;

  bool _isFetching = false; // Prevent multiple simultaneous fetches

  Future<void> fetchOrders() async {
  if (_isFetching) return;
  _isFetching = true;

  final supabase = Supabase.instance.client;
  final currentUser = supabase.auth.currentUser;

  if (currentUser == null) {
    _isFetching = false;
    return;
  }

  try {
  
    final response = await supabase
        .from('orders')
        .select('id, user_id, total, item_count, placed, confirmed, shipped, out_for_delivery, delivered, items')
        .eq('user_id', currentUser.id)
        .order('placed', ascending: false);

    if (response.isEmpty) {
      _orders = [];
      notifyListeners();
      _isFetching = false;
      return;
    }

    final fetchedOrders = response.map<Order>((data) {
     
      List<Map<String, dynamic>> itemsList = [];
      if (data['items'] != null) {
        try {
          itemsList = List<Map<String, dynamic>>.from(data['items']);
        } catch (_) {}
      }

      return Order(
        orderId: data['id'].toString(),
        itemCount: data['item_count'] ?? itemsList.length,
        total: (data['total'] as num?)?.toDouble() ?? 0.0,
        statusDates: {
          "Order placed": data['placed'],
          "Order confirmed": data['confirmed'],
          "Order shipped": data['shipped'],
          "Out for delivery": data['out_for_delivery'],
          "Order delivered": data['delivered'],
        },
        items: itemsList,
      );
    })
    // Filter out any orders with empty items (just in case)
    .where((order) => order.items.isNotEmpty)
    .toList();

    // Deduplicate by orderId
    final map = {for (var o in fetchedOrders) o.orderId: o};
    _orders = map.values.toList();

    notifyListeners();
  } finally {
    _isFetching = false;
  }
}
  /// Update a single order safely
  void updateOrder(String orderId, Map<String, String?> statusDates) {
    final index = _orders.indexWhere((o) => o.orderId == orderId);
    if (index != -1) {
      _orders[index] = Order(
        orderId: _orders[index].orderId,
        itemCount: _orders[index].itemCount,
        total: _orders[index].total,
        statusDates: statusDates,
        items: _orders[index].items,
      );
      notifyListeners();
    }
  }
}