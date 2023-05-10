part of 'ball_action_bloc.dart';

@immutable
abstract class BallActionEvent {}

class StartRecording extends BallActionEvent {
  final double side;

  StartRecording(this.side);
}

class StartWriting extends BallActionEvent {}

class SubmitWriting extends BallActionEvent {
  final String question;

  SubmitWriting(this.question);
}

class SubmitRecording extends BallActionEvent {}

class StopRecording extends BallActionEvent {}

class StopWriting extends BallActionEvent {}

class BallWasReset extends BallActionEvent {}

class ContinueRecordingOrSubmit extends BallActionEvent {
  final double side;
  final bool canSubmit;

  ContinueRecordingOrSubmit(this.side, {this.canSubmit = true});
}
