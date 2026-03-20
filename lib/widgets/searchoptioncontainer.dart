import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchOptionContainer extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const SearchOptionContainer({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.grey.shade600),
              const SizedBox(width: 10),
              Text(
                text,
                style: GoogleFonts.poppins( color:Colors.grey.shade600,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}