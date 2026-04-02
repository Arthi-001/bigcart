import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AccountSkeleton extends StatelessWidget {
  const AccountSkeleton({super.key});

  Widget box({double height = 20, double width = double.infinity}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: size.height * 0.15,
                color: Colors.white,
              ),
              Container(
                height: size.height * 0.75,
                color: const Color(0xFFF4F5F9),
              ),
            ],
          ),

          // 👤 Profile image
          Positioned(
            top: size.height * 0.1,
            left: size.width / 2.3 - 30,
            child: CircleAvatar(
              radius: size.width * 0.15,
              backgroundColor: Colors.grey,
            ),
          ),

          // 👤 Name + Email
          Positioned(
            top: size.height * 0.25,
            left: 0,
            right: 0,
            child: Column(
              children: [
                box(height: 15, width: 120),
                const SizedBox(height: 10),
                box(height: 12, width: 180),
              ],
            ),
          ),

          // 📋 Menu list
          Positioned(
            top: size.height * 0.32,
            left: 0,
            right: 0,
            child: Column(
              children: List.generate(
                7,
                (index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 24,
                        width: 24,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 20),
                      Expanded(child: box(height: 14)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}