import 'dart:math';

import 'package:flutter/cupertino.dart';

class BallShadow extends StatelessWidget {
  const BallShadow({super.key, required this.diameter});
  final double diameter;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..rotateX(pi / 2.1),
      origin: Offset(0, diameter),
      child: Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  blurRadius: 25,
                  color: CupertinoColors.systemGrey.withOpacity(0.6))
            ],
          )),
    );
  }
}
