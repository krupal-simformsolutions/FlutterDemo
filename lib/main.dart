import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterdemo/module/auth/login/login_screen.dart';
import 'package:flutterdemo/routes.dart';
import 'package:flutterdemo/values/app_colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.colorPrimary, // navigation bar color
    statusBarColor: AppColors.colorPrimary, // status bar color
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark
  ));
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      home: LoginScreen()));
}
