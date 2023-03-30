import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

part 'alert_state.dart';

@lazySingleton
class AlertCubit extends Cubit<AlertState?> {
  AlertCubit() : super(null);

  showAlertDialog(AlertState alert) => emit(alert);

  clearAlert() => emit(null);
}
