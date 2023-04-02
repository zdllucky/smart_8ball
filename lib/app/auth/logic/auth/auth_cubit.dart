import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../services/auth_service.dart';

@lazySingleton
class AuthCubit extends Cubit<User?> {
  final AuthService authService;
  final closers = <Function>[];

  AuthCubit(this.authService) : super(null) {
    closers.add(authService.provider.authStateChanges().listen(emit).cancel);
    closers.add(authService.provider.idTokenChanges().listen(emit).cancel);
    closers.add(authService.provider.userChanges().listen(emit).cancel);
  }

  @override
  Future<void> close() {
    if (kDebugMode) debugPrintStack(label: 'AuthCubit.close()');
    for (final closer in closers) {
      closer();
    }

    return super.close();
  }
}
