import 'package:bigcart/screens/dashboard/bottomnavigator.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupProvider extends ChangeNotifier {
  bool isLoading = false;
String passwordError = "";
void validatePassword(String password) {
  if (password.isEmpty) {
    passwordError = "Password is required";
  } else if (password.length < 6) {
    passwordError = "Minimum 6 characters required";
  } else if (password.length > 8) {
    passwordError = "Maximum 8 characters allowed";
  } else {
    passwordError = "";
  }

  notifyListeners();
}
  Future<void> signup(
    String email,
    String phone,
    String password,
    BuildContext context,
  ) async {
    
    if (email.isEmpty || phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    if (!email.contains("@")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter valid email")),
      );
      return;
    }

    try {
      isLoading = true;
      notifyListeners();

      final supabase = Supabase.instance.client;

      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        
        await supabase.from('users_data').insert({
          'id': response.user!.id,
          'phone': phone,
        });

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup successful! ")),
        );

        Navigator.pushReplacement(
  // ignore: use_build_context_synchronously
  context,
  MaterialPageRoute(builder: (_) =>BottomNavigator()),
);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup failed")),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}