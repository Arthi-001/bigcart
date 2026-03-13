import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      body:Stack(
        children: [

          Expanded(
            child: PageView(
              controller: _controller,
              children: [
              Container(color: Colors.amber,),
              Container(color: Colors.blue,),
              Container(color: Colors.green,),
                
                       ],
            ),
            
          ),
           Positioned(
          bottom: size.height * 0.15,
            left: 0,
            right: 0,
          child: SmoothPageIndicator(
          controller: _controller,
          count: 3,
          effect: WormEffect(
            dotHeight: 14,
            dotWidth: 14,
            spacing: 10,
            dotColor: Colors.grey,   
            activeDotColor: Colors.green,    
              
              
            ),
                ),
    ),
    ]));
  }
}