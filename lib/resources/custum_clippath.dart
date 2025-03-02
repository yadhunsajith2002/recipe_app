import 'package:flutter/material.dart';

class CustumClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    var path_0 = Path();

    path_0.moveTo(size.width * 0.0025000, size.height * 0.0031250);
    path_0.quadraticBezierTo(size.width * 0.0025000, size.height * 0.6968750,
        size.width * 0.0025000, size.height * 0.9281250);
    path_0.cubicTo(
        size.width * 0.1595000,
        size.height * 0.9678125,
        size.width * 0.4255000,
        size.height * 1.0021875,
        size.width * 0.4985000,
        size.height * 0.9968750);
    path_0.cubicTo(
        size.width * 0.6315000,
        size.height * 0.9987500,
        size.width * 0.8420000,
        size.height * 0.9700000,
        size.width * 1.0025000,
        size.height * 0.9343750);
    path_0.quadraticBezierTo(
        size.width * 1.0018750, size.height * 0.7007813, size.width, 0);
    path_0.lineTo(size.width * 0.0025000, size.height * 0.0031250);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // Return true if you want to reclip on each frame, false otherwise
  }
}
