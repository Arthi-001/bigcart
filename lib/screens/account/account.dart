import 'package:bigcart/authentication/login.dart';
import 'package:bigcart/screens/account/aboutme.dart';
import 'package:bigcart/screens/account/myaddress.dart';
import 'package:bigcart/screens/account/mycards.dart';
import 'package:bigcart/screens/account/myorders.dart';
import 'package:bigcart/screens/account/notifications.dart';
import 'package:bigcart/screens/account/transactions.dart';
import 'package:bigcart/screens/favourites.dart';
import 'package:bigcart/widgets/accountrow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Account extends StatefulWidget {
   
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
void didChangeDependencies() {
  super.didChangeDependencies();
  loadUserData();
}

Future<void> loadUserData() async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;

  if (user == null) return;

  try {
    // Try to get the user row
    final data = await supabase
        .from('users_data')
        .select()
        .eq('id', user.id)
        .maybeSingle(); // ✅ Use maybeSingle instead of single

    if (data == null) {
      // Row doesn't exist → create it for first-time login
      await supabase.from('users_data').insert({
        'id': user.id,
        'name': '',
        'email': user.email ?? '',
        'phone': '',
      });

      // Use default values
      setState(() {
        name = "Username";
        email = user.email ?? "usermail@gmail.com";
        phone = "";
      });
    } else {
      // Row exists → load values
      setState(() {
        name = data['name'] ?? "Username";
        email = data['email'] ?? "usermail@gmail.com";
        phone = data['phone'] ?? "";
      });
    }
  } catch (e) {
    print("Error loading user: $e");
  }
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
     onPressed: () async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Aboutme()),
    );
    await loadUserData(); 

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
      onPressed: () {Navigator.push(context, MaterialPageRoute(builder:  (context)=>Myorders()));},
    ),
    AccountRow(
      icon: Icons.favorite_border,
      title: "My Favourites",
      onPressed: () { Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Favourites()),
    );},
    ),
    AccountRow(
      icon: Icons.location_on_outlined,
      title: "My Address",
      onPressed: () {Navigator.push(context, MaterialPageRoute(builder:  (context)=>Myaddress(name: "Name",
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
      onPressed: () {Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyCards()),
    );},
    ),
     AccountRow(
      icon: Icons.currency_exchange,
      title: "Transactions",
      onPressed: () {Navigator.push(context, MaterialPageRoute(builder:  (context)=>Transactions()));},
    ),
     AccountRow(
      icon: Icons.notifications_outlined,
      title: "Notifications",
      onPressed: () {Navigator.push(context, MaterialPageRoute(builder:  (context)=>Notifications()));},
    ),
     AccountRow(
      icon: Icons.logout_outlined,
      title: "Sign out",
      onPressed: () {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Logout",style: GoogleFonts.poppins(color: Colors.green),),
      content: Text("Are you sure you want to logout?",style: GoogleFonts.poppins(color: Colors.grey.shade700),),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel",style: GoogleFonts.poppins(color: Colors.green),),
        ),
        TextButton(
          onPressed: () async {
            await Supabase.instance.client.auth.signOut();

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
              (route) => false,
            );
          },
          child: Text("Logout",style: GoogleFonts.poppins(color: Colors.green),),
        ),
      ],
    ),
  );
}
     
    ),
  ],
))
    ] ),

    
  
    );
  }
}