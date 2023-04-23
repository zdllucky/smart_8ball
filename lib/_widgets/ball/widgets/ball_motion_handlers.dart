part of 'ball_motion.dart';

extension on _BallMotionState {
  void _update(
    Offset position,
    Size size,
  ) {
    /// Stop updating if the ball is in the process of writing or submitting
    if (_isPanAllowedByBallState) return;

    /// Calculate screen position
    Offset tapPosition = Offset((2 * position.dx / size.width) - 1,
        (2 * position.dy / size.height) - 1);

    /// Limit screen position to a circle within a ball
    if (tapPosition.distance > 0.85) {
      tapPosition = Offset.fromDirection(tapPosition.direction, 0.85);
    }

    /// Update screen position
    setState(() => this.tapPosition = tapPosition);

    /// Update ball state
    ballActionBloc
        .add(ContinueRecordingOrSubmit(tapPosition.dy, canSubmit: haveTries));
  }

  void _start(
    Offset offset,
    Size size, {
    required AnimationController controller,
  }) {
    if (_isPanAllowedByBallState || !_doesPanScreen) return;

    ballActionBloc.add(StartRecording(offset.dy));
    controller.forward(from: 0);
    _update(offset, size);
  }

  _end({
    required AnimationController controller,
  }) {
    if (_isPanAllowedByBallState && !_onceBounceOnSubmit) {
      return;
    }
    if (ballActionBloc.state is BallActionRecording) {
      ballActionBloc.add(StopRecording());
    }

    setState(() => _doesPanScreen = false);

    _onceBounceOnSubmit = false;
    wobble = Random().nextDouble() * (wobble.isNegative ? 0.5 : -0.5);
    controller.reverse(from: 1);
  }

  void _delayed(FutureOr<dynamic> Function()? fn,
      {Duration duration = const Duration(milliseconds: 5)}) {
    Future.delayed(duration, fn);
  }

  Matrix4 _ballScreenTransform(Offset position, Size size) => Matrix4.identity()
    ..translate(position.dx * size.height / 2, position.dy * size.height / 2)
    ..scale((.5 * windowSizeMultiplier) - .15 * position.distance)
    ..rotateZ(position.direction)
    ..rotateY(position.distance * pi / 2)
    ..rotateZ(-position.direction);

  double _ballScreenOpacity({required AnimationController controller}) {
    if (!haveTries &&
        ballActionBloc.state
            .isOneOf([BallActionInitial, BallActionRecording])) {
      return 1;
    } else if (ballActionBloc.state.isOneOf([
      BallActionRecording,
    ])) {
      return controller.value;
    } else {
      return 1.0 - controller.value;
    }
  }

  Widget _ballScreenBuilder(context, animation) {
    if (!haveTries) {
      return NoBattery(animation: animation);
    } else if (ballActionBloc.state is BallActionInitial) {
      return InitialHelp(animation: animation);
    } else if (ballActionBloc.state is BallActionRecording) {
      return Recording(animation: animation);
    } else if (ballActionBloc.state is BallActionSubmittingText) {
      return LoadingAnswer(animation: animation);
    }

    return TextResponse("", animation: animation);
  }

  BallActionBloc get ballActionBloc => context.read<BallActionBloc>();
  TriesAvailableCubit get triesAvailableCubit =>
      context.read<TriesAvailableCubit>();

  bool get haveTries =>
      (triesAvailableCubit.state?.data()?.resources.basicTries ?? 0) > 0;

  bool get _isPanAllowedByBallState => ballActionBloc.state
      .isOneOf([BallActionStateWithSide, BallActionSubmittingText]);
}
