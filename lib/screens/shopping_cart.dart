import 'package:bigcart/screens/orderscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShoppingCart extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  const ShoppingCart({super.key, required this.cartItems});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  late List<Map<String, dynamic>> cartItems=[];

  @override
  void initState() {
    super.initState();
    loadCartFromDB(); 
  }

  // ---------------- INCREASE QUANTITY ----------------
  void increaseQty(int index) async {
    setState(() {
      cartItems[index]['qty'] = (cartItems[index]['qty'] ?? 1) + 1;
    });

    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase
        .from('cart')
        .update({'unit': cartItems[index]['qty']})
        .eq('user_id', user.id)
        .eq('product_id', cartItems[index]['id']);
  }

  // ---------------- DECREASE QUANTITY ----------------
  void decreaseQty(int index) async {
    if (cartItems[index]['qty'] <= 1) return;

    setState(() {
      cartItems[index]['qty']--;
    });

    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase
        .from('cart')
        .update({'unit': cartItems[index]['qty'].toString()})
        .eq('user_id', user.id)
        .eq('product_id', cartItems[index]['id']);
  }

  // ---------------- REMOVE ITEM ----------------
  void removeItem(int index) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase
        .from('cart')
        .delete()
        .eq('user_id', user.id)
        .eq('product_id', cartItems[index]['id']);

    setState(() {
      cartItems.removeAt(index);
    });
    loadCartFromDB();
  }
  Future<void> loadCartFromDB() async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;
  if (user == null) return;

  final data = await supabase.from('cart').select().eq('user_id', user.id);

  setState(() {
    cartItems = data.map<Map<String, dynamic>>((item) {
      return {
        'id': item['product_id'],
        'name': item['name'],
        'price': (item['price'] as num?)?.toDouble() ?? 0.0,
        'image_url': item['image_url'],
        'unit':item['unit'],
        'qty': int.tryParse(item['quantity'] ?? '1') ?? 1,
      };
    }).toList();
  });
}

  // ---------------- TOTALS ----------------
  double _calculateSubtotal() {
    double total = 0;
    for (var item in cartItems) {
      double price = (item['price'] as num?)?.toDouble() ?? 0.0;
total += price * (item['qty'] ?? 1);
    }
    return total;
  }

  double _shippingCharge() {
    double subtotal = _calculateSubtotal();
    return subtotal > 500 ? 0 : 50;
  }

  double _calculateTotal() {
    return _calculateSubtotal() + _shippingCharge();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Shopping Cart",
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: cartItems.isEmpty ? _emptyCart() : _cartList(),
    );
  }

  Widget _emptyCart() {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.2),
          Icon(Icons.shopping_bag_outlined,
              size: size.height * 0.15, color: Colors.lightGreen),
          SizedBox(height: size.height * 0.02),
          Text(
            "Your cart is empty!",
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "You will get a response within a few minutes",
            style: GoogleFonts.poppins(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _cartList() {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              int qty = item['qty'] ?? 1;

              return Dismissible(
                key: Key(item['id'].toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.delete, color: Colors.white, size: 30),
                ),
                onDismissed: (direction) => removeItem(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.network(
                            item['image_url'] ?? '',
  errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.image); // shows placeholder if image fails
  },
)
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\$${item['price']} x $qty",
                                style: GoogleFonts.poppins(color: Colors.green),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['name'] ?? '',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(item['unit'] ?? '',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => increaseQty(index),
                              child: const Icon(Icons.add, color: Colors.green),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                "$qty",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => decreaseQty(index),
                              child: const Icon(Icons.remove, color: Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subtotal", style: GoogleFonts.poppins(color: Colors.grey.shade700)),
                  Text("\$${_calculateSubtotal().toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(color: Colors.grey.shade700)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping", style: GoogleFonts.poppins(color: Colors.grey.shade700)),
                  Text("\$${_shippingCharge().toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(color: Colors.grey.shade700)),
                ],
              ),
              Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total",
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("\$${_calculateTotal()}",
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                width: size.width * 0.9,
                height: size.height * 0.07,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color.fromARGB(255, 175, 245, 95), Colors.green],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderScreen(),
      ),
    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Checkout",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}