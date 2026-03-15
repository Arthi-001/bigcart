import 'package:bigcart/authentication/login.dart';
import 'package:bigcart/screens/home.dart';
import 'package:bigcart/widgets/onboardingheader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
     final Size size=MediaQuery.of(context).size;
   
    return Scaffold(
      body: Column(
        children: [
          OnboardingHeader(
            imagePath: "assets/nrd-D6Tu_L3chLE-unsplash.jpg",
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
                    
                     Text(
                      "Create Account",
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              
                    SizedBox(height:size.height*0.01),
              
                    Text(
                      "Quickly create an Account",
                      
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
                            child: Icon(Icons.email_outlined)
                          ),
                          SizedBox(width:size.width*0.02),
                          Text("Email Address",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),)
                    
                          ],),
                        ),
                        SizedBox(height:size.height*0.01),
                        Container(
                      height:size.height*0.07,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color:Colors.white ),
                        borderRadius: BorderRadius.circular(10),),
                        child: Row(children: [
                          Padding(
                            padding:  EdgeInsets.all( MediaQuery.of(context).size.width * 0.04,),
                            child: Icon(Icons.phone_outlined)
                          ),
                          SizedBox(width:size.width*0.02),
                          Text("Phone Number",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),)
                    
                          ],),
                        ),
                        SizedBox(height:size.height*0.01),
                         Container(
                      height:size.height*0.07,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color:Colors.white ),
                        borderRadius: BorderRadius.circular(10),),
                        child: Row(children: [
                          Padding(
                            padding:  EdgeInsets.all( MediaQuery.of(context).size.width * 0.04,),
                            child: Icon(Icons.lock_outline)
                          ),
                          SizedBox(width:size.width*0.6),
                           Padding(
                            padding:  EdgeInsets.all( MediaQuery.of(context).size.width * 0.04,),
                            child: Icon(Icons.remove_red_eye_outlined)
                          ),

                    
                          ],),
                        ),
                         SizedBox(height:size.height*0.023),
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
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: 
        GestureDetector(onTap: () {
         Navigator.push(context, MaterialPageRoute(builder:(context)=>Home()));
       },
          child: Text(
            "Signup",
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
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
    ))]));
  }
}