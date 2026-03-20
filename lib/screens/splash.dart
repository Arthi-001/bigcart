import 'package:bigcart/authentication/login.dart';
import 'package:bigcart/authentication/welcome.dart';
import 'package:bigcart/onboardscreens/onboarding.dart';
import 'package:bigcart/screens/bottomnavigator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
   @override
  void initState() {
    super.initState();
    
    checkAppFlow();
  }

 
void checkAppFlow() async {
  final prefs = await SharedPreferences.getInstance();

  bool seenOnboarding = prefs.getBool("seenOnboarding") ?? false;
  bool seenWelcome = prefs.getBool("seenWelcome") ?? false;
  bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

  if (!seenOnboarding) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Onboarding()),
    );

  } else if (!seenWelcome) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Welcome()),
    );

  } else if (!isLoggedIn) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Login()),
    );

  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const BottomNavigator()),
    );
  }
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