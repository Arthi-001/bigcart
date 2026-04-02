import 'package:flutter/material.dart';

Color getPastelColor(String id) {
  final colors = [
    Colors.redAccent.shade100,
    Colors.greenAccent.shade100,
    Colors.green.shade100,
    Colors.red.shade100,
    Colors.blueGrey.shade100,
    Colors.yellowAccent.shade100,
  ];

  int index = id.hashCode % colors.length;
  return colors[index.abs()];
}