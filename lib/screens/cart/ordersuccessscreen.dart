import 'package:bigcart/screens/account/myorders.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
void initState() {
  super.initState();

  Future.delayed(const Duration(seconds: 2), () {
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const Myorders(),
      ),
      (route) => false,
    );
  });
}
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Order Success",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Center(
        child: Column(
          
          children: [
        
            SizedBox(height: size.height * 0.2,),
            Icon(
              Icons.shopping_bag_outlined,
              size: size.height * 0.15,
              color: Colors.lightGreen,
            ),
        
             SizedBox(height:size.height * 0.02, ),
        
            Text(
              "Your order was\nsuccessful !",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        
            SizedBox(height:size.height * 0.01, ),
    
            Text(
              "You will get a response within\na few minutes.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
        
            const Spacer(),
        
            
          ],
        ),
      ),
    );
  }
}