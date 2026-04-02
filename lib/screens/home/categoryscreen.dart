
import 'package:bigcart/providers/home_provider.dart';
import 'package:bigcart/screens/home/product_detail.dart';
import 'package:bigcart/utils/color_utils.dart';
import 'package:bigcart/widgets/category_skeleton.dart';
import 'package:bigcart/widgets/productcard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
 

  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  
  
 

@override
void initState() {
  super.initState();
  final provider = Provider.of<HomeProvider>(context, listen: false);
   provider.clearCategoryProducts();

  provider.fetchCategoryProducts(widget.category);
  provider.loadFavourites();
}
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(widget.category,style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),),
      ),
      body: Consumer<HomeProvider>(
  builder: (context, provider, child) {
    if (provider.isLoading ) {
  return const CategorySkeleton();
}

    final products = provider.categoryProducts;

    if (products.isEmpty) {
      return Center(child: Text("No items found"));
    }

    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return ProductCard(
          productId: product['id']?.toString() ?? "",
          image: product['image_url'] ?? "",
          name: product['name'] ?? "",
          price: (product['price'] as num?)?.toDouble() ?? 0.0,
          unit: product['unit'] ?? "",
          bgColor: getPastelColor(product['id'].toString()),

          // ✅ favourite from provider
          isFavourite: provider.favouriteIds
              .contains(product['id'].toString()),

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetail(
                  product: product,
                  isFavourite: provider.favouriteIds
                      .contains(product['id'].toString()),
                  onFavouriteToggle: () {
                    provider.toggleFavourite(
                        product['id'].toString());
                  },
                ),
              ),
            );
          },

          // ✅ add to cart
          onAddToCart: () async {
            await provider.addToCart(product);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Added to cart")),
            );
          },

          // ✅ toggle favourite
          onFavouriteToggle: () async {
            provider.toggleFavourite(product['id'].toString());
          },
        );
      },
    );
  },
),
    );
  }
}

