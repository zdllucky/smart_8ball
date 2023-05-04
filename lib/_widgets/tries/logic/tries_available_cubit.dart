import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_8ball/_support/auth/__.dart';
import 'package:smart_8ball/_support/firestore/__.dart';

@lazySingleton
class TriesAvailableCubit
    extends Cubit<DocumentSnapshot<TriesAvailableModel>?> {
  final TriesAvailableRepo _triesAvailableRepo;
  final DeviceMetadataService _deviceMetadataService;
  final AuthCubit _authCubit;
  String? userId;
  StreamSubscription? _docSubscription;
  StreamSubscription? _authSubscription;

  TriesAvailableCubit(
    this._authCubit,
    this._triesAvailableRepo,
    this._deviceMetadataService,
  ) : super(null) {
    _authSubscription = _authCubit.stream.listen((user) async {
      userId = user?.uid;

      _docSubscribe();
    }, onDone: () => _docUnsubscribe());

    _docSubscribe();
  }

  Future<void> _docSubscribe() async {
    await _docUnsubscribe();

    if (userId != null) {
      final id = _authCubit.state!.isAnonymous
          ? _deviceMetadataService.deviceId
          : userId;

      if (id != null) {
        _docSubscription =
            _triesAvailableRepo.subscribeToTriesAvailableDocument(id)(emit);
      }
    }
  }

  Future<void> _docUnsubscribe() async {
    if (_docSubscription?.cancel != null) await _docSubscription!.cancel();
    emit(null);
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
