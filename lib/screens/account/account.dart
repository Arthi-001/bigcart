

import 'package:bigcart/authentication/login.dart';
import 'package:bigcart/providers/account_provider.dart';
import 'package:bigcart/screens/account/aboutme.dart';
import 'package:bigcart/screens/account/myaddress.dart';

import 'package:bigcart/screens/account/mycards.dart';
import 'package:bigcart/screens/account/myorders.dart';
import 'package:bigcart/screens/account/notifications.dart';
import 'package:bigcart/screens/account/transactions.dart';
import 'package:bigcart/screens/favourites/favourites.dart';
import 'package:bigcart/utils/app_text_styles.dart';
import 'package:bigcart/widgets/account_skeleton.dart';

import 'package:bigcart/widgets/accountrow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Account extends StatefulWidget {
   
  const Account({super.key,});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
void initState() {
  super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    final provider =
        Provider.of<AccountProvider>(context, listen: false);

    // ✅ CLEAR → force skeleton every time
    provider.clearUserData();

    provider.loadUserData();
  });
}


  @override
  Widget build(BuildContext context) {
     final Size size=MediaQuery.of(context).size;
    return Scaffold(
       body: Consumer<AccountProvider>(
  builder: (context, provider, child) {
    final Size size = MediaQuery.of(context).size;

    if (provider.isLoading) {
      return const AccountSkeleton();
    }

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height,
        ),
        child: IntrinsicHeight(
          child: Stack(
            children: [
              Column(
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

              // 👤 PROFILE IMAGE
              Positioned(
                top: size.height * 0.1,
                left: size.width / 2.3 - 30,
                child: ClipOval(
                  child: Container(
                    height: size.width * 0.30,
                    width: size.width * 0.30,
                    color: const Color.fromARGB(255, 191, 240, 134),
                    child: provider.image != null
                        ? Image.file(provider.image!, fit: BoxFit.cover)
                        : const Icon(Icons.person,
                            size: 60, color: Colors.white),
                  ),
                ),
              ),

              // 📷 CAMERA BUTTON
              Positioned(
                top: size.height * 0.19,
                left: size.width / 1.5 - 30,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Consumer<AccountProvider>(
                          builder: (context, provider, child) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.camera),
                                  title: const Text("Camera"),
                                  onTap: () {
                                    Navigator.pop(context);
                                    provider.pickImageFromCamera();
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.photo),
                                  title: const Text("Gallery"),
                                  onTap: () {
                                    Navigator.pop(context);
                                    provider.pickImage();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                  child: ClipOval(
                    child: Container(
                      height: size.width * 0.10,
                      width: size.width * 0.10,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 175, 245, 95),
                            Colors.green
                          ],
                        ),
                      ),
                      child: const Icon(Icons.camera_alt,
                          color: Colors.white, size: 28),
                    ),
                  ),
                ),
              ),

              // 👤 NAME + EMAIL
              Positioned(
                top: size.height * 0.25,
                left: size.width / 2.3 - 30,
                child: Column(
                  children: [
                    Text(provider.name, style: AppTextStyles.bold),
                    Text(provider.email, style: AppTextStyles.body),
                  ],
                ),
              ),

              // 📋 MENU OPTIONS
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
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Aboutme()),
                        );
                        Provider.of<AccountProvider>(context,
                                listen: false)
                            .loadUserData();
                      },
                    ),

                    // 🔽 ADD THIS AT END FOR EXTRA SPACE
                   
                    AccountRow(
                icon: Icons.inventory_outlined,
                title: "My Orders",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const Myorders()),
                  );
                },
              ),
              AccountRow(
                icon: Icons.favorite_border,
                title: "My Favourites",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Favourites()),
                  );
                },
              ),
              AccountRow(
                icon: Icons.location_on_outlined,
                title: "My Address",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyAddress()),
                  );
                },
              ),
              AccountRow(
                icon: Icons.credit_card_outlined,
                title: "Credit cards",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MyCards()),
                  );
                },
              ),
              AccountRow(
                icon: Icons.currency_exchange,
                title: "Transactions",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Transactions()),
                  );
                },
              ),
              AccountRow(
                icon: Icons.notifications_outlined,
                title: "Notifications",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Notifications()),
                  );
                },
              ),
              AccountRow(
                icon: Icons.logout_outlined,
                title: "Sign out",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Logout",
                          style: AppTextStyles.green),
                      content: Text(
                          "Are you sure you want to logout?",
                          style: AppTextStyles.body),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(context),
                          child: Text("Cancel",
                              style:
                                  AppTextStyles.greenText),
                        ),
                        TextButton(
                          onPressed: () async {
                            await Supabase.instance.client
                                .auth
                                .signOut();

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Login()),
                              (route) => false,
                            );
                          },
                          child: Text("Logout",
                              style:
                                  AppTextStyles.greenText),
                        ),
                      ],
                    ),
                  );
                },
              ),
               const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
),
    
  
    );
  }
}