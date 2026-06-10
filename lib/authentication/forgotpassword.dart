import 'package:bigcart/providers/forgot_password_provider.dart';
import 'package:bigcart/utils/app_text_styles.dart';
import 'package:bigcart/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Forgotpassword extends StatefulWidget {
const Forgotpassword({super.key});

@override
State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
   TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(backgroundColor: const Color(0xFFF4F5F9),body:SafeArea(
      child: Column(
          children: [
            Headers(
              
              title: "Password Recovery",
            ),
            SizedBox(height: size.height*0.08,),
            Text("Forgot Password",style: AppTextStyles.title),
            SizedBox(height: size.height*0.02,),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
            "Enter your email address and we will send you instructions to reset your password.",
            textAlign: TextAlign.center,
            style: AppTextStyles.body
            ),
            ),
            SizedBox(height:size.height*0.045),
                     Container(
                      height:size.height*0.07,
                      width: size.width*0.9,
                      decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color:Colors.white ),
                      borderRadius: BorderRadius.circular(10),),
                      child:  TextField( controller: emailController,
                      decoration: InputDecoration(
                      hintText: "Email Address",
                      border: InputBorder.none, 
                      prefixIcon: Icon(Icons.email_outlined),
                      contentPadding: EdgeInsets.symmetric(
                      vertical: size.height * 0.02,
                         ),
                        ),
                      ),
                    
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
                        onPressed: () {
                        final provider = Provider.of<ForgotPasswordProvider>(context, listen: false);

                        provider.sendResetLink(emailController.text.trim(), context);
                         },
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child:Consumer<ForgotPasswordProvider>(
                        builder: (context, provider, child) {
                        return provider.isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          :
                        Text(
                           "Send Link",
                           style: AppTextStyles.whiteText
                         );},
      
    
  ),
),

    )
    ]),
    )
    );
  }
}