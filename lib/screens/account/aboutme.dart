import 'package:bigcart/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Aboutme extends StatefulWidget {
  const Aboutme({super.key});

  @override
  State<Aboutme> createState() => _AboutmeState();
}

class _AboutmeState extends State<Aboutme> {
  final supabase = Supabase.instance.client;
  TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmController = TextEditingController();
  bool isObscure=true;
   @override
  void initState() {
    super.initState();
    _loadUserData(); 
  }

 Future<void> _loadUserData() async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;

  if (user == null) return;

  try {
    final data = await supabase
        .from('users_data')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (data != null) {
      setState(() {
        nameController.text = data['name'] ?? "";
        emailController.text = data['email'] ?? user.email ?? "";
        phoneController.text = data['phone'] ?? "";
      });
    } else {
      // fallback (first time)
      setState(() {
        nameController.text = "";
        emailController.text = user.email ?? "";
        phoneController.text = "";
      });
    }
  // ignore: empty_catches
  } catch (e) {
  }
}
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(backgroundColor:  const Color(0xFFF4F5F9),
    appBar: AppBar(
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
      style: AppTextStyles.title
    ),
  ),
 body: SingleChildScrollView(
  child: Container(
   
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text("Personal Details",
            style: AppTextStyles.title),

       SizedBox(height: size.height*0.013,),

        _buildInput(nameController, "Username", Icons.person_outline),
        _buildInput(emailController, "Email", Icons.email_outlined),
        _buildInput(phoneController, "Phone number", Icons.phone_outlined),

        SizedBox(height: size.height*0.022,),

        Text("Change password",
            style: AppTextStyles.title),

        SizedBox(height: size.height*0.015,),

        _buildPassword(passwordController, "Current Password"),
        _buildInput(confirmController, "Confirm", Icons.lock_outline),

       SizedBox(height: size.height*0.2,),

       Container(
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
                               onPressed: () async {
        final user = supabase.auth.currentUser;

        if (user == null) return;

        await supabase.from('users_data').upsert({
          'id': user.id,
          'name': nameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
        });

        // ignore: use_build_context_synchronously
        Navigator.pop(context, {
          "name": nameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
        });
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
                                     "Save",
                                     style: AppTextStyles.whiteText
                                   ),
                                 
                               
                             ),
                           ),
      ],
    ),
  ),
)
  );
  }
  // ignore: strict_top_level_inference
  Widget _buildInput(controller, hint, icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
        prefixIcon: Icon(icon),
      ),
    ),
  );
}
// ignore: strict_top_level_inference
Widget _buildPassword(controller, hint) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
        ),
      ),
    ),
  );
}

}