import 'package:flutter/cupertino.dart';

class CrtScanlinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = CupertinoColors.systemBlue.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    const double lineHeight = 3;

    for (double y = 0; y < size.height; y += lineHeight * 2) {
      canvas.drawRect(Rect.fromLTWH(0, y, size.width, lineHeight), linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
