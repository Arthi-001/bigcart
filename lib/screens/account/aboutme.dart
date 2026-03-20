import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Aboutme extends StatefulWidget {
  const Aboutme({super.key});

  @override
  State<Aboutme> createState() => _AboutmeState();
}

class _AboutmeState extends State<Aboutme> {
  TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmController = TextEditingController();
  bool isObscure=true;
   @override
  void initState() {
    super.initState();
    _loadUserData(); // Load saved data when page opens
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString("name") ?? "";
      emailController.text = prefs.getString("email") ?? "";
      phoneController.text = prefs.getString("phone") ?? "";
    });
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(appBar: AppBar(
    backgroundColor: Colors.white,
    elevation: 0,

    
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        Navigator.pop(context);
      },
    ),

    
    centerTitle: true,
    title:  Text(
    "About me",
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    
    actions: [
      IconButton(
        icon: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
           },
      ),
    ],
  ),
  body: Stack(
    children: [
      Container(
              height: double.infinity,
              width: double.infinity, 
              color: const Color(0xFFF4F5F9),
               ),
              
               Positioned(
                top: size.height * 0.03,
             left: 20,
             right: 20,
             child: Text("Personal Details",
             style: GoogleFonts.poppins(
              fontSize: 18,fontWeight: FontWeight.bold
              ))),
               
               Positioned(
                top: size.height * 0.07,
             left: 20,
             right: 20,
              child: Container(
                  height:size.height*0.08,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color:Colors.white ),
                          borderRadius: BorderRadius.circular(10),),
                          child: 
                            Padding(
                              padding:  EdgeInsets.only(left: size.width*0.00001),
                              child: TextField( controller: nameController,
    decoration: InputDecoration(
      hintText: "Username",
      border: InputBorder.none, // removes default underline
      prefixIcon: Icon(Icons.person_outline),
      contentPadding: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
      ),
    ),
  ),
   ),
      ),
   ),
               Positioned(
                top: size.height * 0.17,
             left: 20,
             right: 20,
             child: Container(
                  height:size.height*0.08,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color:Colors.white ),
                          borderRadius: BorderRadius.circular(10),),
                          child: 
                            Padding(
                              padding:  EdgeInsets.only(left: size.width*0.00001),
                              child: TextField( controller: emailController,
    decoration: InputDecoration(
      hintText: "Email",
      border: InputBorder.none, 
      prefixIcon: Icon(Icons.email_outlined),
      contentPadding: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
      ),
    ),
  ),
  ),
      ),
    ),
      Positioned(
                top: size.height * 0.27,
             left: 20,
             right: 20,
             child: Container(
                  height:size.height*0.08,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color:Colors.white ),
                          borderRadius: BorderRadius.circular(10),),
                          child: 
                            Padding(
                              padding:  EdgeInsets.only(left: size.width*0.00001),
                              child: TextField( controller: phoneController,
    decoration: InputDecoration(
      hintText: "Phone number",
      border: InputBorder.none, 
      prefixIcon: Icon(Icons.phone_outlined),
      contentPadding: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
      ),
    ),
  ),
  ),
      ),
    ),
    Positioned(
                top: size.height * 0.37,
             left: 20,
             right: 20,
             child: Text("Change password",
             style: GoogleFonts.poppins(
              fontSize: 18,fontWeight: FontWeight.bold
              ))
              ),
              
    Positioned(
                top: size.height * 0.42,
             left: 20,
             right: 20,
             child: Container(
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
    ),
    Positioned(
                top: size.height * 0.52,
             left: 20,
             right: 20,
             child: Container(
                  height:size.height*0.08,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color:Colors.white ),
                          borderRadius: BorderRadius.circular(10),),
                          child: 
                            Padding(
                              padding:  EdgeInsets.only(left: size.width*0.00001),
                              child: TextField( controller: confirmController,
    decoration: InputDecoration(
      hintText: "Confirm",
      border: InputBorder.none, 
      prefixIcon: Icon(Icons.lock_outline),
      contentPadding: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
      ),
    ),
  ),
  ),
      ),
    ),
    Positioned(
                           bottom: size.height * 0.1,
                           left: 20,
                           right: 20,
                           child: Container(
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
                               onPressed: ()async {
                                final prefs = await SharedPreferences.getInstance();

  // ✅ SAVE DATA
  await prefs.setString("name", nameController.text);
  await prefs.setString("email", emailController.text);
  await prefs.setString("phone", phoneController.text);
                                Navigator.pop(
    context,
    {
      "name": nameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
    },
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
                               child:
                                  Text(
                                     "Save settings",
                                     style: GoogleFonts.poppins(
                                       fontSize: 15,
                                       color: Colors.white,
                                       fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                 
                               
                             ),
                           ),
                         ),
    ],
  ),
  );
  }
}