import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductCard extends StatefulWidget {
  final String image;
  final String price;
  final String name;
  final String quantity;
   final Color bgColor;
   final VoidCallback onAddToCart;

  const ProductCard({super.key,required this.image,required this.price,required this.name,required this.quantity,required this.bgColor,required this.onAddToCart});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavourite = false; // track favourite state

  void toggleFavourite() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) return;

    setState(() {
      isFavourite = !isFavourite;
    });

    if (isFavourite) {
      // ✅ Add to favourites table
      await supabase.from('favourites').insert({
        'user_id': user.id,
        'product_name': widget.name,
        'product_image': widget.image,
        'product_price': widget.price,
      });
    } else {
      // ✅ Remove from favourites table
      await supabase
          .from('favourites')
          .delete()
          .eq('user_id', user.id)
          .eq('product_name', widget.name);
    }
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Container(
      width: size.width*0.1,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          /// Image Container
            SizedBox(
              height: size.width * 0.28,
              width: size.width * 0.28,
              child: Stack( alignment: Alignment.topCenter,clipBehavior: Clip.none, 
                children: [
                  Positioned(
                     left: size.width * 0.04,
                     bottom: size.height*0.02,
                  child:
                    ClipOval(
                     child: 
                       Container(
                            height: size.width * 0.23,
                            width: size.width * 0.23, 
                            color: widget.bgColor,)),
                  ),
                Positioned( 
                  top: -size.width * 0.04, // 👈 pop out
                  child: Image.network(
                    widget.image,  height: size.width * 0.35,fit: BoxFit.contain)),
                    








                    
        ]),
            ),
         
         SizedBox(height: size.height*0.01),

          /// Product Name Placeholder
            Text(widget.price,style: GoogleFonts.poppins(fontSize: 12,color: Colors.lightGreen),),

          SizedBox(height: size.height*0.01),

          /// Price Placeholder
         Text(widget.name,style: GoogleFonts.poppins(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),

         SizedBox(height: size.height*0.01),

          /// Add to Cart / Quantity Area
          Text(widget.quantity,style: GoogleFonts.poppins(fontSize: 12,color: Colors.grey.shade700),),
          
          SizedBox(height: size.height*0.01),
          Divider(),
          SizedBox(height: size.height*0.01),
          GestureDetector(
  onTap: () {
    widget.onAddToCart();
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Added to cart"),
      duration: Duration(seconds: 1),
    ),
  );
  },
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.shopping_bag_outlined, color: Colors.lightGreen),
      SizedBox(width: 5),
      Text("Add to cart"),
    ],
  ),
)
        ],
      ),
    );
  }
}