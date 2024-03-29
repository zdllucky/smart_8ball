part of 'ball_action_bloc.dart';

extension BallActionHandler on BallActionBloc {
  Future<void> _submitWritingCaseHandler(
    SubmitWriting event,
    emit,
  ) async {
    if (state is BallActionWriting) {
      try {
        emit(BallActionSubmittingText(event.question));

        final res = await _functionsService.answerQuestion(event.question);

        emit(BallActionResult(res.answer));
      } on DioError catch (e) {
        _alertCubit.showAlertDialog(BasicAlert(
          alert: const Text('Oops...'),
          content: Text(e.message ?? "Undefined error"),
        ));

        emit(BallActionInitial(reset: true));
      } catch (e) {
        _alertCubit.showAlertDialog(BasicAlert(
          alert: const Text('Oops...'),
          content: Text(e.toString()),
        ));

        emit(BallActionInitial(reset: true));
      }
    } else {
      emit(BallActionInitial(reset: true));
    }
  }

  Future<void> _continueRecordingOrSubmitHandler(
    ContinueRecordingOrSubmit event,
    emit,
  ) async {
    if (state is BallActionRecording) {
      if (event.canSubmit && event.side > .7) {
        emit(BallActionWriting());
      } else if (event.canSubmit && event.side < -.7) {
        if (!await _recordService.isRecording) {
          return;
        }

        final rec = await _recordService.stop(playRecord: kDebugMode);

        // TODO: Implement submit recording

        if (rec != null) {
          emit(BallActionSubmittingAudio());
        } else {
          emit(BallActionInitial(reset: true));
        }
      } else {
        emit(BallActionRecording(
          event.side,
          continues: true,
        ));
      }
    }
  }
}
