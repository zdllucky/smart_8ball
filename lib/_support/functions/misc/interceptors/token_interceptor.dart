import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_8ball/_support/auth/__.dart';

@injectable
class TokenInterceptor extends Interceptor {
  final AuthService _authService;

  TokenInterceptor(this._authService);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (await _authService.user?.getIdToken() != null) {
      options.headers['Authorization'] =
          'Bearer ${await _authService.user!.getIdToken()}';
    }

    handler.next(options);
  }
}
