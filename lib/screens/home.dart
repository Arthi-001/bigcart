import 'package:bigcart/widgets/categorieswidget.dart';
import 'package:bigcart/widgets/productcard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _controller = PageController();
  @override
void initState() {
  super.initState();

  Future.microtask(() {if (!mounted) return;
    precacheImage(const AssetImage("assets/annie-spratt-R3LcfTvcGWY-unsplash.jpg"), context);
    precacheImage(const AssetImage("assets/mario-raj-0sz-sfC_ekc-unsplash.jpg"), context);
    precacheImage(const AssetImage("assets/anton-darius-FCrgmqqvl-w-unsplash.jpg"), context);
  });
}
  
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:size.height*0.07,),
            Padding(padding: EdgeInsets.only(left: size.width * 0.05),
              child: Container(
                          height:size.height*0.07,
                          width: size.width*0.9,
                          
                          decoration: BoxDecoration(
                            color: const Color(0xFFEBEBEB),
                            border: Border.all(color:const Color(0xFFEBEBEB) ),
                            borderRadius: BorderRadius.circular(10),),
                            child: Row(children: [
                              Padding(
                                padding:  EdgeInsets.all( MediaQuery.of(context).size.width * 0.04,),
                                child: Icon(Icons.search_outlined)
                              ),
                              SizedBox(width:size.width*0.02),
                              Text("Search keywords..",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
                              SizedBox(width:size.width*0.23),
                               Padding(
                                padding:  EdgeInsets.all( MediaQuery.of(context).size.width * 0.04,),
                                child: Icon(Icons.tune_outlined)
                              ),
                        
                              ],),
                            ),
                          
            ),
            SizedBox(height: size.height * 0.02),
        
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.05),
          child: Container(
            height: size.height * 0.28,
            width: size.width * 0.9,
            decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
            ),
        
            child: Stack(
        children: [
        
          /// IMAGE SCROLL
          PageView(
            controller: _controller,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Stack(
                  children:[ Image.asset(
                    "assets/annie-spratt-R3LcfTvcGWY-unsplash.jpg",
                    fit: BoxFit.cover,
                     cacheWidth: 800,
                  ),
                   Positioned(
              left: 20,
              bottom: 30,
              child: Text(
                "20% OFF\nFresh Vegetables",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ]),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Stack(
                  children:[ Image.asset(
                    "assets/mario-raj-0sz-sfC_ekc-unsplash.jpg",
                    fit: BoxFit.cover,
                     cacheWidth: 800,
                  ),
                   Positioned(
              left: 20,
              bottom: 30,
              child: Text(
                "Fresh Grocery\nDelivered Fast",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ]),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Stack(
                  children:[ Image.asset(
                    "assets/anton-darius-FCrgmqqvl-w-unsplash.jpg",
                    fit: BoxFit.cover,
                     cacheWidth: 800,
                  ),
                  Positioned(
              left: 20,
              bottom: 30,
              child: Text(
                "30% OFF\nOrganic Fruits",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ]),
              ),
            ],
          ),
        
          /// INDICATOR (BOTTOM LEFT)
          Positioned(
            bottom: 20,
            left: 20,
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                dotColor: Colors.white,
                activeDotColor: Colors.green,
                
              ),
            ),
          ),
        ],
            ),
          ),
        ),
          SizedBox(height: size.height*0.02,),
          Row(
            children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: size.width*0.05),
          child: Text("Categories",
          style: GoogleFonts.poppins(
            fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600),),
        ),
        SizedBox(width: size.width*0.5,),
        Icon(Icons.navigate_next_outlined,color: Colors.black,size: 30,)
            ],
          ) ,
           SizedBox(height:size.height*0.02),
            Padding(
        padding:EdgeInsets.symmetric(horizontal: size.width*0.05),
        child: CategoriesWidget(),
            ),
            SizedBox(height:size.height*0.02),
            Row(
            children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: size.width*0.05),
          child: Text("Featured Products",
          style: GoogleFonts.poppins(
            fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600),),
        ),
        SizedBox(width: size.width*0.31,),
        Icon(Icons.navigate_next_outlined,color: Colors.black,size: 30,)
            ],
          ) ,
          SizedBox(height:size.height*0.02),
         GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return const ProductCard();
          },
        )
        
            ]),
      ),       



    );
  }
}