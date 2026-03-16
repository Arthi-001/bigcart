import 'package:bigcart/widgets/categoryitem.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget({super.key});

  final List<Map<String, dynamic>> categories = [
    {"image": "assets/cabbage-removebg-preview.png", "title": "Vegetables" ,"color": Colors.green.shade100},
    {"image": "assets/apple-removebg-preview.png", "title": "Fruits", "color": Colors.red.shade100},
    {"image": "assets/lemonade-removebg-preview.png", "title": "Beverages", "color": Colors.yellow.shade100},
    {"image": "assets/shopping-bag-removebg-preview.png", "title": "Grocery", "color": Colors.pink.shade100},
    {"image": "assets/olive-oil-removebg-preview.png", "title": "Edible Oil", "color": Colors.blue.shade100},
    {"image": "assets/cleaning-products-removebg-preview.png", "title": "Household", "color": Colors.brown.shade100},
     {"image":  "assets/smile-removebg-preview.png", "title": "Babycare", "color": Colors.purple.shade100},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          return CategoryItem(
            image: categories[index]["image"]!,
            title: categories[index]["title"]!,
            bgColor:categories[index]["color"]!,
          );
        },
      ),
    );
  }
}