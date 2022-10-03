import 'package:dio/dio.dart';

import 'api_interceptor.dart';

class DioHandler {
  final String apiBaseUrl;

  DioHandler({
    required this.apiBaseUrl,
  });

  Dio get dio => _getDio();

  Dio _getDio() {
    BaseOptions options = BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: 50000,
      receiveTimeout: 30000,
    );
    final dio = Dio(options);
    dio.interceptors.add(ApiInterceptors());

    return dio;
  }
}
