import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_8ball/_support/app_root/__.dart';
import 'package:smart_8ball/_support/functions/models/basic_answer_model.dart';

import '../misc/interceptors/token_interceptor.dart';

part 'question_extension.dart';

@lazySingleton
class FunctionsService {
  FirebaseFunctions get _provider => FirebaseFunctions.instance;
  late final Dio _authDio;
  final TokenInterceptor _tokenInterceptor;
  String get baseUrl => Mode.isEmulator
      ? 'http://${const String.fromEnvironment('EMULATOR_REMOTE_HOST', defaultValue: "127.0.0.1")}:5002/smart-8ball/us-central1/app/'
      : 'https://us-central1-smart-8ball.cloudfunctions.net/app/';
  Dio get client => _authDio;
  Dio get createClient => Dio();

  FunctionsService(this._tokenInterceptor);

  @PostConstruct()
  void init() {
    if (Mode.isEmulator) {
      _provider.useFunctionsEmulator(
          const String.fromEnvironment('EMULATOR_REMOTE_HOST'), 9099);
    }

    _authDio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    ))
      ..interceptors.add(_tokenInterceptor);
  }

  // /// Returns a [FutureOr] of [payload] if [predicate] returns true, otherwise an empty [Map].
  // FutureOr<Map<String, T>> _supply<T extends dynamic>(
  //     FutureOr<bool> Function() predicate, Map<String, T> payload) async {
  //   return await predicate() ? payload : {};
  // }
}
