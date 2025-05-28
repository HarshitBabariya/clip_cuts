// auth_interceptor.dart
import 'package:clip_cuts/service/auth_service.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  static String? token; // Store token statically

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add the token to the request headers if it's available
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  // Method to set the token (for use in login)
  static void setToken(String newToken) {
    token = newToken;
  }

  // Method to clear the token (for logout)
  static void clearToken() {
    token = null;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final newToken = await _refreshToken();

      if (newToken != null) {
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

        // Retry the failed request with the new token
        final dio = Dio();
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } else {
        await AuthService.logout();
      }
    }

    super.onError(err, handler);
  }

  Future<String?> _refreshToken() async {
    try {
      final refreshToken = await AuthService.getRefreshToken();
      if (refreshToken == null) return null;

      final dio = Dio();
      final response = await dio.post('https://your-api.com/auth/refresh', data: {'refreshToken': refreshToken});

      if (response.statusCode == 200) {
        final newToken = response.data['accessToken'];
        AuthService.saveAuthToken(newToken);
        setToken(newToken);
        return newToken;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
