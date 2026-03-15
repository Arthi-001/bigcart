import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingHeader extends StatelessWidget {
  final String imagePath;
  final String title;

  const OnboardingHeader({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [

        /// Background Image (Half Screen)
        SizedBox(
          height: size.height * 0.6,
          width: double.infinity,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            cacheWidth: size.width.toInt(),
    cacheHeight: (size.height * 0.6).toInt(),
          ),
        ),

        /// Back Arrow + Title
        Positioned(
          top: size.height * 0.06,
          left: 10,
          right: 10,
          child: Row(
            children: [

              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(width:size.width*0.04) // keeps title centered
            ],
          ),
        ),
      ],
    );
  }
}