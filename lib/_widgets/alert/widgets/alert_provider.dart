import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_support/di/injections.dart';
import '../logic/alert_cubit.dart';

class AlertProvider extends StatelessWidget {
  const AlertProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlertCubit>(
        create: (context) => get(),
        child: BlocListener<AlertCubit, AlertState?>(
          listener: (context, state) {
            if (state is BasicAlert) {
              final alert = state.alert;
              defaultActions() => [
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Ok!'),
                    ),
                  ];

              context.read<AlertCubit>().clearAlert();

              showCupertinoModalPopup<void>(
                barrierDismissible: state.barrierDismissible ?? false,
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                  title: alert,
                  content: state.content,
                  actions: state.actions ?? defaultActions(),
                ),
              ).whenComplete(() => state.onCloseDialog?.call());
            }
          },
          child: child,
        ));
  }
}
