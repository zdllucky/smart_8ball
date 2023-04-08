import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_8ball/_support/tries/logic/tries_available_cubit.dart';

import '../../di/injections.dart';

class TriesAvailableProvider extends StatelessWidget {
  const TriesAvailableProvider({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) =>
      BlocProvider<TriesAvailableCubit>(create: (_) => get(), child: child);
}
