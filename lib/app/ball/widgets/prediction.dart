import 'dart:convert' show base64;

import 'package:flutter/cupertino.dart';

class Prediction extends StatelessWidget {
  const Prediction({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TrianglePainter(),
      child: Container(
          alignment: Alignment.center,
          child: Text(text,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(color: CupertinoColors.white, fontSize: 20))),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final _gradient = RadialGradient(colors: [
    CupertinoColors.systemYellow,
    CupertinoColors.systemYellow.highContrastColor,
    CupertinoColors.systemOrange.highContrastColor,
  ], radius: .65);

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()
      ..shader = _gradient.createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final path = Path()
      ..moveTo(w * 0.2, h * 0.3)
      ..quadraticBezierTo(w * 0.5, h * 0.1, w * 0.8, h * 0.3)
      ..quadraticBezierTo(w * 0.85, h * 0.6, w * 0.5, h * 0.85)
      ..quadraticBezierTo(w * 0.15, h * 0.6, w * 0.2, h * 0.3)
      ..close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(_TrianglePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_TrianglePainter oldDelegate) => false;
}

/// 8-Ball predictions obfuscated so as not to spoil the fun
final List<String> predictions = String.fromCharCodes(base64
        .decode('QXMgSSBzZWUgaXQsDQp5ZXN8QXNrIGFnYWluDQpsYXRlcnxCZXR0ZXIgbm90'
            'DQp0ZWxsIHlvdQ0Kbm93fENhbm5vdA0KcHJlZGljdA0Kbm93fENvbmNlbnRy'
            'YXRlDQphbmQgYXNrDQphZ2FpbnxEb24ndCBjb3VudA0Kb24gaXR8SXQgaXMN'
            'CmNlcnRhaW58SXQgaXMNCmRlY2lkZWRseQ0Kc298TW9zdCBsaWtlbHl8TXkg'
            'cmVwbHkNCmlzIG5vfE15IHNvdXJjZXMNCnNheSBub3xOb3xPdXRsb29rDQpn'
            'b29kfE91dGxvb2sgbm90DQpzbyBnb29kfFJheSBXZW5kZXJsaWNoDQpoYXMg'
            'YSBjb3Vyc2UNCm9uIGl0fFJlcGx5IGhhenkgLQ0KdHJ5IGFnYWlufFNpZ25z'
            'DQpwb2ludCB0bw0KeWVzfEZsdXR0ZXIgaGFzDQp0aGUgYW5zd2VyfFZlcnkN'
            'CmRvdWJ0ZnVsfFdpdGhvdXQgYQ0KZG91YnR8WWVzfFllcywgZGVmaW5pdGVs'
            'eXxZb3UgbWF5DQpyZWx5IG9uDQppdA=='))
    .split('|');
