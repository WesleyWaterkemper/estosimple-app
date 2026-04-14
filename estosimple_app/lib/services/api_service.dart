import 'package:dio/dio.dart';
import 'package:estosimple_app/services/interceptors/auth_interceptor.dart';

class ApiService {
  final Dio _dio;

  ApiService() : _dio = Dio(
    BaseOptions(
      baseUrl: 'https://estopay-app-production.up.railway.app/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }
    ),
  ) {
    // Adiciona o Interceptor criado
    _dio.interceptors.add(AuthInterceptor());

    _dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
    ));
  }

  Dio get dio => _dio;
}