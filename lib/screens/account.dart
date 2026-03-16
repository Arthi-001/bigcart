import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
     final Size size=MediaQuery.of(context).size;
    return Scaffold(
       body: Stack(
         children: [ Column(
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
           Positioned(
            top: size.height * 0.1, // adjust position
            left: size.width / 2.3- 30,
            child: ClipOval(
              child: Container(
                height: size.width * 0.30,
                width:size.width * 0.30, 
                decoration:  BoxDecoration(
                  color: 
                      Color.fromARGB(255, 191, 240, 134),
                     ),
               
              ),
            ),
    ),
     Positioned(
            top: size.height * 0.19, // adjust position
            left: size.width / 1.5- 30,
            child: ClipOval(
              child: Container(
                height: size.width * 0.10,
                width:size.width * 0.10, 
                decoration:  BoxDecoration(
                  gradient:LinearGradient(colors: [
                     const Color.fromARGB(255, 175, 245, 95),Colors.green
                     ]
                     ),
               
              ),child:  Icon(
          Icons.camera_alt,
          color: Colors.white,
          size: 28,
        ),
            ),
    ),),
    Positioned(
      top: size.height * 0.25,
      left: size.width / 2.1- 30,
      child: Text("Username",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),)),
    Positioned(
      top: size.height * 0.28,
      left: size.width / 2.5- 30,
      child: Text("usermail@gmail.com",style: GoogleFonts.poppins(fontSize: 15),))
    ] ),

    
  
    );
  }
}