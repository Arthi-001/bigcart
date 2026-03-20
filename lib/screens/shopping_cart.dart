import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppingCart extends StatefulWidget {
  const  ShoppingCart ({super.key});

  @override
  State< ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State< ShoppingCart> {

  // This list will come from API later
  List<Map<String, dynamic>> cartItems = [];

  void increaseQty(int index) {
    setState(() {
      cartItems[index]['qty']++;
    });
  }

  void decreaseQty(int index) {
    setState(() {
      if (cartItems[index]['qty'] > 1) {
        cartItems[index]['qty']--;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(backgroundColor: Colors.white,
    elevation: 0,

    
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        Navigator.pop(context);
      },
    ),centerTitle: true,
        title:  Text("Shopping Cart",style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),),
        
      ),

      body: cartItems.isEmpty ? _emptyCart() : _cartList(),
    );
  }

  // ---------------- EMPTY CART ----------------
  Widget _emptyCart() {
    final Size size=MediaQuery.of(context).size;
    return Center(
      child: Column(
        
        children: [SizedBox(height: size.height*0.2),
          Icon(Icons.shopping_bag_outlined,
              size:size.height*0.15 , color: Colors.lightGreen),
          SizedBox(height: size.height*0.02),
      
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

  // ---------------- CART LIST ----------------
  Widget _cartList() {
    return Column(
      children: [

        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Row(
                    children: [

                      // Product Image
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.image),
                      ),

                      const SizedBox(width: 12),

                      // Name + Price
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'] ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "₹${item['price']}",
                              style: TextStyle(
                                  color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),

                      // Quantity controls
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => increaseQty(index),
                            child: const Icon(Icons.add, color: Colors.green),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Text("${item['qty']}"),
                          ),

                          GestureDetector(
                            onTap: () => decreaseQty(index),
                            child: const Icon(Icons.remove),
                          ),
                        ],
                      ),

                      const SizedBox(width: 10),

                      // Delete Button
                      GestureDetector(
                        onTap: () => removeItem(index),
                        child: Container(
                          height: 50,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // ---------------- TOTAL + BUTTON ----------------
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
                  const Text("Total",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("₹${_calculateTotal()}",
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),

              const SizedBox(height: 15),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Checkout"),
              )
            ],
          ),
        )
      ],
    );
  }

  double _calculateTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += item['price'] * item['qty'];
    }
    return total;
  }
}