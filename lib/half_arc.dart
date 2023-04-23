import 'dart:math' as math;

import 'package:flutter/material.dart';

class RightBorder extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    final path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(
        size.width + 20, size.height); // + 10 is to hide the last stripe
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, 0);
    path.arcToPoint(Offset(size.width / 2, size.height),
        radius: const Radius.circular(10));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class LeftBorder extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    final path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width / 2, 0);
    path.arcToPoint(
      Offset(size.width / 2, size.height),
      radius: const Radius.circular(10),
      clockwise: false,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
