import 'package:bigcart/authentication/login.dart';
import 'package:bigcart/widgets/onboardingheader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
                        child: 
                          TextField( controller: emailController,
    decoration: InputDecoration(
      hintText: "Email Address",
      border: InputBorder.none, // removes default underline
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
      hintText: "Phone Number",
      border: InputBorder.none, // removes default underline
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
                              child: TextField( controller: passwordController,
        obscureText: isObscure,
        decoration: InputDecoration(
          hintText: "Current Password",
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
  onPressed: () async {
  if (emailController.text.isEmpty ||
      phoneController.text.isEmpty ||
      passwordController.text.isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please fill all fields")),
    );
    return;
  }

  final supabase = Supabase.instance.client;

  try {
    // 🔐 Create user in Supabase
    final response = await supabase.auth.signUp(
      email: emailController.text.trim(),
      
      password: passwordController.text.trim(),
    );

    if (response.user != null) {
      // ✅ Save extra data (phone) in profiles table
      await supabase.from('users_data').insert({
        'id': response.user!.id,
        'phone': phoneController.text.trim(),
      });

      // ✅ Navigate to login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup successful! Please login")),
      );
    }

  } catch (e) {
    print("SIGNUP ERROR: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Signup failed: ${e.toString()}")),
    );
  }
},
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: 
        Text(
          "Signup",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
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