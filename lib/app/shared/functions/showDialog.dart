import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

Future<T?> showAlertDialog<T>(BuildContext context,
    {required Text alert,
    Widget? content,
    bool? barrierDismissible,
    List<CupertinoDialogAction>? actions}) {
  final defaultActions = [
    CupertinoDialogAction(
      isDefaultAction: true,
      onPressed: context.pop,
      child: const Text('Ok!'),
    ),
  ];
  return showCupertinoModalPopup<T>(
    barrierDismissible: barrierDismissible ?? false,
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: alert,
      content: content,
      actions: actions ?? defaultActions,
    ),
  );
}
