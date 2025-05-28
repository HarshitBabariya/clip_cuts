import 'package:clip_cuts/views/sign_in/sign_in_screen.dart';
import 'package:flutter/Material.dart';

import '../repository/check_internet.dart';
import '../views/home/home_screen.dart';
import '../views/splash_view/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String signInScreen = '/sign_in_screen';
  static const String homeScreen = '/home_screen';
  static const String noInternet = '/check_internate';

  static Map<String, WidgetBuilder> get routes => {
    ///PARENT
    splashScreen: SplashScreen.builder,
    signInScreen: SignInScreen.builder,
    homeScreen: HomeScreen.builder,
    noInternet: NoInternetScreen.builder,
  };
}
