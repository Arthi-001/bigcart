import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash11 extends StatefulWidget {
  const Splash11({super.key});

  @override
  State<Splash11> createState() => _Splash11State();
}

class _Splash11State extends State<Splash11> {
  @override
  Widget build(BuildContext context) {
    final Size size= MediaQuery.of(context).size;
    return Stack(
      children:[Image.asset( "assets/mary-skrynnikova-zcaLASRz44k-unsplash.jpg",width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      cacheWidth: 1080,),Scaffold(backgroundColor: Colors.transparent,
    body:Column(
      children: [
        SizedBox(height: size.height*0.1,),
        Center(
          child: Text("Welcome To",
          style: GoogleFonts.poppins(color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w500),),
        ),
        Center(
          child:
          RichText(
            text: TextSpan(
              text: "BIG ",
              style: GoogleFonts.poppins(
                color: Colors.green,fontSize: 30,fontWeight: FontWeight.w300),
                
                children: [
                  TextSpan(text: "CART",
                  style: GoogleFonts.poppins(color: Colors.green,fontSize: 30,fontWeight: FontWeight.w500))
                  ]),) ,),
        SizedBox(height: size.height*0.05,),
        Center(child: Text("Your one-stop shop for fresh groceries and  ",style: GoogleFonts.poppins( color: Colors.white,fontSize: 15,),)),
        Center(
          child: Text(" daily essentials. ",
          style: GoogleFonts.poppins(color: Colors.white,
            fontSize: 15,),),
        ),
       
        
    
          ],) ,
    )]);
  }
}