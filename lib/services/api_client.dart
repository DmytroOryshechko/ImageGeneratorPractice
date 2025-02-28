import 'package:dio/dio.dart';
import 'package:image_generation_app/exceptions/api_exceptions.dart';
import 'package:image_generation_app/services/api_constants.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: {
          'Authorization': 'Token ${ApiConstants.apiToken}',
          'Content-Type': 'application/json',
        },
      ),
    );
    
    // Add logging interceptor for debugging
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<Response> post(String path, Map<String, dynamic> data) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> get(String path) async {
    try {
      return await _dio.get(path);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return NetworkException('Connection timeout. Please check your internet connection.');
    }

    if (error.response?.statusCode == 401) {
      return AuthenticationException('Invalid API token');
    }

    return ApiException(
      error.response?.data?['error'] ?? 'An unexpected error occurred',
    );
  }
}