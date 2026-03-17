import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const AccountRow({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Icon(icon, color: Colors.green),
            const SizedBox(width: 15),

            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const Icon(Icons.navigate_next, size: 20, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}