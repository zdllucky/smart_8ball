import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'ball.dart';
import 'ball_screen.dart';
import 'prediction.dart';

class BallMotion extends StatefulWidget {
  const BallMotion({super.key});

  @override
  State<BallMotion> createState() => _BallMotionState();
}

class _BallMotionState extends State<BallMotion>
    with SingleTickerProviderStateMixin {
  static const lightSource = Offset(.33, -0.5);
  static const restPosition = Offset(0, -0.15);

  late AnimationController controller;
  late Animation animation;

  String prediction = 'The MAGIC\n8-Ball';
  Offset tapPosition = Offset.zero;
  double windowSizeMultiplier = 1.1;
  double wobble = 0.0;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 1500));
    controller.addListener(() => setState(() {}));

    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.elasticIn);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = Size.square(MediaQuery.of(context).size.shortestSide * .6);
    final windowPosition =
        Offset.lerp(restPosition, tapPosition, animation.value)!;

    return GestureDetector(
      onPanUpdate: (details) => _update(details.localPosition, size),
      onPanStart: (details) => _start(details.localPosition, size),
      onPanEnd: (_) => _end(),
      child: Ball(
          diameter: size.shortestSide,
          lightSource: lightSource,
          child: Transform(
            origin: Size.square(size.shortestSide).center(Offset.zero),
            transform: Matrix4.identity()
              ..translate(windowPosition.dx * size.height / 2,
                  windowPosition.dy * size.height / 2)
              ..scale(
                  (.5 * windowSizeMultiplier) - .15 * windowPosition.distance)
              ..rotateZ(windowPosition.direction)
              ..rotateY(windowPosition.distance * pi / 2)
              ..rotateZ(-windowPosition.direction),
            child: BallScreen(
                lightSource: lightSource - windowPosition,
                child: Opacity(
                    opacity: 1 - controller.value,
                    child: Transform.rotate(
                        angle: wobble, child: Prediction(text: prediction)))),
          )),
    );
  }

  void _update(Offset position, Size size) {
    Offset tapPosition = Offset((2 * position.dx / size.width) - 1,
        (2 * position.dy / size.height) - 1);
    if (tapPosition.distance > 0.85) {
      tapPosition = Offset.fromDirection(tapPosition.direction, 0.85);
    }
    setState(() => this.tapPosition = tapPosition);
  }

  void _start(Offset offset, Size size) {
    controller.forward(from: 0);
    _update(offset, size);
  }

  _end() {
    final random = Random();
    prediction = predictions[random.nextInt(predictions.length)];
    wobble = random.nextDouble() * (wobble.isNegative ? 0.5 : -0.5);
    controller.reverse(from: 1);
  }
}
