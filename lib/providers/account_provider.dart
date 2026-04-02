import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountProvider extends ChangeNotifier {
  String name = "Username";
  String email = "";
  String phone = "";

  File? image;

  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  void clearUserData() {
  name = "";
  email = "";
  image = null;
  notifyListeners();
}

  // 🔥 Load user data
  Future<void> loadUserData() async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;

  if (user == null) return;

  // ✅ START LOADING
  isLoading = true;
  notifyListeners();

  try {
    final data = await supabase
        .from('users_data')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (data == null) {
      await supabase.from('users_data').insert({
        'id': user.id,
        'name': "Username",
        'email': user.email,
        'phone': "",
      });

      name = "Username";
      email = user.email ?? "";
      phone = "";
    } else {
      name = data['name'] ?? "Username";
      email = data['email'] ?? user.email ?? "";
      phone = data['phone'] ?? "";
    }
  } catch (e) {
    print("Error: $e");
  }

  // ✅ STOP LOADING
  isLoading = false;
  notifyListeners();
}
  // 📷 Pick from gallery
  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  // 📷 Pick from camera
  Future<void> pickImageFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }
}