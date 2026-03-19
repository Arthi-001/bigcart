import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Myorders extends StatefulWidget {
  const Myorders({super.key});

  @override
  State<Myorders> createState() => _MyordersState();
}

class _MyordersState extends State<Myorders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
    backgroundColor: Colors.white,
    elevation: 0,

    
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        Navigator.pop(context);
      },
    ),

    
    centerTitle: true,
    title:  Text(
      "My orders",
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    
    actions: [
      IconButton(
        icon: const Icon(Icons.tune_outlined, color: Colors.black),
        onPressed: () {
           },
      ),
    ],
  ),
  body: Container(
                height: double.infinity,
                width: double.infinity,
                color: const Color(0xFFF4F5F9),
                 ),
  );
  }
}