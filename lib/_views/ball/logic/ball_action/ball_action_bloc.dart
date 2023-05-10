import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_8ball/_support/functions/__.dart';
import 'package:smart_8ball/_support/record/__.dart';
import 'package:smart_8ball/_widgets/alert/__.dart';

part 'ball_action_event.dart';
part 'ball_action_handler.dart';
part 'ball_action_state.dart';

@injectable
class BallActionBloc extends Bloc<BallActionEvent, BallActionState> {
  final FunctionsService _functionsService;
  final AlertCubit _alertCubit;
  final RecordService _recordService;

  BallActionBloc(this._functionsService, this._alertCubit, this._recordService)
      : super(BallActionInitial()) {
    on<BallActionEvent>((
      event,
      emit,
    ) async {
      switch (event.runtimeType) {
        case StartRecording:
          switch (state.runtimeType) {
            case BallActionInitial:
            case BallActionResult:
              await _recordService.start();
              emit(BallActionRecording((event as StartRecording).side));

              break;
            default:
              emit(BallActionInitial(reset: true));
          }
          break;
        case ContinueRecordingOrSubmit:
          await _continueRecordingOrSubmitHandler(
            event as ContinueRecordingOrSubmit,
            emit,
          );
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
          await _submitWritingCaseHandler(
            event as SubmitWriting,
            emit,
          );
          break;
        case SubmitRecording:
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
            _recordService.stop(cancel: true);
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
