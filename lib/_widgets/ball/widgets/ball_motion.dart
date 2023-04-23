import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_8ball/_views/ball/__.dart';
import 'package:smart_8ball/_widgets/c_r_t_screen/__.dart';
import 'package:smart_8ball/_widgets/tries/__.dart';

import 'ball_animation_controller.dart';
import 'ball_screen.dart';
import 'ball_shape.dart';

part 'ball_motion_handlers.dart';

class BallMotion extends StatefulWidget {
  const BallMotion({super.key});

  @override
  State<BallMotion> createState() => _BallMotionState();
}

class _BallMotionState extends State<BallMotion> {
  static const lightSource = Offset(.33, -0.5);

  Offset tapPosition = Offset.zero;
  double windowSizeMultiplier = 1.1;
  double wobble = 0.0;
  bool _doesPanScreen = false;
  bool _onceBounceOnSubmit = false;

  @override
  Widget build(BuildContext context) {
    final size = Size.square(MediaQuery.of(context).size.shortestSide * .75);

    return BallAnimationController(
      builder: (context, controller, animation) {
        final windowPosition =
            Offset.lerp(const Offset(0, -0.15), tapPosition, animation.value)!;

        return BlocConsumer<BallActionBloc, BallActionState>(
          listener: (context, state) {
            if (state is BallActionInitial && state.reset) {
              final addEvent = context.read<BallActionBloc>().add;

              addEvent.call(BallWasReset());
              _end(controller: controller);
            } else if (state is BallActionSubmittingText) {
              _onceBounceOnSubmit = true;
              _end(controller: controller);
            }
          },
          builder: (context, state) => GestureDetector(
            onPanUpdate: (details) =>
                _delayed(() => _update(details.localPosition, size)),
            onPanStart: (details) => _delayed(() =>
                _start(details.localPosition, size, controller: controller)),
            onPanEnd: (_) => _delayed(_end(controller: controller)),
            child: BallShape(
                diameter: size.shortestSide,
                lightSource: lightSource,
                child: Transform(
                  origin: Size.square(size.shortestSide).center(Offset.zero),
                  transform: _ballScreenTransform(windowPosition, size),
                  child: Listener(
                    onPointerDown: (_) => setState(() => _doesPanScreen = true),
                    onPointerUp: (_) => setState(() => _doesPanScreen = false),
                    child: BallScreen(
                        lightSource: lightSource - windowPosition,
                        opacity: _ballScreenOpacity(controller: controller),
                        child: Transform.rotate(
                            angle: wobble,
                            child: CRTScreen(builder: _ballScreenBuilder))),
                  ),
                )),
          ),
        );
      },
    );
  }
}
