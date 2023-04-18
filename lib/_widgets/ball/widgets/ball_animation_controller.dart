import 'package:flutter/material.dart';

class BallAnimationController extends StatefulWidget {
  final Widget Function(BuildContext, AnimationController, Animation) builder;

  const BallAnimationController({super.key, required this.builder});

  @override
  State<BallAnimationController> createState() =>
      _BallAnimationControllerState();
}

class _BallAnimationControllerState extends State<BallAnimationController>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
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
  Widget build(BuildContext context) =>
      widget.builder(context, controller, animation);
}
