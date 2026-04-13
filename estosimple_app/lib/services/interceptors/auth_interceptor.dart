import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthInterceptor extends Interceptor {
  @override void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    const String token = "TOKEN_EXEMPLO";

    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

    if (err.response?.statusCode == 401) {
      debugPrint('LOG: Token inválido ou expirado.');
    }

    return handler.next(err);
  }
}