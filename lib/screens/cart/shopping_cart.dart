
import 'package:bigcart/providers/cart_provider.dart';
import 'package:bigcart/providers/orderprovider.dart';
import 'package:bigcart/screens/cart/orderscreen.dart';
import 'package:bigcart/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatefulWidget {
  
  const ShoppingCart({super.key, });

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<CartProvider>(context, listen: false).loadCart();
  });
  }

  
@override
  Widget build(BuildContext context) {

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
          style: AppTextStyles.title
        ),
      ),
      body:  Consumer<CartProvider>(
  builder: (context, provider, child) {
    if (provider.cartItems.isEmpty) {
      return _emptyCart();
    }

    return _cartList(provider);
  },
),
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
            style:AppTextStyles.body,
          ),
          const SizedBox(height: 10),
          Text(
            "You will get a response within a few minutes",
            style: AppTextStyles.body,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _cartList(CartProvider provider) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: provider.cartItems.length,
            itemBuilder: (context, index) {
              final item = provider.cartItems[index];
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
                onDismissed: (direction) => provider.removeItem(index),
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
                                style: AppTextStyles.green,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['name'] ?? '',
                                style: AppTextStyles.bold
                              ),
                              const SizedBox(height: 4),
                              Text(item['unit'] ?? '',
                                  style: AppTextStyles.body),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => provider.increaseQty(index),
                              child: const Icon(Icons.add, color: Colors.green),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                "$qty",
                                style: AppTextStyles.body 
                              ),
                            ),
                            GestureDetector(
                              onTap: () => provider.decreaseQty(index),
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
                  Text("\$${provider.subtotal}",
                      style:  AppTextStyles.body),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping", style: GoogleFonts.poppins(color: Colors.grey.shade700)),
                  Text("\$${provider.shipping}",
                      style:  AppTextStyles.body),
                ],
              ),
              Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total",
                      style:  AppTextStyles.bold),
                  Text("\$${provider.total}",
                      style:  AppTextStyles.bold),
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
                   onPressed: () async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    // Place order and clear cart
    await cartProvider.placeOrder();
     await cartProvider.loadCart();

    // Fetch updated orders for OrdersScreen
    await Provider.of<OrdersProvider>(context, listen: false).fetchOrders();

    if (!mounted) return;

    // Navigate to OrdersScreen
    Navigator.pushReplacement(
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
                    style:  AppTextStyles.whiteText
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