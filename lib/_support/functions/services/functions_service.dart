import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_8ball/_support/app_root/__.dart';

import '../misc/interceptors/token_interceptor.dart';

@lazySingleton
class FunctionsService {
  late final Dio _authDio;
  final TokenInterceptor _tokenInterceptor;

  FunctionsService(this._tokenInterceptor);

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    _authDio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ))
      ..interceptors.add(_tokenInterceptor);
  }

  String get baseUrl => Mode.isEmulator
      ? 'http://127.0.0.1:5002/smart-8ball/us-central1/app/'
      : 'https://us-central1-smart-8ball.cloudfunctions.net/app/';
  Dio get client => _authDio;

  Dio get createClient => Dio();

  /// Returns a [FutureOr] of [payload] if [predicate] returns true, otherwise an empty [Map].
  FutureOr<Map<String, T>> _supply<T extends dynamic>(
      FutureOr<bool> Function() predicate, Map<String, T> payload) async {
    return await predicate() ? payload : {};
  }
}
