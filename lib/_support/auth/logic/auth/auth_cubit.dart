import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../services/auth_service.dart';

@lazySingleton
class AuthCubit extends Cubit<User?> {
  final AuthService _authService;
  final closers = <Function>[];

  AuthCubit(this._authService) : super(null) {
    closers.add(_authService.provider.authStateChanges().listen(emit).cancel);
    closers.add(_authService.provider.idTokenChanges().listen(emit).cancel);
    closers.add(_authService.provider.userChanges().listen(emit).cancel);
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
