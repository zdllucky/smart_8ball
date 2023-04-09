import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/ball_action/ball_action_bloc.dart';
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

  bool _doesPanScreen = false;

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
    final size = Size.square(MediaQuery.of(context).size.shortestSide * .75);

    return BlocConsumer<BallActionBloc, BallActionState>(
      listener: (context, state) {
        if (state is BallActionInitial && state.reset) {
          final addEvent = context.read<BallActionBloc>().add;

          addEvent.call(BallWasReset());
          _end(addEventFn: addEvent, ballState: state);
        }
      },
      listenWhen: (previous, current) =>
          current is BallActionInitial && current.reset,
      builder: (context, state) {
        final windowPosition = Offset.lerp(
            restPosition,
            state is BallActionStateWithSide ? state.side : tapPosition,
            animation.value)!;

        return GestureDetector(
          onPanUpdate: (details) => _delayed(() => _update(
              details.localPosition, size,
              addEventFn: context.read<BallActionBloc>().add,
              ballState: state)),
          onPanStart: (details) => _delayed(
              () => _start(details.localPosition, size, ballState: state)),
          child: Ball(
              diameter: size.shortestSide,
              lightSource: lightSource,
              child: Transform(
                origin: Size.square(size.shortestSide).center(Offset.zero),
                transform: Matrix4.identity()
                  ..translate(windowPosition.dx * size.height / 2,
                      windowPosition.dy * size.height / 2)
                  ..scale((.5 * windowSizeMultiplier) -
                      .15 * windowPosition.distance)
                  ..rotateZ(windowPosition.direction)
                  ..rotateY(windowPosition.distance * pi / 2)
                  ..rotateZ(-windowPosition.direction),
                child: Listener(
                  onPointerDown: (_) => setState(() => _doesPanScreen = true),
                  onPointerUp: (_) => _end(
                      addEventFn: context.read<BallActionBloc>().add,
                      ballState: state),
                  // FIXIT: Fix bug when BallScreen widget follows pointer while ignoring bounds
                  child: BallScreen(
                      lightSource: lightSource - windowPosition,
                      child: Opacity(
                          opacity: 1 - controller.value,
                          child: Transform.rotate(
                              angle: wobble,
                              child: Prediction(text: prediction)))),
                ),
              )),
        );
      },
    );
  }

  void _update(
    Offset position,
    Size size, {
    required void Function(BallActionEvent event) addEventFn,
    required BallActionState ballState,
  }) {
    if (ballState is BallActionStateWithSide) return;

    Offset tapPosition = Offset((2 * position.dx / size.width) - 1,
        (2 * position.dy / size.height) - 1);

    if (tapPosition.distance > 0.85) {
      tapPosition = Offset.fromDirection(tapPosition.direction, 0.85);
    }

    if (tapPosition.dy.abs() < 0.7) {
      addEventFn(StartRecording(tapPosition.dy));
    } else {
      if (ballState is! BallActionWriting) {
        addEventFn(
            tapPosition.dy.isNegative ? SubmitRecording() : StartWriting());
      }
    }

    setState(() => this.tapPosition = tapPosition);
  }

  // FIXIT: Fix Ball clamping when touching right after reset
  void _start(
    Offset offset,
    Size size, {
    required BallActionState ballState,
  }) {
    if (ballState is BallActionStateWithSide) return;
    if (!_doesPanScreen) return;
    controller.forward(from: 0);
    // _update(offset, size);
  }

  _end({
    required void Function(BallActionEvent event) addEventFn,
    required BallActionState ballState,
  }) {
    final random = Random();

    if (ballState is BallActionStateWithSide) return;
    setState(() => _doesPanScreen = false);
    prediction = predictions[random.nextInt(predictions.length)];
    wobble = random.nextDouble() * (wobble.isNegative ? 0.5 : -0.5);
    controller.reverse(from: 1);
  }

  void _delayed(FutureOr<dynamic> Function()? fn,
      {Duration duration = const Duration(milliseconds: 5)}) {
    Future.delayed(duration, fn);
  }
}
