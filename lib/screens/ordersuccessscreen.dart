import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // 🔹 AppBar
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

      // 🔹 Body
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
        
            // ✅ TITLE
            Text(
              "Your order was\nsuccessful !",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        
            SizedBox(height:size.height * 0.01, ),
        
            // 📄 SUBTEXT
            Text(
              "You will get a response within\na few minutes.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
        
            const Spacer(),
        
            // 🔘 BUTTON
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: size.width * 0.9,
                height: size.height * 0.07,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 175, 245, 95),
                      Colors.green,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // 👉 Navigate to tracking screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    "Track order",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}