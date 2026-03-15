import 'package:bigcart/authentication/forgotpassword.dart';
import 'package:bigcart/authentication/signup.dart';
import 'package:bigcart/screens/home.dart';
import 'package:bigcart/widgets/onboardingheader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   bool isOn = false;
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
   
    return Scaffold(body: Column(
        children: [
          OnboardingHeader(
            imagePath: "assets/tara-clark-a4Vow2p6AXE-unsplash.jpg",
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
                      "Welcome back !",
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              
                    SizedBox(height:size.height*0.01),
              
                    Text(
                      "Sign in to your Account",
                      
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
                            child: Icon(Icons.lock_outline)
                          ),
                          SizedBox(width:size.width*0.6),
                           Padding(
                            padding:  EdgeInsets.all( MediaQuery.of(context).size.width * 0.04,),
                            child: Icon(Icons.remove_red_eye_outlined)
                          ),

                    
                          ],),
                        ),
                         SizedBox(height:size.height*0.01),
                        Row(
  children: [
    Transform.scale(scale: 0.8,
      child: Switch(
        value: isOn,
        activeTrackColor: Colors.green,
        activeColor: Colors.white,
        onChanged: (value) {
          setState(() {
            isOn = value;
          });
        },
      ),
    ),
    Text("Remember me",style: GoogleFonts.poppins( color: Colors.grey[700],fontSize: 15,fontWeight: FontWeight.w500)),
    const Spacer(),
   TextButton(onPressed: (){
   Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Forgotpassword(),
      ),
    );
   },child: Text("Forgot password",style: GoogleFonts.poppins(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.w500))),
    
  ],
),
 SizedBox(height:size.height*0.02),
                         
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
            "Login",
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
       ),
      
    
  ),
),
SizedBox(height: size.height*0.01,),
Center(
          child:
          RichText(
            text: TextSpan(
              text: "Don't have an account? ",
              style: GoogleFonts.poppins( color: Colors.grey[700],
                fontSize: 15),
                
                children: [
                  TextSpan(text: "Sign up",
                  style: GoogleFonts.poppins(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Signup(),
                ),
              );
            },
                
                  ),
                    ]),) ,),

                  ])
                  ),
                  
                  )
                  ),
                  ])
                  );
  }
}