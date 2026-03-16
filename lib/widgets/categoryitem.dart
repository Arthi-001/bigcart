import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItem extends StatelessWidget {
  final String image;
  final String title;
  final Color bgColor;

  const CategoryItem({
    super.key,
    required this.image,
    required this.title,
    required this.bgColor
  });

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    
    final double containerSize = size.width * 0.15; 
    final double imageSize = containerSize * 0.5;   
    final double textSize = size.width * 0.035;
     final double spacing = size.height * 0.007;   
    return Column(
       mainAxisSize: MainAxisSize.min, 
      children: [
        ClipOval(
          child: Container(
            height: containerSize,
            width: containerSize,
            color: bgColor,
            child: Center(
              child: Image.asset(
                image,
                height: imageSize,
              ),
            ),
          ),
        ),
         SizedBox(height: spacing),
        Flexible(
          child: Text(
            title,
            style: GoogleFonts.poppins(fontSize: textSize),
             maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}