import 'package:clip_cuts/const/app_constant.dart';
import 'package:clip_cuts/routes/app_routes.dart';
import 'package:clip_cuts/routes/navigation_services.dart';
import 'package:clip_cuts/utils/auth_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<void> initializeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConstant.kAuthToken);
    AppConstant.token = token ?? "";
    final refreshToken = prefs.getString(AppConstant.kRefreshToken);

    if (token != null) {
      AuthInterceptor.setToken(token);
    }
  }

  static Future<bool> saveAuthToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // setString returns a Future<bool> indicating whether the operation succeeded.
    return await prefs.setString(AppConstant.kAuthToken, token);
  }

  static Future<bool> saveRefreshToken(String refreshToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(AppConstant.kRefreshToken, refreshToken);
  }

  static Future<String?> getRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstant.kRefreshToken);
  }

  static Future<void> logout() async {
    AppConstant.token = '';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstant.kAuthToken);
    await prefs.remove(AppConstant.kRefreshToken);
    AuthInterceptor.clearToken();
    NavigatorService.pushNamedAndRemoveUntil(AppRoutes.signInScreen);
  }
}
