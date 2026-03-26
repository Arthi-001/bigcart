import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderSteps extends StatelessWidget {
  final int currentStep;

  const OrderSteps({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
   
    return Row(
      children: [
        _buildStep(context,1),
        _buildLine(1),
        _buildStep(context,2),
        _buildLine(2),
        _buildStep(context,3),
      ],
    );
  }

  Widget _buildStep(BuildContext context,int step) {
    final Size size = MediaQuery.of(context).size;
    bool isCompleted = currentStep > step;
    bool isActive = currentStep == step;

    return Container(
      width: size.height*0.07,
      height: size.height*0.07,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: (isCompleted || isActive)
            ? Colors.green
            : Colors.white,
        shape: BoxShape.circle,
      ),
      child: isCompleted
          ?  Icon(Icons.check, color: Colors.white, size: 18)
          : Text(
              "$step",
              style: GoogleFonts.poppins(
                color: isActive ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }

  Widget _buildLine(int step) {
    bool isActive = currentStep > step;

    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? Colors.green : Colors.grey.shade200,
      ),
    );
  }
}