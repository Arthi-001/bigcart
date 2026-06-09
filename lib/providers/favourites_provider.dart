import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavouritesProvider extends ChangeNotifier {
  List<dynamic> items = [];
  bool isLoading = false;

  Future<void> loadFavourites() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) return;

    isLoading = true;
    notifyListeners();

    final data = await supabase
        .from('favourites')
        .select('items(*)')
        .eq('user_id', user.id);

    items = data;

    isLoading = false;
    notifyListeners();
  }

  Future<void> removeFavourite(String productId, int index) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) return;

    await supabase
        .from('favourites')
        .delete()
        .eq('user_id', user.id)
        .eq('item_id', productId);

    items.removeAt(index);
    notifyListeners();
  }
  void clearFavourites() {
  items = [];
  notifyListeners();
}

  Future<void> addToCart(Map item) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final existing = await supabase
        .from('cart')
        .select()
        .eq('user_id', user.id)
        .eq('product_id', item['id']);

    if (existing.isNotEmpty) {
      final oldQty = existing[0]['qty'] ?? 0;

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
  }
}