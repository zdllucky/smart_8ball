import 'package:flutter/cupertino.dart';

class Ball extends StatelessWidget {
  const Ball(
      {super.key,
      required this.diameter,
      required this.lightSource,
      required this.child});
  final double diameter;
  final Offset lightSource;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      foregroundDecoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              const Color(0x00000000),
              CupertinoColors.systemYellow.highContrastColor
                  .withOpacity(.15)
                  .withRed(170),
            ],
            stops: const [.65, 1],
            radius: .49,
            center: const Alignment(.2, -.10),
          )),
      decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: const [
              Color(0xff96C3B1),
              Color(0xff445459),
              Color(0xff272C2E),
              Color(0xff111212),
              Color(0xff10100F),
            ],
            tileMode: TileMode.mirror,
            center: Alignment(lightSource.dx, lightSource.dy),
          ),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.white.withOpacity(0.6),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: CupertinoColors.systemYellow.withOpacity(0.6),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: CupertinoColors.systemYellow.withOpacity(0.7),
              spreadRadius: 2,
              blurRadius: 20,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: CupertinoColors.activeOrange.withOpacity(0.3),
              spreadRadius: 20,
              blurRadius: 30,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: CupertinoColors.activeOrange.withOpacity(0.5),
              spreadRadius: 10,
              blurRadius: 50,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: CupertinoColors.systemOrange.highContrastColor
                  .withOpacity(.15),
              spreadRadius: 50,
              blurRadius: 250,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: CupertinoColors.systemYellow.darkHighContrastColor
                  .withOpacity(.05),
              spreadRadius: 150,
              blurRadius: 350,
              offset: const Offset(0, 0),
            ),
          ],
          shape: BoxShape.circle),
      child: child,
    );
  }
}
