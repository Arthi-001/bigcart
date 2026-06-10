import 'package:bigcart/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductCard extends StatefulWidget {
  final String image;
  final double  price;
  final String name;
  final String unit;
   final Color bgColor;
   final String productId;
    final bool isFavourite;
   final VoidCallback onAddToCart;
   final VoidCallback? onFavouriteToggle;
   final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.image,
    required this.price,
    required this.name,
    required this.unit,
    required this.bgColor,
    required this.onAddToCart,
    required this.productId,
    this.isFavourite= false,
    this.onFavouriteToggle,
    required this.onTap});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavourite = false; 
  @override
void initState() {
  super.initState();
  isFavourite = widget.isFavourite; 
}// track favourite state

  void toggleFavourite() async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;
  if (user == null) return;

  // Toggle local icon immediately
  setState(() {
    isFavourite = !isFavourite;
  });

  if (isFavourite) {
    // Add to favourites in Supabase
    await supabase.from('favourites').insert({
      'user_id': user.id,
      'product_id': widget.productId,
    });
  } else {
    // Remove from favourites in Supabase
    await supabase
        .from('favourites')
        .delete()
        .eq('user_id', user.id)
        .eq('product_id', widget.productId);

    // Notify parent to remove from list
    widget.onFavouriteToggle?.call();
  }
}
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Stack(
  children: [
    
    GestureDetector(onTap: widget.onTap,
      child: Container(
        width: size.width * 0.42,
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
       
            SizedBox(
              height: size.width * 0.28,
              width: size.width * 0.28,
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: size.width * 0.04,
                    bottom: size.height * 0.02,
                    child: ClipOval(
                      child: Container(
                        height: size.width * 0.23,
                        width: size.width * 0.23,
                        color: widget.bgColor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -size.width * 0.04,
                    child: 
                      widget.image.isNotEmpty
            ? Image.network(
          widget.image,
          height: size.width * 0.35,
          fit: BoxFit.contain,
        )
            : Icon(
          Icons.image_not_supported,
          size: size.width * 0.2,
          color: Colors.grey,
        ),
                    
                  ),
                ],
              ),
            ),
        
            SizedBox(height: size.height * 0.01),
        
            Text( "\$${widget.price.toStringAsFixed(2)}",
                style: AppTextStyles.greenText),
        
            SizedBox(height: size.height * 0.01),
        
            Text(widget.name,
                style: AppTextStyles.bold),
        
            SizedBox(height: size.height * 0.01),
        
            Text(widget.unit,
                style: AppTextStyles.body),
        
            SizedBox(height: size.height * 0.01),
            Divider(),
            SizedBox(height: size.height * 0.01),
        
            GestureDetector(
              onTap: () {
                widget.onAddToCart();
               
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined,
                      color: Colors.lightGreen),
                  SizedBox(width: 5),
                  Text("Add to cart"),
                ],
              ),
            ),
          ],
        ),
      ),
    ),

    Positioned(
      top: 10,
      right: 15,
      child: GestureDetector(
        onTap: toggleFavourite,
        child: IconButton(
  icon: Icon(
    isFavourite ? Icons.favorite : Icons.favorite_border_outlined,
    color: isFavourite ? Colors.red : Colors.grey,
    size: 20,
  ),
  onPressed: toggleFavourite, 
),
      ),
    ),
  ],
);
  }
}