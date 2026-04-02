import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeProvider extends ChangeNotifier {
  List<Map<String, dynamic>> cartItems = [];
  Set<String> favouriteIds = {};
  List<dynamic> products = [];
  bool isLoading = false;

  final supabase = Supabase.instance.client;

  // ✅ Load products
  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    final data = await supabase.from('items').select();

    products = data;
    isLoading = false;
    notifyListeners();
  }
  void clearCategoryProducts() {
  categoryProducts = [];
  notifyListeners();
}
void clearHomeProducts() {
  products = [];
  notifyListeners();
}

  // ✅ Load favourites
  Future<void> loadFavourites() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final data = await supabase
        .from('favourites')
        .select('product_id')
        .eq('user_id', user.id);

    favouriteIds =
        data.map<String>((item) => item['product_id'].toString()).toSet();

    notifyListeners();
  }

  // ✅ Add to cart
  Future<void> addToCart(Map item) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final existing = await supabase
        .from('cart')
        .select()
        .eq('user_id', user.id)
        .eq('product_id', item['id']);

    if (existing.isNotEmpty) {
      final oldQty = int.tryParse(existing[0]['qty'] ?? '0') ?? 0;
      final newQty = (oldQty + 1).toString();

      await supabase
          .from('cart')
          .update({'qty': newQty})
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

    notifyListeners();
  }

  // ✅ Toggle favourite
  void toggleFavourite(String productId) {
    if (favouriteIds.contains(productId)) {
      favouriteIds.remove(productId);
    } else {
      favouriteIds.add(productId);
    }
    notifyListeners();
  }
  List<dynamic> categoryProducts = [];

Future<void> fetchCategoryProducts(String category) async {
  isLoading = true;
  notifyListeners();

  final data = await supabase
      .from('items')
      .select()
      .eq('category', category);

  categoryProducts = data;

  isLoading = false;
  notifyListeners();
}
}