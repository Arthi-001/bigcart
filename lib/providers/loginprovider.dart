import 'package:bigcart/screens/dashboard/bottomnavigator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
   
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email & Password required")),
      );
      return;
    }

    try {
      isLoading = true;
      notifyListeners();

      final supabase = Supabase.instance.client;

      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool("isLoggedIn", true);

       Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => const BottomNavigator()),
);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed")),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}