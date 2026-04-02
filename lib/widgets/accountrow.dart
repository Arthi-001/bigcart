import 'package:bigcart/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class AccountRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final VoidCallback onPressed;

  const AccountRow({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Icon(icon, color: Colors.green),
            const SizedBox(width: 15),

            Expanded(
              child: Text(
                title,
                style: AppTextStyles.title
              ),
            ),

            const Icon(Icons.navigate_next, size: 20, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}