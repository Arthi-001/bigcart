import 'package:bigcart/widgets/curvedcontainerclipper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductDetail extends StatefulWidget {
  final Map<String, dynamic> product;
  final bool isFavourite;
  final VoidCallback? onFavouriteToggle;

  const ProductDetail({
    super.key, 
    required this.product,
    required this.isFavourite,
    this.onFavouriteToggle});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int itemCount = 1;
 late bool isFavourite;

 Future<void> addToCart() async {
  try {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login to add items to cart')),
      );
      return;
    }
   final List<Map<String, dynamic>> insertedRows = await Supabase.instance.client
        .from('cart') // your cart table name
        .insert({
      'product_id': widget.product['id'], // assuming product has an id
      'name': widget.product['name'],
      'price': widget.product['price'],
      'image_url': widget.product['image_url'],
      'qty': itemCount, 
      'unit': widget.product['unit'] ?? '',
      'user_id': user.id,
      'created_at': DateTime.now().toIso8601String(),
    }).select();

    if (insertedRows.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add to cart')),
      );
    } else {
      // Insertion succeeded
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to cart!')),
      );
    }
  } catch (e) {
    // Exception (network, wrong table, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}

@override
void initState() {
  super.initState();
  isFavourite = widget.isFavourite; // ✅ sync from ProductCard
}

void toggleFavourite() {
  setState(() {
    isFavourite = !isFavourite;
  });
   if (widget.onFavouriteToggle != null) {
    widget.onFavouriteToggle!();
  }
}


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [

            /// 🔥 CURVED IMAGE CONTAINER (LIKE YOUR DRAWING)
            Container(height: size.height * 0.4 ,
              child: Stack(
                alignment: Alignment.center,
                children: [
              
                  ClipPath(
                    clipper: CurvedContainerClipper(),
                    child: Container(
                      height: size.height * 0.4,
                      width: double.infinity,
                      color: Colors.green.shade100,
                    ),
                  ),
              
                  /// 🖼 PRODUCT IMAGE
                  Center(
                    child: Positioned(
                      bottom: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Image.network(
                          widget.product['image_url'] ?? '',
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image, size: 80),
                        ),
                      ),
                    ),
                  ),
              
                  
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 📦 PRODUCT DETAILS
            Container(color: const Color(0xFFF4F5F9),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                   SizedBox(height: size.height*0.02),

                     Row(
                       children: [
                         Text(
                          "\$${widget.product['price']}",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                          ),
                         SizedBox(width: size.width*0.65,),
                        IconButton(
          icon: Icon(
            isFavourite ? Icons.favorite : Icons.favorite_border_outlined,
            color: isFavourite ? Colors.red : Colors.grey,
            size: 30,
          ),
          onPressed: toggleFavourite, // ✅ call internal toggle
        ),
      
                       ],
                     ),
              
                   SizedBox(height: size.height*0.0),
                    /// NAME
                    Text(
                      widget.product['name'] ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              
                   SizedBox(height: size.height*0.0),
              
                    /// UNIT (kg/lbs)
                    Text(
                      widget.product['unit'] ??
                          widget.product['quantity'] ??
                          '',
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade600,
                      ),
                    ),

                    Row(
                      children: [
                        Text("4.5", style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black,
                      ),),
                       SizedBox(width: size.width*0.01,),
                     Row(
  children: [
    Icon(Icons.star, color: Colors.orange),
    Icon(Icons.star, color: Colors.orange),
    Icon(Icons.star, color: Colors.orange),
    Icon(Icons.star, color: Colors.orange),

    
    Stack(
      children: [
        Icon(Icons.star_border, color: Colors.orange),
        ClipRect(
          clipper: HalfClipper(),
          child: Icon(Icons.star, color: Colors.orange),
        ),
      ],
    ),
  ],
),
Text("(89 reviews)", style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade700,)),

                      ],),

              
                     SizedBox(height: size.height*0.02),
              
                    /// DESCRIPTION
                    Text(
                    "Enjoy fresh, high-quality products sourced directly from trusted farms. Every item is carefully selected to ensure the best taste and nutrition, making it perfect for your daily meals and healthy lifestyle.",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
              
                    const SizedBox(height: 30),
                    Container(
                      width: size.width*0.9,
                             height: size.height*0.07,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
           Text(
            "Quantity",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
           SizedBox(width: size.width*0.4),
          // Remove icon
          InkWell(
            onTap: () {
              setState(() {
                if (itemCount > 0) itemCount--;
              });
            },
            child: const Icon(Icons.remove, color: Colors.green),
          ),
          const SizedBox(width: 8),
          // Divider
          Container(
            width: 1,
            height: 120,
            color: Colors.grey[400],
          ),
          SizedBox(width: size.width*0.03),
          // Item count
          Text(
            itemCount.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
           SizedBox(width: size.width*0.03),
          // Divider
          Container(
            width: 1,
            height: 120,
            color: Colors.grey[400],
          ),
          const SizedBox(width: 8),
          // Add icon
          InkWell(
            onTap: () {
              setState(() {
                itemCount++;
              });
            },
            child: const Icon(Icons.add, color: Colors.green),
          ),
        ],
      ),
    ),
              SizedBox(height: size.height*0.02),
                    /// 🛒 ADD TO CART BUTTON
                   Container(
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
                               onPressed: itemCount == 0 ? null : () {
                                addToCart();
                    },
  
                               style: ElevatedButton.styleFrom(
                                 backgroundColor: Colors.transparent,
                                 shadowColor: Colors.transparent,
                                 padding: const EdgeInsets.symmetric(vertical: 15),
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(30),
                                 ),
                               ),
                               child:
                                  Row(
                                    children: [
                                      SizedBox(width: size.width*0.33,),
                                      Text(
                                         "Add to cart",
                                         style: GoogleFonts.poppins(
                                           fontSize: 17,
                                           color: Colors.white,
                                           fontWeight: FontWeight.bold,
                                         ),
                                       ),
                                        SizedBox(width: size.width*0.17,),
                                        Icon(Icons.shopping_bag_outlined,color:Colors.white,size: 30,)
                                    ],
                                  ),
                                 
                               
                             ),
                           ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}
class HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width / 2, size.height); 
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}