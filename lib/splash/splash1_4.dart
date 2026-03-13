import 'package:flutter/material.dart';

class Splash14 extends StatefulWidget {
  const Splash14({super.key});

  @override
  State<Splash14> createState() => _Splash14State();
}

class _Splash14State extends State<Splash14> {
  @override
  Widget build(BuildContext context) {
    final Size size= MediaQuery.of(context).size;
    return Stack(
      children: [Image.asset("assets/tobi-zLCR7RsxYGs-unsplash.jpg",
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      cacheWidth: 1080,),
      Scaffold(backgroundColor: Colors.transparent,
      body:Column(
        children: [
          SizedBox(height: size.height*0.1,),
          Center(
            child: Text("Get Discounts",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500),),
          ),
          Center(
            child: Text(" On All Products",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500),),
          ),
          SizedBox(height: size.height*0.05,),
          Center(child: Text("Shop now and save more on your favorite items.",style: TextStyle( fontSize: 17,),)),
          SizedBox(height: size.height*0.05,),
          
      
            ],) ,
      ),
    ]);
  }
}