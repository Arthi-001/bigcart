import 'package:bigcart/onboard/onboarding.dart';
import 'package:bigcart/splash/splash1_1.dart';
import 'package:bigcart/splash/splash1_2.dart';
import 'package:bigcart/splash/splash1_3.dart';
import 'package:bigcart/splash/splash1_4.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
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
              children: [
                Splash14(),
                Splash13(),
                Splash12(),
                Splash11(),
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
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: GestureDetector(onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Onboarding()));
    },
      child: const Text(
        "Get Started",
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
)
       )

        ],
      ), );
  }
}