import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppingCart extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  const  ShoppingCart ({super.key,required this.cartItems});

  @override
  State< ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State< ShoppingCart> {

  // This list will come from API later
   late List<Map<String, dynamic>> cartItems ;

   @override
void initState() {
  super.initState();
  cartItems = widget.cartItems;
}

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
    final Size size=MediaQuery.of(context).size;
    return Column(
      children: [

        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
int qty = item['qty'] ?? 1;


  
              return Dismissible(
             key: Key(item['name'] + index.toString()),

  direction: DismissDirection.endToStart, // 👉 swipe LEFT only

  // 🔴 Background (appears while swiping)
  background: Container(
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Icon(Icons.delete, color: Colors.white, size: 30),
  ),

  // 🎬 Smooth animation duration
  movementDuration: const Duration(milliseconds: 300),

  // 🔥 DELETE ACTION
  onDismissed: (direction) {
    final removedItem = cartItems[index];

    removeItem(index);

    // ✅ OPTIONAL: UNDO SNACKBAR
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${removedItem['name']} removed"),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
            setState(() {
              cartItems.insert(index, removedItem);
            });
          },
        ),
      ),
    );
  },

              child:Padding(
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  child: Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),

    child: Row(
      children: [

        // 🖼 PRODUCT IMAGE
        SizedBox(
  height: 80,
  width: 80,
  child: Stack(
    alignment: Alignment.topCenter,
    clipBehavior: Clip.none,
    children: [

      // 🔵 Background Circle
      Positioned(
        top: 15,
        child: ClipOval(
          child: Container(
            height: 60,
            width: 60,
            color: Colors.grey.shade200, // or dynamic color
          ),
        ),
      ),

      // 🖼️ Image popping out
      Positioned(
        top: -10,
        child: item['image'] != null &&
                item['image'].toString().startsWith('http')
            ? Image.network(
                item['image'],
                height: 70,
                fit: BoxFit.contain,
              )
            : const Icon(Icons.image, size: 40),
      ),
    ],
  ),
),

        const SizedBox(width: 12),

        // 📦 NAME + PRICE
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                "\$${item['price']} x $qty",
                 style:GoogleFonts.poppins (color: Colors.green),
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

              Text(item['quantity'] ?? '',
                style:  GoogleFonts.poppins(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 6),

              // 🔢 QUANTITY CONTROLS (HORIZONTAL)
              
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
      child: Text("${item['qty']}",style:  GoogleFonts.poppins(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w400,
                ),),
    ),

    GestureDetector(
      onTap: () => decreaseQty(index),
      child: const Icon(Icons.remove, color: Colors.green),
    ),
  ],
),

        // 🗑 DELETE BUTTON
       
      ],
    ),
  ),
));
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

               Positioned(
                           bottom: size.height * 0.1,
                           left: 20,
                           right: 20,
                           child: Container(
                             width: size.width*0.9,
                             height: size.height*0.07,
                             decoration: BoxDecoration(
                               gradient:  LinearGradient(
                                 colors: [
                                   const Color.fromARGB(255, 175, 245, 95),Colors.green
                                 ],
                                 begin: Alignment.topLeft,
                                 end: Alignment.bottomRight,
                               ),
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: ElevatedButton(
                               onPressed: () {},
                               style: ElevatedButton.styleFrom(
                                 backgroundColor: Colors.transparent,
                                 shadowColor: Colors.transparent,
                                 padding: const EdgeInsets.symmetric(vertical: 15),
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(30),
                                 ),
                               ),
                               child:
                                  Text(
                                     "Checkout",
                                     style: GoogleFonts.poppins(
                                       fontSize: 15,
                                       color: Colors.white,
                                       fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                 
                               
                             ),
                           ),
                         ),
            ],
          ),
        )
      ],
    );
  }

 double _calculateTotal() {
  double total = 0;

  for (var item in cartItems) {
    double price = double.tryParse(item['price'].toString()) ?? 0;
    int qty = item['qty'] ?? 1;

    total += price * qty;
  }

  return total;
}
}