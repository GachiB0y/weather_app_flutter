import 'dart:math';
import 'package:flutter/material.dart';

class IconPainterWidget extends CustomPainter {
  const IconPainterWidget();

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radiusGrow = size.width / 2;

    final dotPainter = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.0;
    final dotPainter2 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.0;
    final linesPainter = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;
    final linesPainter2 = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    canvas.drawCircle(Offset(centerX, centerY), radiusGrow, dotPainter);
    canvas.drawCircle(Offset(centerX, centerY), radiusGrow - 4, dotPainter2);
    canvas.drawLine(
        Offset(
          0,
          centerY,
        ),
        Offset(
          centerX * 2,
          centerY,
        ),
        linesPainter);
    canvas.drawLine(
        Offset(
          centerX,
          0,
        ),
        Offset(
          centerX,
          centerY * 2,
        ),
        linesPainter);

    canvas.drawLine(
        Offset(
          centerX - (radiusGrow * (sqrt(2) / 2)),
          centerY + (radiusGrow * (sqrt(2) / 2)),
        ),
        Offset(
          centerX + (radiusGrow * (sqrt(2) / 2)),
          centerY - (radiusGrow * (sqrt(2) / 2)),
        ),
        linesPainter2);

    canvas.drawLine(
        Offset(
          centerX + (radiusGrow * (sqrt(2) / 2)),
          centerY - (radiusGrow * (sqrt(2) / 2)),
        ),
        Offset(
          centerX + ((3 / 4) * radiusGrow * cos(1.18)),
          centerY - ((3 / 4) * radiusGrow * sin(1.18)),
        ),
        linesPainter2);

    canvas.drawLine(
        Offset(
          centerX + (radiusGrow * (sqrt(2) / 2)),
          centerY - (radiusGrow * (sqrt(2) / 2)),
        ),
        Offset(
          centerX + ((3 / 4) * radiusGrow * cos(0.39)),
          centerY - ((3 / 4) * radiusGrow * sin(0.39)),
        ),
        linesPainter2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}