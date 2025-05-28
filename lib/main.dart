import 'package:clip_cuts/const/const_app_text.dart';
import 'package:clip_cuts/routes/app_routes.dart';
import 'package:clip_cuts/routes/navigation_services.dart';
import 'package:clip_cuts/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'const/const_app_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.initializeToken();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: MaterialApp(
        title: AppConstText.appName,
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        navigatorKey: NavigatorService.navigatorKey,
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.splashScreen,
        theme: ThemeData(
          fontFamily: AppConstFonts.ralewayRegular,
          useMaterial3: true,
        ),
      ),
    );
  }
}
