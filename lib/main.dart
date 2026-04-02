
import 'package:bigcart/providers/account_provider.dart';
import 'package:bigcart/providers/cart_provider.dart';
import 'package:bigcart/providers/favourites_provider.dart';
import 'package:bigcart/providers/forgot_password_provider.dart';
import 'package:bigcart/providers/home_provider.dart';
import 'package:bigcart/providers/loginprovider.dart';
import 'package:bigcart/providers/orderprovider.dart';
import 'package:bigcart/providers/searchhistoryprovider.dart';
import 'package:bigcart/providers/signup_provider.dart';
import 'package:bigcart/providers/transaction_provider.dart';
import 'package:bigcart/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://iaenxcyvdpshuotksrss.supabase.co', // YOUR URL
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlhZW54Y3l2ZHBzaHVvdGtzcnNzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQwNzU5MDYsImV4cCI6MjA4OTY1MTkwNn0.vhVJRVJQWBapCpqEN2QjCq3wqO4z_zp-naGfOnYqx_M',
    authOptions: const FlutterAuthClientOptions(
    authFlowType: AuthFlowType.pkce,
  ), // 🔑 paste your anon key here
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchHistoryProvider(), // <-- Add here
        ),
         ChangeNotifierProvider(
      create: (_) => OrdersProvider(),
      ),
       ChangeNotifierProvider(
        create: (_) => ForgotPasswordProvider()
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider()
          ),
           ChangeNotifierProvider(
            create: (_) => SignupProvider()
            ),
            ChangeNotifierProvider(
              create: (_) => HomeProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => CartProvider()
                ),
                ChangeNotifierProvider(
                  create: (_) => AccountProvider()
                  ),
                  ChangeNotifierProvider(
                    create: (_) => FavouritesProvider()
                    ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash()
    );
  }
}

