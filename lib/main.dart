import 'package:bigcart/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://iaenxcyvdpshuotksrss.supabase.co', // YOUR URL
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlhZW54Y3l2ZHBzaHVvdGtzcnNzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQwNzU5MDYsImV4cCI6MjA4OTY1MTkwNn0.vhVJRVJQWBapCpqEN2QjCq3wqO4z_zp-naGfOnYqx_M', // 🔑 paste your anon key here
  );

  runApp(const MyApp());
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

