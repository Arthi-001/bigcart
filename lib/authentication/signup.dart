import 'package:bigcart/authentication/login.dart';
import 'package:bigcart/providers/signup_provider.dart';
import 'package:bigcart/utils/app_text_styles.dart';
import 'package:bigcart/widgets/onboardingheader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController passwordController = TextEditingController();
bool isObscure=true;
  @override
  Widget build(BuildContext context) {
     final Size size=MediaQuery.of(context).size;
   
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            OnboardingHeader(
              imagePath: "assets/nrd-D6Tu_L3chLE-unsplash.jpg",
              title: "Welcome",
            ),
            Container( 
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: const Color(0xFFF4F5F9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                   Text(
                    "Create Account",
                    style: AppTextStyles.title
                  ),
            
                  SizedBox(height:size.height*0.01),
            
                  Text(
                    "Quickly create an Account",
                    
                    style: AppTextStyles.body,
                  ),

                  SizedBox(height:size.height*0.03),

                   Container(
                    height:size.height*0.07,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color:Colors.white ),
                      borderRadius: BorderRadius.circular(10),),
                      child: 
                        TextField( controller: emailController,
                      decoration: InputDecoration(
                  hintText: "Email Address",hintStyle: AppTextStyles.subtitle,
                  border: InputBorder.none, 
                  prefixIcon: Icon(Icons.email_outlined),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: size.height * 0.02,
                  ),
                      ),
                    ),
                  
                        
                      ),

                      SizedBox(height:size.height*0.01),

                      Container(
                    height:size.height*0.07,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color:Colors.white ),
                      borderRadius: BorderRadius.circular(10),),
                      child: 
                        
                        TextField( controller: phoneController,
                      decoration: InputDecoration(
                  hintText: "Phone Number",hintStyle: AppTextStyles.subtitle,
                  border: InputBorder.none, 
                  prefixIcon: Icon(Icons.phone_outlined),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: size.height * 0.02,
                  ),
                      ),
                    ),
                  
                        
                      ),

                      SizedBox(height:size.height*0.01),

                       Container(
                height:size.height*0.08,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color:Colors.white ),
                        borderRadius: BorderRadius.circular(10),),
                        child: 
                          Padding(
                            padding:  EdgeInsets.only(left: size.width*0.00001),
                            child: Consumer<SignupProvider>(
  builder: (context, provider, child) {
    return TextField( controller: passwordController,
      obscureText: true,
      onChanged: (value) {
        provider.validatePassword(value); 
      },
      decoration: InputDecoration(
        hintText: "Password",hintStyle: AppTextStyles.subtitle,
         border: InputBorder.none,
  enabledBorder: InputBorder.none,
  focusedBorder: InputBorder.none,
  errorBorder: InputBorder.none,
  focusedErrorBorder: InputBorder.none,


        errorText:
            provider.passwordError.isEmpty ? null : provider.passwordError,
             prefixIcon: Icon(Icons.lock_outline),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: size.height * 0.02,
                  ),
      ),
    );
  },
),
                  ),
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
                    onPressed: ()  {
                    final provider = Provider.of<SignupProvider>(context, listen: false);

  provider.signup(
    emailController.text.trim(),
    phoneController.text.trim(),
    passwordController.text.trim(),
    context,
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
                      child:Consumer<SignupProvider>(
  builder: (context, provider, child) {
    return provider.isLoading
        ? CircularProgressIndicator(color: Colors.white)
        : 
                    Text(
                      "Signup",
                      style: AppTextStyles.whiteText
                    );
                    }
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
            )]),
      ));
  }
}