import 'dart:math';

import 'package:flutter/material.dart';

class CircleDootedLine extends CustomPainter {
  CircleDootedLine(this.radius);

  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    const double filledCircleRadius = 1.5;
    const int numberOfDots = 30;
    const double radiantStep = 2 * pi / numberOfDots;

    for (int i = 0; i < numberOfDots; i++) {
      canvas.drawCircle(
        Offset(centerX + sin(i * radiantStep) * radius,
            centerY + cos(i * radiantStep) * radius),
        filledCircleRadius,
        Paint()
          ..color = i < (numberOfDots / 2) + 4
              ? const Color(0xFFFF0099)
              : const Color(0xFF1D74F5),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
