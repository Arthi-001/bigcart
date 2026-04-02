import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategorySkeleton extends StatelessWidget {
  const CategorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🖼 Image skeleton
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                const SizedBox(height: 10),

                // 📦 Name
                Container(
                  height: 10,
                  width: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.grey,
                ),

                const SizedBox(height: 8),

                // 💰 Price
                Container(
                  height: 10,
                  width: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.grey,
                ),

                const Spacer(),

                // ➕ Button placeholder
                Container(
                  height: 30,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}