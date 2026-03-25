import 'dart:ui';

import 'package:flutter/material.dart';

class CurvedContainerClipper extends CustomClipper<Path> {
  @override
 Path getClip(Size size) {
    Path path = Path();

    // top rectangle
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.4);

    // 🔥 U-SHAPE CURVE (smooth semicircle)
    path.quadraticBezierTo(
      size.width / 2,      // center
      size.height * 0.75,  // depth of U (increase for deeper curve)
      0,
      size.height * 0.4,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}