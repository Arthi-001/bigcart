import 'package:bigcart/authentication/forgotpassword.dart';
import 'package:bigcart/authentication/signup.dart';
import 'package:bigcart/providers/loginprovider.dart';
import 'package:bigcart/utils/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:bigcart/widgets/onboardingheader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isOn = false;
  bool isObscure=true;
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
   
    return Scaffold(
      body: SingleChildScrollView(
      child: Column(
          children: [
            OnboardingHeader(
              imagePath: "assets/tara-clark-a4Vow2p6AXE-unsplash.jpg",
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
                    "Welcome back !",
                    style: AppTextStyles.title
                  ),
            
                  SizedBox(height:size.height*0.01),
            
                  Text(
                    "Sign in to your Account",
                    
                    style: AppTextStyles.body
                  ),

                  SizedBox(height:size.height*0.03),

                   Container(
                    height:size.height*0.07,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color:Colors.white ),
                      borderRadius: BorderRadius.circular(10),),
                      child: TextField( controller: emailController,
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
                      child:TextField( controller: passwordController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      
                      border: InputBorder.none,
                      
                      
                      prefixIcon: const Icon(Icons.lock_outline),
            
                      
                      suffixIcon: IconButton(
                        icon: Icon(
            isObscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey, 
                        ),
                        onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
                        },
                      ),
            
                      contentPadding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02,
                      ),
                    ),
              ),
                      ),

                       SizedBox(height:size.height*0.01),

                      Row(
              children: [
                Transform.scale(scale: 0.8,
                  child: Switch(
                    value: isOn,
                    activeTrackColor: Colors.green,
                    activeThumbColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        isOn = value;
                      });
                    },
                  ),
                ),
                Text("Remember me",style: AppTextStyles.body),
                const Spacer(),
               TextButton(onPressed: (){
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Forgotpassword(),
                  ),
                );
               },child: Text("Forgot password",style: AppTextStyles.blueText)),
                
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
               onPressed: ()  {
               final provider = Provider.of<LoginProvider>(context, listen: false);

  provider.login(
    emailController.text.trim(),
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
                child: Consumer<LoginProvider>(
  builder: (context, provider, child) {
    return provider.isLoading
        ? CircularProgressIndicator(color: Colors.white)
        :Text(
                      "Login",
                      style: AppTextStyles.whiteText
                    );
                    }
                    ),
                  
                
              ),
            ),

            SizedBox(height: size.height*0.01,),
            
            Center(
                      child:
                      RichText(
                        text: TextSpan(
            text: "Don't have an account? ",
            style: AppTextStyles.body,
              
              children: [
                TextSpan(text: "Sign up",
                style: AppTextStyles.bold,
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
                    ]),
    )
                  );
  }
}