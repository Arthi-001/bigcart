import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash12 extends StatefulWidget {
  const Splash12({super.key});

  @override
  State<Splash12> createState() => _Splash12State();
}

class _Splash12State extends State<Splash12> {
  @override
  Widget build(BuildContext context) {
    final Size size= MediaQuery.of(context).size;
    return Stack(
      children:[Image.asset( "assets/louis-hansel-onxjrr3Erwc-unsplash.jpg",width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      cacheWidth: 1080,),Scaffold(backgroundColor: Colors.transparent,
    body:Column(
      children: [
        SizedBox(height: size.height*0.1,),
        Center(
          child: Text("Buy Quality",
          style: GoogleFonts.poppins(color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w500),),
        ),
        Center(
          child: Text(" Dairy Products",
          style: GoogleFonts.poppins(color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w500),),
        ),
        SizedBox(height: size.height*0.05,),
        Center(child: Text("Fresh and healthy dairy products delivered to ",style: GoogleFonts.poppins( color: Colors.white,fontSize: 15,),)),
        Center(
          child: Text(" your doorstep. ",
          style: GoogleFonts.poppins(color: Colors.white,
            fontSize: 15,),),
        ),
       
        
    
          ],) ,
    )]);
  }
}