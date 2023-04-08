import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_support/di/injections.dart';
import '../logic/auth/auth_cubit.dart';

class AuthProvider extends StatelessWidget {
  final Widget? child;

  const AuthProvider({super.key, this.child});

  @override
  Widget build(BuildContext context) =>
      BlocProvider<AuthCubit>(create: (_) => get(), child: child);
}
