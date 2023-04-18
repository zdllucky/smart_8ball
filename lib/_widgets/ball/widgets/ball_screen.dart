import 'dart:math';

import 'package:flutter/cupertino.dart';

class BallScreen extends StatelessWidget {
  const BallScreen({
    super.key,
    required this.lightSource,
    required this.child,
    this.opacity = 1,
  });
  final Offset lightSource;
  final Widget child;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final innerShadowWidth = lightSource.distance * 0.1;
    final portalShadowOffset =
        Offset.fromDirection(pi + lightSource.direction, innerShadowWidth);

    return Container(
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.difference,
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              CupertinoColors.systemTeal.darkColor.withOpacity(opacity),
              CupertinoColors.systemIndigo.highContrastColor
                  .withOpacity(.6 * opacity),
            ],
          ),
        ),
        child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [
                    Color(0x661F1F1F),
                    CupertinoColors.black.withOpacity(.8),
                  ],
                  center:
                      Alignment(portalShadowOffset.dx, portalShadowOffset.dy),
                  stops: [1 - innerShadowWidth, 1]),
              shape: BoxShape.circle,
            ),
            child: Opacity(opacity: opacity, child: child)));
  }
}
