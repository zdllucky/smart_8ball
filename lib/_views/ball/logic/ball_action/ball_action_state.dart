part of 'ball_action_bloc.dart';

@immutable
abstract class BallActionState {}

abstract class BallActionStateWithSide extends BallActionState {
  final Offset side;

  BallActionStateWithSide(this.side);
}

class BallActionInitial extends BallActionState {
  final bool reset;

  BallActionInitial({this.reset = false});
}

class BallActionRecording extends BallActionState {
  final double dy;
  final bool continues;

  BallActionRecording(this.dy, {this.continues = false});
}

class BallActionWriting extends BallActionStateWithSide {
  BallActionWriting() : super(const Offset(0, .85));
}

class BallActionSubmittingAudio extends BallActionStateWithSide {
  BallActionSubmittingAudio() : super(const Offset(0, -.85));
}

class BallActionSubmittingText extends BallActionStateWithSide {
  final String text;

  BallActionSubmittingText(this.text) : super(const Offset(0, .85));
}
