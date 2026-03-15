import 'package:bigcart/authentication/signup.dart';
import 'package:bigcart/widgets/onboardingheader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:bigcart/authentication/login.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          OnboardingHeader(
            imagePath: "assets/eduardo-soares-QsYXYSwV3NU-unsplash.jpg",
            title: "Welcome",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container( 
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: const Color(0xFFF4F5F9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     
                     SizedBox(height:size.height*0.01),
              
                     Text(
                      "Welcome",
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              
                    SizedBox(height:size.height*0.01),
              
                    Text(
                      "Get fresh groceries and daily essentials delivered to your doorstep.",
                      
                      style: GoogleFonts.poppins( color: Colors.grey[700],fontSize: 15),
                    ),
                    SizedBox(height:size.height*0.03),
                    
                    Container(
                      height:size.height*0.07,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color:Colors.white ),
                        borderRadius: BorderRadius.circular(10),),
                        child: Row(children: [
                          Padding(
                            padding:  EdgeInsets.all( MediaQuery.of(context).size.width * 0.04,),
                            child: Image.asset("assets/google.png"),
                          ),
                          SizedBox(width:size.width*0.15),
                          Text("Continue with google",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),)
                    
                          ],),
                        ),
                        SizedBox(height:size.height*0.03),
                         
                         Container(
  width: size.width*0.9,
  height: size.height*0.07,
  decoration: BoxDecoration(
    gradient:  LinearGradient(
      colors: [
        const Color.fromARGB(255, 175, 245, 95),Colors.green
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  child: ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Signup(),
        ),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: Row(
      children: [
        SizedBox(width:size.width*0.03),
        Icon(Icons.person_outline,color: Colors.white,size: 30,),
        SizedBox(width:size.width*0.2),
        Text(
          "Create an account",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  ),
),
SizedBox(height:size.height*0.02),
Center(
          child:
          RichText(
            text: TextSpan(
              text: "Already have an account? ",
              style: GoogleFonts.poppins( color: Colors.grey[700],
                fontSize: 15),
                
                children: [
                  TextSpan(text: "Login",
                  style: GoogleFonts.poppins(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            },
                
                  ),
                    ]),) ,),

              
                  ],
                ),
              ),
            ),
          ),])
        ,
      )

;
  }
}