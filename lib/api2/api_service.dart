import 'package:clip_cuts/api2/response_model.dart';
import 'package:clip_cuts/utils/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException: $message';
}

class NetworkException extends ApiException {
  NetworkException(super.message);
}

class ServerException extends ApiException {
  ServerException(super.message, int statusCode) : super(statusCode: statusCode);
}

class TimeoutException extends ApiException {
  TimeoutException() : super('Request timeout');
}

// API Service Class
class ApiService {
  late Dio _dio;
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors for logging (optional)
    if (kDebugMode) {
      _dio.interceptors.add(AuthInterceptor());
      _dio.interceptors.add(
        TalkerDioLogger(
          talker: Talker(),
          settings: TalkerDioLoggerSettings(
            requestPen: AnsiPen()..green(bold: true),
            // Green http responses logs in console
            responsePen: AnsiPen()..cyan(),
            // Error http logs in console
            errorPen: AnsiPen()..red(),
            printResponseData: true,
            // All http requests disabled for console logging
            printRequestData: true,
            // Reposnse logs including http - headers
            printResponseHeaders: false,
            // Request logs without http - headersa
            printRequestHeaders: true,
          ),
        ),
      );
    }
  }

  // Generic method to handle all HTTP requests
  Future<ApiResponse<T>> _handleRequest<T>(
    Future<Response> Function() request,
    T Function(dynamic)? fromJson,
  ) async {
    try {
      final response = await request();

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        T data;
        if (fromJson != null && response.data != null) {
          data = fromJson(response.data);
        } else if (response.data != null) {
          data = response.data as T;
        } else {
          // Handle null response data
          data = null as T;
        }

        return ApiResponse.success(
          data,
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          'Server error: ${response.statusMessage}',
          response.statusCode!,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException('Unexpected error: ${e.toString()}');
    }
  }

  // Handle Dio specific errors
  ApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException();

      case DioExceptionType.connectionError:
        return NetworkException('No internet connection');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        String message = 'Server error';

        if (statusCode == 400) {
          message = 'Bad request';
        } else if (statusCode == 401)
          message = 'Unauthorized';
        else if (statusCode == 403)
          message = 'Forbidden';
        else if (statusCode == 404)
          message = 'Not found';
        else if (statusCode == 500) message = 'Internal server error';

        return ServerException(message, statusCode);

      case DioExceptionType.cancel:
        return ApiException('Request cancelled');

      default:
        return ApiException('Network error: ${error.message}');
    }
  }

  // GET Request
  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    return _handleRequest<T>(
      () => _dio.get(endpoint, queryParameters: queryParameters),
      fromJson,
    );
  }

  // POST Request
  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    return _handleRequest<T>(
      () => _dio.post(endpoint, data: data, queryParameters: queryParameters),
      fromJson,
    );
  }

  // PUT Request
  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    return _handleRequest<T>(
      () => _dio.put(endpoint, data: data, queryParameters: queryParameters),
      fromJson,
    );
  }

  // PATCH Request
  Future<ApiResponse<T>> patch<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    return _handleRequest<T>(
      () => _dio.patch(endpoint, data: data, queryParameters: queryParameters),
      fromJson,
    );
  }

  // DELETE Request
  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    return _handleRequest<T>(
      () => _dio.delete(endpoint, data: data, queryParameters: queryParameters),
      fromJson,
    );
  }

  Future<ApiResponse<T>> uploadFile<T>(
    String endpoint, {
    required String filePath,
    required String fieldName,
    Map<String, dynamic>? dataFields,
    T Function(dynamic)? fromJson,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final formData = FormData.fromMap({
        if (dataFields != null) ...dataFields,
        fieldName: await MultipartFile.fromFile(filePath),
      });

      return _handleRequest<T>(
        () => _dio.post(
          endpoint,
          data: formData,
          onSendProgress: onSendProgress,
        ),
        fromJson,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException('Unexpected error: ${e.toString()}');
    }
  }

  //Example
/*
final response = await apiService.uploadFile<ApiResponseModel>(
  '/upload',
  filePath: '/storage/emulated/0/DCIM/Camera/image.jpg',
  fieldName: 'image',
  dataFields: {
    'user_id': '123',
    'description': 'Profile pic',
  },
  fromJson: (json) => ApiResponseModel.fromJson(json),
  onSendProgress: (sent, total) {
    print('Progress: ${sent / total * 100}%');
  },
);
*/

  Future<ApiResponse<T>> uploadMultipleFiles<T>(
    String endpoint, {
    required List<String> filePaths,
    required String fieldName,
    Map<String, dynamic>? dataFields,
    T Function(dynamic)? fromJson,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final files = await Future.wait(
        filePaths.map((path) => MultipartFile.fromFile(path)).toList(),
      );

      final formData = FormData.fromMap({
        ...?dataFields,
        fieldName: files,
      });

      return _handleRequest<T>(
        () => _dio.post(
          endpoint,
          data: formData,
          onSendProgress: onSendProgress,
        ),
        fromJson,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException('Unexpected error: ${e.toString()}');
    }
  }
/*final response = await apiService.uploadMultipleFiles<MyModel>(
  '/upload/multiple',
  filePaths: [
    '/storage/emulated/0/DCIM/Camera/image1.jpg',
    '/storage/emulated/0/DCIM/Camera/image2.jpg',
    '/storage/emulated/0/DCIM/Camera/image3.jpg',
  ],
  fieldName: 'images', // The field name expected by your backend (e.g. images[] or just images)
  dataFields: {
    'user_id': '456',
    'type': 'gallery',
  },
  fromJson: (json) => MyModel.fromJson(json),
  onSendProgress: (sent, total) {
    print("Progress: ${(sent / total * 100).toStringAsFixed(2)}%");
  },
);
*/
}
