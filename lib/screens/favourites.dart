import 'package:bigcart/screens/product_detail.dart';
import 'package:bigcart/widgets/productcard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  Set<String> favouriteIds = {};
  List<dynamic> items = []; // store fetched favourites
 Future<void> loadFavourites() async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;
  if (user == null) return;

  final data = await supabase
      .from('favourites')
      .select('items(*)')
      .eq('user_id', user.id);

  setState(() {
    items = data;
  });
}
  @override
void didChangeDependencies() {
  super.didChangeDependencies();
 loadFavourites();
}
Future<void> removeFavourite(String productId, int index) async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;

  if (user == null) return;

  await supabase
      .from('favourites')
      .delete()
      .eq('user_id', user.id)
      .eq('item_id', productId);

   setState(() {
    items.removeAt(index);
  });// 🔥 refresh UI
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

      body: items.isEmpty
    ? Center(
        child: Text(
          "No favourites yet",
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      )

          :Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                final item = items[index]['items']; // ✅ MUST BE HERE

                
                 final product = Map<String, dynamic>.from(item); 
                print(item['product_quantity']);
                print(items[index]);

                return ProductCard(
   productId: item['id']?.toString() ?? "",
  image: item['image_url'] ?? "",
  name: item['name'] ?? "",
  price: (item['price'] as num?)?.toDouble() ?? 0.0,
  unit: product['unit'] ?? product['quantity'] ?? "",
  bgColor: Colors.green.shade100,
  isFavourite: true,
  onTap: () {
    final productWithFav = Map<String, dynamic>.from({
    ...product, // spread original map
    'isFavourite': favouriteIds.contains(product['id']?.toString() ?? "")
  });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetail(product: productWithFav,
         isFavourite: productWithFav['isFavourite'],
        onFavouriteToggle: () => onFavouriteToggle(productWithFav), ),
      ),
    );
  },
  onAddToCart: () {},
  onFavouriteToggle: () {
   setState(() {
      items.removeAt(index); // ✅ remove from local list
    }); // remove instantly
  },
);
              },
            ),
          ));
        }
      
    
  }
