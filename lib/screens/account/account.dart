import 'package:bigcart/screens/account/aboutme.dart';
import 'package:bigcart/screens/account/myaddress.dart';
import 'package:bigcart/screens/account/myorders.dart';
import 'package:bigcart/screens/account/notifications.dart';
import 'package:bigcart/widgets/accountrow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
   
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
void initState() {
  super.initState();
  loadUserData(); // ✅ IMPORTANT
}
  Future<void> loadUserData() async {
  final prefs = await SharedPreferences.getInstance();

  setState(() {
    name = prefs.getString("name") ?? "Username";
    email = prefs.getString("email") ?? "usermail@gmail.com";
    phone = prefs.getString("phone") ?? "";
  });
}
   String name = "Username";
  String email = "usermail@gmail.com";
  String phone = "";
  @override
  Widget build(BuildContext context) {
     final Size size=MediaQuery.of(context).size;
    return Scaffold(
       body: Stack(
         children: [ Column(
             children: [
               Container(
           height: size.height * 0.15,
          color: Colors.white,
               ),
               Container(
           height: size.height * 0.75,
          color: const Color(0xFFF4F5F9),
               ),
               
             ],
           ),
           Positioned(
            top: size.height * 0.1, // adjust position
            left: size.width / 2.3- 30,
            child: ClipOval(
              child: Container(
                height: size.width * 0.30,
                width:size.width * 0.30, 
                decoration:  BoxDecoration(
                  color: 
                      Color.fromARGB(255, 191, 240, 134),
                     ),
               
              ),
            ),
    ),
     Positioned(
            top: size.height * 0.19, // adjust position
            left: size.width / 1.5- 30,
            child: ClipOval(
              child: Container(
                height: size.width * 0.10,
                width:size.width * 0.10, 
                decoration:  BoxDecoration(
                  gradient:LinearGradient(colors: [
                     const Color.fromARGB(255, 175, 245, 95),Colors.green
                     ]
                     ),
               
              ),child:  Icon(
          Icons.camera_alt,
          color: Colors.white,
          size: 28,
        ),
            ),
    ),),
    Positioned(
      top: size.height * 0.25,
      left: size.width / 2- 30,
      child: Text(name,style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),)),
    Positioned(
      top: size.height * 0.28,
      left: size.width / 2.5- 30,
      child: Text(email,style: GoogleFonts.poppins(fontSize: 15),)),
      Positioned(
         top: size.height * 0.32,
         left: 0,
         right: 0,
        child: Column(
  children: [
    AccountRow(
      icon: Icons.person_outline,
      title: "About me",
     onTap: () async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Aboutme()),
    );

    if (result != null) {
      setState(() {
        name = result["name"];
        email = result["email"];
        phone = result["phone"];
      });
    }
  },
    ),
    AccountRow(
      icon: Icons.inventory_outlined,
      title: "My Orders",
      onTap: () {Navigator.push(context, MaterialPageRoute(builder:  (context)=>Myorders()));},
    ),
    AccountRow(
      icon: Icons.favorite_border,
      title: "My Favourites",
      onTap: () {},
    ),
    AccountRow(
      icon: Icons.location_on_outlined,
      title: "My Address",
      onTap: () {Navigator.push(context, MaterialPageRoute(builder:  (context)=>Myaddress(name: "Name",
                                    email: "Email",
                                    phone: "Phone",
                                    address: "Address",
                                    zip: "Zip",
                                    city: "City",
                                    country: "Selected")));},
    ),
     AccountRow(
      icon: Icons.credit_card_outlined,
      title: "Credit cards",
      onTap: () {},
    ),
     AccountRow(
      icon: Icons.currency_exchange,
      title: "Transactions",
      onTap: () {Navigator.push(context, MaterialPageRoute(builder:  (context)=>Myorders()));},
    ),
     AccountRow(
      icon: Icons.notifications_outlined,
      title: "Notifications",
      onTap: () {Navigator.push(context, MaterialPageRoute(builder:  (context)=>Notifications()));},
    ),
     AccountRow(
      icon: Icons.logout_outlined,
      title: "Sign out",
     
    ),
  ],
))
    ] ),

    
  
    );
  }
}