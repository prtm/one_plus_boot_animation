import 'package:flutter/material.dart';

class TextOneClipper extends CustomClipper<Path> {
  final double thickness;
  const TextOneClipper({
    @required this.thickness,
  });
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0.0, 0.0)
      ..lineTo(size.width / 2 + thickness / 2, 0.0)
      ..lineTo(size.width / 2 + thickness / 2, size.height - thickness)
      ..lineTo(size.width, size.height - thickness)
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height)
      ..lineTo(0.0, size.height - thickness)
      ..lineTo(size.width / 2 - thickness / 2, size.height - thickness)
      ..lineTo(size.width / 2 - thickness / 2, thickness)
      ..lineTo(0.0, thickness)
      ..close();
  }

  @override
  bool shouldReclip(TextOneClipper oldClipper) => false;
}
