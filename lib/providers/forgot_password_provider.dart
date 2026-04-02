import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class ForgotPasswordProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<void> sendResetLink(String email, BuildContext context) async {
    if (email.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please enter email")),
    );
    return;
  }

  if (!email.contains("@") || !email.contains(".")) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Enter a valid email address")),
    );
    return;
  }

    try {
      isLoading = true;
      notifyListeners();

      await Supabase.instance.client.auth.resetPasswordForEmail(email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Reset link sent to your email")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}