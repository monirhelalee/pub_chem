import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pub_chem/app/config/env.dart';

class ApiClient {
  ApiClient() {
    dio = Dio();
    dio.options = BaseOptions(
      baseUrl: Env.value.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      contentType: 'application/json',
    );
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          responseHeader: false,
        ),
      );
    }
  }
  late Dio dio;
}
