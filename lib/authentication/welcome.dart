import 'package:bigcart/authentication/signup.dart';

import 'package:bigcart/screens/dashboard/bottomnavigator.dart';
import 'package:bigcart/utils/app_text_styles.dart';
import 'package:bigcart/widgets/onboardingheader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:bigcart/authentication/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
void initState() {
  super.initState();
  checkUser();
}

void checkUser() async {
  final user = Supabase.instance.client.auth.currentUser;

  if (user != null) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const BottomNavigator()),
    );
  }
}
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
                      style: AppTextStyles.title
                    ),
              
                    SizedBox(height:size.height*0.01),
              
                    Text(
                      "Get fresh groceries and daily essentials delivered to your doorstep.",
                      
                      style: AppTextStyles.body
                    ),
                    SizedBox(height:size.height*0.03),
                    
                    GestureDetector(
  onTap: () async {
    final supabase = Supabase.instance.client;

    try {
      await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.flutter://login-callback/',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In failed")),
      );
    }
  },
  child: Container(
    height: size.height * 0.07,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Image.asset("assets/google.png"),
        ),
        SizedBox(width: size.width * 0.15),
        Text(
          "Continue with Google",
          style:AppTextStyles.bold
        )
      ],
    ),
  ),
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
   onPressed: () async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool("seenWelcome", true); // ✅ save

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
          style: AppTextStyles.whiteText
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
              style: AppTextStyles.body,
                
                children: [
                  TextSpan(text: "Login",
                  style: AppTextStyles.bold,
                  recognizer: TapGestureRecognizer()
  ..onTap = () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("seenWelcome", true); // ✅ save

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
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