part of 'alert_cubit.dart';

@immutable
abstract class AlertState {}

class BasicAlert<T> extends AlertState {
  BasicAlert({
    required this.alert,
    this.content,
    this.barrierDismissible,
    this.actions,
    this.onCloseDialog,
  });

  final Text alert;
  final Widget? content;
  final bool? barrierDismissible;
  final List<CupertinoDialogAction>? actions;
  final T Function()? onCloseDialog;
}
