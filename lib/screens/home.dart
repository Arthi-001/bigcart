import 'package:bigcart/screens/product_detail.dart';
import 'package:bigcart/screens/search.dart';
import 'package:bigcart/screens/shopping_cart.dart';
import 'package:bigcart/widgets/categorieswidget.dart';
import 'package:bigcart/widgets/productcard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  List<Map<String, dynamic>> cartItems = [];
  Home({super.key, required this.cartItems});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Map<String, dynamic>> cartItems;

  @override
  void initState() {
    super.initState();
     cartItems = List.from(widget.cartItems);
    loadFavourites();
   // Load existing cart from Supabase
  }

  Future<void> addToCart(Map item) async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;
  if (user == null) return;

  // Check if item already exists
  final existing = await supabase
      .from('cart')
      .select()
      .eq('user_id', user.id)
      .eq('product_id', item['id']);

 if (existing.isNotEmpty) {
  // Convert text to int, increment, then back to text
  final oldQty = int.tryParse(existing[0]['qty'] ?? '0') ?? 0;
  final newQty = (oldQty + 1).toString();

  await supabase
      .from('cart')
      .update({'qty': newQty})
      .eq('user_id', user.id)
      .eq('product_id', item['id']);
} else {
  // Insert new item
  await supabase.from('cart').insert({
  'user_id': user.id,
  'product_id': item['id'],
  'name': item['name'],
  'price': item['price'],
  'image_url': item['image_url'],
  'qty':1,
  'unit': item['unit'],
});
}

  // Update local cartItems
  setState(() {
  int index = cartItems.indexWhere((e) => e['id'] == item['id']);
  if (index != -1) {
    final oldQty = int.tryParse(cartItems[index]['qty'] ?? '0') ?? 0;
    cartItems[index]['qty'] = (oldQty + 1).toString();
  } else {
    cartItems.add({
      'id': item['id'],
      'name': item['name'],
      'price': item['price'],
      'image_url': item['image_url'],
       'quantity': 1, 
       'unit': item['unit'],
    });
  }
});
}
  // Load favourite product IDs
  Set<String> favouriteIds = {};
  Future<void> loadFavourites() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final data = await supabase
        .from('favourites')
        .select('product_id')
        .eq('user_id', user.id);

    setState(() {
      favouriteIds =
          data.map<String>((item) => item['product_id'].toString()).toSet();
    });
  }

  // Load cart items from Supabase
  Future<void> loadCart() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final data = await supabase.from('cart').select().eq('user_id', user.id);

    setState(() {
      cartItems = data.map<Map<String, dynamic>>((item) {
        return {
          'id': item['product_id'],
          'name': item['name'],
          'price': item['price'],
          'image': item['image_url'],
          'qty': item['qty']?? 1,
          'unit': item['unit']?? '',
        };
      }).toList();
    });
  }

  // Fetch products
  Future<List<dynamic>> fetchProducts() async {
    final supabase = Supabase.instance.client;

    final data = await supabase.from('items').select();
    return data;
  }

  final List<Color> colors = [
    Colors.redAccent.shade100,
    Colors.greenAccent.shade100,
    Colors.green.shade100,
    Colors.red.shade100,
    Colors.blueGrey.shade100,
    Colors.yellowAccent.shade100,
  ];

  final PageController _controller = PageController();
  void onFavouriteToggle(Map product) {
  setState(() {
    product['isFavourite'] = !(product['isFavourite'] ?? false);
  });
}

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.07),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.05),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Search(),
                      ));
                },
                child: Container(
                  height: size.height * 0.07,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBEBEB),
                    border: Border.all(color: const Color(0xFFEBEBEB)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(size.width * 0.04),
                        child: const Icon(Icons.search_outlined),
                      ),
                      SizedBox(width: size.width * 0.02),
                      Text(
                        "Search keywords..",
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: size.width * 0.23),
                      Padding(
                        padding: EdgeInsets.all(size.width * 0.04),
                        child: const Icon(Icons.tune_outlined),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.05),
              child: Container(
                height: size.height * 0.28,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    PageView(
                      controller: _controller,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Stack(
                            children: [
                              Image.asset(
                                "assets/annie-spratt-R3LcfTvcGWY-unsplash.jpg",
                                fit: BoxFit.cover,
                                cacheWidth: 800,
                              ),
                              const Positioned(
                                left: 20,
                                bottom: 30,
                                child: Text(
                                  "20% OFF\nFresh Vegetables",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Stack(
                            children: [
                              Image.asset(
                                "assets/mario-raj-0sz-sfC_ekc-unsplash.jpg",
                                fit: BoxFit.cover,
                                cacheWidth: 800,
                              ),
                              const Positioned(
                                left: 20,
                                bottom: 30,
                                child: Text(
                                  "Fresh Grocery\nDelivered Fast",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Stack(
                            children: [
                              Image.asset(
                                "assets/anton-darius-FCrgmqqvl-w-unsplash.jpg",
                                fit: BoxFit.cover,
                                cacheWidth: 800,
                              ),
                              const Positioned(
                                left: 20,
                                bottom: 30,
                                child: Text(
                                  "30% OFF\nOrganic Fruits",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: const WormEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          dotColor: Colors.white,
                          activeDotColor: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Text(
                    "Categories",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(width: size.width * 0.5),
                const Icon(Icons.navigate_next_outlined,
                    color: Colors.black, size: 30)
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: CategoriesWidget(),
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Text(
                    "Featured Products",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(width: size.width * 0.31),
                const Icon(Icons.navigate_next_outlined,
                    color: Colors.black, size: 30)
              ],
            ),
            SizedBox(height: size.height * 0.02),
            FutureBuilder(
              future: fetchProducts(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final products = snapshot.data as List;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final item = products[index];
                    final product = products[index];

                    return ProductCard(
                      productId: product['id']?.toString() ?? "",
                      image: product['image_url']?.toString() ?? "",
                      name: product['name'] ?? "",
                      price: (product['price'] as num?)?.toDouble() ?? 0.0,
                      unit: product['unit'] ?? product['quantity'] ?? "",
                      bgColor: Colors.green.shade100,
                      isFavourite: favouriteIds
                          .contains(product['id']?.toString() ?? ""),
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
                      onAddToCart: () async {
                        await addToCart(item);
                       
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Added to cart")),
  );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}