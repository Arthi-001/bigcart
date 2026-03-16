import 'package:bigcart/onboardscreens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
void initState() {
  super.initState();
  navigateToOnboarding();
}

void navigateToOnboarding() async {
  await Future.delayed(const Duration(seconds: 3));
   if (!mounted) return;
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const Onboarding(),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: 
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
      );
  }
}