import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawCircle extends CustomPainter {
  Paint _paint;
  double dotRadius;
  bool isDarker;

  DrawCircle(double dotRadius, Color color) {
    this.dotRadius = dotRadius;
    this.isDarker = isDarker;

    _paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;
  }


  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), dotRadius, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}