
import 'package:bigcart/providers/favourites_provider.dart';
import 'package:bigcart/screens/home/product_detail.dart';
import 'package:bigcart/utils/color_utils.dart';
import 'package:bigcart/widgets/favourites_skeleton.dart';
import 'package:bigcart/widgets/productcard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  
   Favourites({super.key,});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  
   
  @override
void initState() {
  super.initState();
 Future.microtask(() {
    final provider =
        Provider.of<FavouritesProvider>(context, listen: false);

    provider.clearFavourites();   // ✅ first clear
    provider.loadFavourites();    // ✅ then fetch
  });
}

void onFavouriteToggle(Map product) {
  setState(() {
    product['isFavourite'] = !(product['isFavourite'] ?? false);
  });
}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: Text(
          "My Favourites",
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Consumer<FavouritesProvider>(
  builder: (context, provider, child) {

    if (provider.isLoading) {
  return const FavouritesSkeleton();
}
    if (provider.items.isEmpty) {
      return Center(
        child: Text(
          "No favourites yet",
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: provider.items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (context, index) {
          final item = provider.items[index]['items'];
          final product = Map<String, dynamic>.from(item);

          return ProductCard(
            productId: item['id']?.toString() ?? "",
            image: item['image_url'] ?? "",
            name: item['name'] ?? "",
            price: (item['price'] as num?)?.toDouble() ?? 0.0,
            unit: product['unit'] ?? "",
            bgColor: getPastelColor(product['id'].toString()),
            isFavourite: true,

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetail(
                    product: product,
                    isFavourite: true,
                    onFavouriteToggle: () {},
                  ),
                ),
              );
            },

            // ✅ ADD TO CART
            onAddToCart: () async {
              await provider.addToCart(item);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Added to cart")),
              );
            },

            // ✅ REMOVE FAVOURITE
            onFavouriteToggle: () async {
              await provider.removeFavourite(
                  product['id'].toString(), index);
            },
          );
        },
      ),
    );
  },
),);
        }
      
    
  }
