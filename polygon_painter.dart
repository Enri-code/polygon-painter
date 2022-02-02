// ignore_for_file: public_member_api_docs

import 'dart:math' as math;
import 'package:flutter/material.dart';

class PolygonPainter extends CustomPainter {
  const PolygonPainter({
    this.sides = 4,
    this.color = Colors.black,
    this.strokeWidth = 2,
    this.angleOffset = 0,
    this.style = PaintingStyle.stroke,
  });

  ///The color of the polygon
  final Color color;

  ///The amount of sized the polygon will have
  final int sides;
  final double strokeWidth;

  ///The rotation offset of the polygon, this isn't necessary
  ///
  ///[angleOffset] is in radians
  final double angleOffset;
  final PaintingStyle style;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = style;
    canvas.drawPath(getPath(size), paint);
  }

  /// This creates the path to be rendered and returns it
  Path getPath(Size size) {
    final radius = size.shortestSide * 0.5;
    var angle = math.pi * (0.5 - (1 / sides)) + angleOffset;
    final path = Path();

    var loopCount = 0;
    while (loopCount < sides) {
      final point = (Offset(math.cos(angle), math.sin(angle)) * radius)
          .translate(size.width * 0.5, size.height * 0.5);
      if (loopCount == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
      angle += (math.pi * 2) / sides;
      loopCount++;
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(PolygonPainter oldDelegate) => false;
}
