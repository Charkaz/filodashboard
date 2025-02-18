import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../config/env_config.dart';

@module
abstract class DioClient {
  @lazySingleton
  Dio dio(EnvConfig config) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
      _authInterceptor(),
    ]);

    return dio;
  }

  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add auth token if available
        // final token = await getToken();
        // if (token != null) {
        //   options.headers['Authorization'] = 'Bearer $token';
        // }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Handle token refresh or logout
          // await refreshToken();
          // final token = await getToken();
          // error.requestOptions.headers['Authorization'] = 'Bearer $token';
          // return handler.resolve(await dio.fetch(error.requestOptions));
        }
        return handler.next(error);
      },
    );
  }
}
