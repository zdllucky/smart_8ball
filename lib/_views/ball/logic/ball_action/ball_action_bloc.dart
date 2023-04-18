import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'ball_action_event.dart';
part 'ball_action_state.dart';

@injectable
class BallActionBloc extends Bloc<BallActionEvent, BallActionState> {
  BallActionBloc() : super(BallActionInitial()) {
    on<BallActionEvent>((
      event,
      emit,
    ) {
      switch (event.runtimeType) {
        case StartRecording:
          switch (state.runtimeType) {
            case BallActionInitial:
              emit(BallActionRecording((event as StartRecording).side));
              break;
            default:
              emit(BallActionInitial(reset: true));
          }
          break;
        case ContinueRecordingOrSubmit:
          if (state is BallActionRecording) {
            final e = event as ContinueRecordingOrSubmit;

            if (e.canSubmit && e.side > .7) {
              emit(BallActionWriting());
            } else {
              emit(BallActionRecording(
                event.side,
                continues: true,
              ));
            }
          }
          break;
        case StartWriting:
          if (state is BallActionRecording) {
            emit(BallActionWriting());
          }
          if (state is BallActionWriting) {
            break;
          } else {
            emit(BallActionInitial(reset: true));
          }
          break;
        case SubmitWriting:
          if (state is BallActionWriting) {
            emit(BallActionSubmittingText((event as SubmitWriting).text));
          } else {
            emit(BallActionInitial(reset: true));
          }
          break;
        case SubmitRecording:
          debugPrint('SubmitRecording: $state');
          if (state is BallActionRecording) {
            emit(BallActionSubmittingAudio());
          } else {
            emit(BallActionInitial(reset: true));
          }
          break;
        case StopRecording:
          emit(BallActionInitial());
          break;
        case StopWriting:
          emit(BallActionInitial(reset: true));
          break;
        case BallWasReset:
          if (state is BallActionInitial &&
              (state as BallActionInitial).reset) {
            emit(BallActionInitial());
          }
          break;
        default:
          emit(BallActionInitial(reset: true));
      }
    });
  }

  @override
  void onTransition(Transition<BallActionEvent, BallActionState> transition) {
    if (transition.currentState != transition.nextState &&
        (transition.event is! ContinueRecordingOrSubmit ||
            transition.nextState is! BallActionRecording ||
            transition.nextState.runtimeType !=
                transition.currentState.runtimeType)) {
      debugPrint(
          "${transition.event.runtimeType}:\t\t${transition.currentState.runtimeType} -> ${transition.nextState.runtimeType}");
    }
    super.onTransition(transition);
  }
}
