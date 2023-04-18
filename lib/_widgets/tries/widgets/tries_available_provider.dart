import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../_support/di/injections.dart';
import '../logic/tries_available_cubit.dart';

class TriesAvailableProvider extends StatelessWidget {
  const TriesAvailableProvider({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) =>
      BlocProvider<TriesAvailableCubit>(create: (_) => get(), child: child);
}
