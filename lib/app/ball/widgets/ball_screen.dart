import 'dart:math';

import 'package:flutter/cupertino.dart';

class BallScreen extends StatelessWidget {
  const BallScreen({super.key, required this.lightSource, required this.child});
  final Offset lightSource;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final innerShadowWidth = lightSource.distance * 0.1;
    final portalShadowOffset =
        Offset.fromDirection(pi + lightSource.direction, innerShadowWidth);

    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
                colors: const [Color(0x661F1F1F), CupertinoColors.black],
                center: Alignment(portalShadowOffset.dx, portalShadowOffset.dy),
                stops: [1 - innerShadowWidth, 1])),
        child: child);
  }
}
