import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Headers extends StatelessWidget {
  final String title;
  const Headers({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(height: size.height * 0.15,   // give height
      color: const Color(0xFFF4F5F9),
      child: Stack(children: [
        Positioned(
            top: size.height * 0.025,
            left: 10,
            right: 10,
            child: Row(
              children: [
      
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
      
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
      
                 SizedBox(width:size.width*0.04) 
              ],
            ),
          ),
      ],),
    );
  }
}