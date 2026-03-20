import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextContainer extends StatelessWidget {
  
   final List<String> items;

  const TextContainer({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10, // space between containers horizontally
  runSpacing: 10, 
      children:  List.generate( items.length,
    (index) =>Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          color: Colors.white,
         
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            items[index],
            style: GoogleFonts.poppins(color:Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ));
  }
}