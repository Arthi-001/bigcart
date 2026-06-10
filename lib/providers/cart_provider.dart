import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> cartItems = [];
   bool _isPlacingOrder=false;
  final supabase = Supabase.instance.client;

 
  Future<void> loadCart() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final data =
        await supabase.from('cart').select().eq('user_id', user.id);

    cartItems = data.map<Map<String, dynamic>>((item) {
      return {
        'id': item['product_id'],
        'name': item['name'],
        'price': (item['price'] as num?)?.toDouble() ?? 0.0,
        'image_url': item['image_url'],
        'unit': item['unit'],
        'qty': int.tryParse(item['qty']?.toString() ?? '1') ?? 1,
      };
    }).toList();

    notifyListeners();
  }

  
  Future<void> addToCart(Map item) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final existing = await supabase
        .from('cart')
        .select()
        .eq('user_id', user.id)
        .eq('product_id', item['id']);

    if (existing.isNotEmpty) {
      final oldQty =
          int.tryParse(existing[0]['qty']?.toString() ?? '0') ?? 0;

      await supabase
          .from('cart')
          .update({'qty': oldQty + 1})
          .eq('user_id', user.id)
          .eq('product_id', item['id']);
    } else {
      await supabase.from('cart').insert({
        'user_id': user.id,
        'product_id': item['id'],
        'name': item['name'],
        'price': item['price'],
        'image_url': item['image_url'],
        'qty': 1,
        'unit': item['unit'],
      });
    }

    await loadCart(); 
  }
  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }
  Future<void> placeOrder() async {
  if (_isPlacingOrder) return;
  if (cartItems.isEmpty) return;

  _isPlacingOrder = true;

  final supabase = Supabase.instance.client;
  final currentUser = supabase.auth.currentUser;

  try {
    final itemsData = cartItems.map((item) {
      return {
        "name": item['name'],
        "price": item['price'],
        "quantity": item['qty'],
        "unit": item['unit'],
        "image": item['image_url'],
      };
    }).toList();

    await supabase.rpc('create_order_with_items', params: {
      'p_user_id': currentUser!.id,
      'p_items': itemsData,
    });

    await supabase.from('transactions').insert({
  'user_id': currentUser.id,
  'amount': totalAmount, // make sure you have this
  'method': 'Card', // or dynamic (UPI, PayPal, etc.)
 'date': DateTime.now().toIso8601String(),
});


    
    await supabase
        .from('cart')
        .delete()
        .eq('user_id', currentUser.id);
    
    await supabase
    .from('cart')
    .select()
    .eq('user_id', currentUser.id);

    clearCart();

  } catch (e) {
  } finally {
    _isPlacingOrder = false;
  }
}
  
 
  Future<void> increaseQty(int index) async {
    cartItems[index]['qty']++;

    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase
        .from('cart')
        .update({'qty': cartItems[index]['qty']})
        .eq('user_id', user.id)
        .eq('product_id', cartItems[index]['id']);

    notifyListeners();
  }

  
  Future<void> decreaseQty(int index) async {
    if (cartItems[index]['qty'] <= 1) return;

    cartItems[index]['qty']--;

    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase
        .from('cart')
        .update({'qty': cartItems[index]['qty']})
        .eq('user_id', user.id)
        .eq('product_id', cartItems[index]['id']);

    notifyListeners();
  }

  
  Future<void> removeItem(int index) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase
        .from('cart')
        .delete()
        .eq('user_id', user.id)
        .eq('product_id', cartItems[index]['id']);

    cartItems.removeAt(index);
    notifyListeners();
  }

  int get totalItems {
    int count = 0;
    for (var item in cartItems) {
      count += item['qty'] as int;
    }
    return count;
  }
  double get totalAmount {
  double total = 0;

  for (var item in cartItems) {
    total += (item['price'] * item['qty']);
  }

  return total;
}

  double get subtotal {
    double total = 0;
    for (var item in cartItems) {
      total += (item['price'] * item['qty']);
    }
    return total;
  }

  double get shipping => subtotal > 500 ? 0 : 50;

  double get total => subtotal + shipping;
}