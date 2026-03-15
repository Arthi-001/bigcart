
import 'package:bigcart/authentication/welcome.dart';
import 'package:bigcart/onboardscreens/splash1_1.dart';
import 'package:bigcart/onboardscreens/splash1_2.dart';
import 'package:bigcart/onboardscreens/splash1_3.dart';
import 'package:bigcart/onboardscreens/splash1_4.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentPage = 0;
   final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return  Scaffold(
        body:Stack(
        children: [

          Expanded(
            child: PageView(
             controller: _controller,
  onPageChanged: (index) {
    setState(() {
      currentPage = index;
    });
  },
              children: [
                Splash11(),
                Splash12(),
                Splash13(),
                Splash14(),
                       ],
            ),
            
          ),
          Positioned(
          bottom: size.height * 0.15,
            left: 0,
            right: 0,
          child: Center(
            child: SmoothPageIndicator(
            controller: _controller,
            count: 4,
            effect: WormEffect(
              dotHeight: 14,
              dotWidth: 14,
              spacing: 10,
              dotColor: Colors.grey,   
              activeDotColor: Colors.green,    
                
                
              ),
                  ),
          ),
    ),
    Positioned(
        bottom: size.height * 0.05,
        left: size.width * 0.05,
        right: size.width * 0.05,
        child: Container(
  width: size.width*0.9,
  decoration: BoxDecoration(
    gradient:  LinearGradient(
      colors: [
        const Color.fromARGB(255, 175, 245, 95),Colors.green
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(15),
  ),
  child: ElevatedButton(
   onPressed: () {
  if (currentPage == 3) {
    // Last splash screen → go to login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Welcome(),
      ),
    );
  } else {
    // Move to next page
    _controller.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
},
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: Text(
  currentPage == 3 ? "Get Started" : "Next",
  style: GoogleFonts.poppins(
    fontSize: 15,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
),
  ),
)
       )

        ],
      ), );
  }
}