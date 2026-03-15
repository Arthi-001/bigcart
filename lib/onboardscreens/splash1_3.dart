import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash13 extends StatefulWidget {
  const Splash13({super.key});

  @override
  State<Splash13> createState() => _Splash13State();
}

class _Splash13State extends State<Splash13> {
  @override
  Widget build(BuildContext context) {
    final Size size= MediaQuery.of(context).size;
    return Stack(
      children:[Image.asset( "assets/basket.jpg",width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      cacheWidth: 1080,), Scaffold(backgroundColor: Colors.transparent,
      body:Column(
        children: [
          SizedBox(height: size.height*0.1,),
          Center(
            child: Text("Buy Premium",
            style: GoogleFonts.poppins(
              fontSize: 30,
              fontWeight: FontWeight.w500),),
          ),
          Center(
            child: Text(" Quality Fruits",
            style:GoogleFonts.poppins(
              fontSize: 30,
              fontWeight: FontWeight.w500),),
          ),
          SizedBox(height: size.height*0.05,),
          Center(child: Text("Find the best offers on top brands.",style: GoogleFonts.poppins( fontSize: 17,),)),
         
          
      
            ],) ,
      ),
    ]);
  }
}