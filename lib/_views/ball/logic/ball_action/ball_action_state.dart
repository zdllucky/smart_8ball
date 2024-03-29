part of 'ball_action_bloc.dart';

@immutable
abstract class BallActionState with AdvancedConditional {}

abstract class BallActionStateWithSide extends BallActionState {
  final Offset side;

  BallActionStateWithSide(this.side);
}

class BallActionInitial extends BallActionState {
  final bool reset;

  BallActionInitial({this.reset = false});
}

class BallActionResult extends BallActionInitial {
  final String answer;

  BallActionResult(this.answer, {bool reset = false}) : super(reset: reset);
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

class BallActionSubmittingText extends BallActionState {
  final String text;

  BallActionSubmittingText(this.text);
}

mixin AdvancedConditional on Object {
  bool isOneOf(List<Type> list) => list.any((type) => runtimeType == type);
}
