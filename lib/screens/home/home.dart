
import 'package:bigcart/providers/home_provider.dart';
import 'package:bigcart/screens/home/categoryscreen.dart';
import 'package:bigcart/screens/home/product_detail.dart';
import 'package:bigcart/screens/home/search.dart';
import 'package:bigcart/utils/app_text_styles.dart';
import 'package:bigcart/utils/color_utils.dart';
import 'package:bigcart/widgets/categorieswidget.dart';
import 'package:bigcart/widgets/home_skeleton.dart';
import 'package:bigcart/widgets/productcard.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Home extends StatefulWidget {
  
  Home({super.key, });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_){
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.clearHomeProducts();
    provider.fetchProducts();
    provider.loadFavourites();});
   
  }
 

  
  void onFavouriteToggle(Map product) {
  setState(() {
    product['isFavourite'] = !(product['isFavourite'] ?? false);
  });
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(backgroundColor: const Color(0xFFF4F5F9) ,
      body: Consumer<HomeProvider>(
  builder: (context, provider, child) {
    final Size size = MediaQuery.of(context).size;

    // ✅ FULL SCREEN SKELETON
    if (provider.isLoading ) {
      return const HomeSkeleton();
    }

    // ✅ REAL UI
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.02),

            // 🔍 SEARCH BAR
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.02),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Search()),
                  );
                },
                child: Container(
                  height: size.height * 0.07,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBEBEB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(size.width * 0.04),
                        child: const Icon(Icons.search_outlined),
                      ),
                      Text("Search keywords..",
                          style: AppTextStyles.body),
                      const Spacer(),
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

            // 🎯 CAROUSEL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: size.height * 0.20,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration:
                      const Duration(milliseconds: 800),
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                ),
                items: [
                  {
                    "image":
                        "assets/randy-fath-5aJVJvJ9rG8-unsplash.jpg",
                    "text": "20% OFF\nFresh Vegetables"
                  },
                  {
                    "image":
                        "assets/annie-spratt-R3LcfTvcGWY-unsplash.jpg",
                    "text": "Sip the refreshment"
                  },
                  {
                    "image":
                        "assets/babak-eshaghian-QsBEQHziaDw-unsplash.jpg",
                    "text": "Essentials for\neveryday comfort"
                  },
                  {
                    "image":
                        "assets/david-foodphototasty-JJcT6VJWDlg-unsplash.jpg",
                    "text": "Buy Quality\nFresh Dairy Products"
                  },
                  {
                    "image":
                        "assets/anton-darius-FCrgmqqvl-w-unsplash.jpg",
                    "text": "Fresh Grocery\nDelivered Fast"
                  },
                  {
                    "image":
                        "assets/natracare-0a1GDxcIg3o-unsplash.jpg",
                    "text": "Gentle care\nfor tiny smiles"
                  }
                ].map((item) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          item["image"]!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          cacheWidth: 800,
                        ),
                      ),
                      Positioned(
                        left: 20,
                        bottom: 30,
                        child: Text(item["text"]!,
                            style: AppTextStyles.whiteText),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: size.height * 0.02),

            // 📂 CATEGORIES
            Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Text("Categories",
                      style: AppTextStyles.title),
                ),
                const Spacer(),
                const Icon(Icons.navigate_next_outlined),
              ],
            ),

            SizedBox(height: size.height * 0.02),

            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: CategoriesWidget(
                onCategoryTap: (category) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          CategoryScreen(category: category),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: size.height * 0.02),

            // 🛒 PRODUCTS
            Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Text("Featured Products",
                      style: AppTextStyles.title),
                ),
                const Spacer(),
                const Icon(Icons.navigate_next_outlined),
              ],
            ),

            SizedBox(height: size.height * 0.02),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: provider.products.length,
              itemBuilder: (context, index) {
                final product = provider.products[index];

                return ProductCard(
                  productId: product['id']?.toString() ?? "",
                  image: product['image_url'] ?? "",
                  name: product['name'] ?? "",
                  price:
                      (product['price'] as num?)?.toDouble() ?? 0.0,
                  unit: product['unit'] ?? "",
                  bgColor:
                      getPastelColor(product['id'].toString()),

                  isFavourite: provider.favouriteIds
                      .contains(product['id']?.toString() ?? ""),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetail(
                          product: product,
                          isFavourite: provider.favouriteIds
                              .contains(product['id']
                                  ?.toString() ??
                                  ""),
                          onFavouriteToggle: () {
                            provider.toggleFavourite(
                                product['id'].toString());
                          },
                        ),
                      ),
                    );
                  },

                  onAddToCart: () async {
                    await provider.addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Added to cart")),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  },
),
    );
  }
}