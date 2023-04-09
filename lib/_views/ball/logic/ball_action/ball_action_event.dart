part of 'ball_action_bloc.dart';

@immutable
abstract class BallActionEvent {}

class StartRecording extends BallActionEvent {
  final double side;

  StartRecording(this.side);
}

class StartWriting extends BallActionEvent {}

class SubmitWriting extends BallActionEvent {
  final String text;

  SubmitWriting(this.text);
}

class SubmitRecording extends BallActionEvent {}

class StopRecording extends BallActionEvent {}

class StopWriting extends BallActionEvent {}

class BallWasReset extends BallActionEvent {}
