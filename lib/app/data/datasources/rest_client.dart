import 'dart:convert';
import 'package:dio/dio.dart';

const _baseUrl = 'https://brasilapi.com.br/';

class RestClient {
  late final Dio _dio;

  RestClient() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 5),
      validateStatus: (status) => status != null,
    ));
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    final response = await _dio.get(path, queryParameters: queryParameters);

    return response;
  }

  Future<Response> post(String path, dynamic body,
      {Map<String, dynamic>? queryParameters}) async {
    final response = await _dio.post(path,
        data: jsonEncode(body), queryParameters: queryParameters);

    return response;
  }
}
