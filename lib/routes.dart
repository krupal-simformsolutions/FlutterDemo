import 'package:flutter/material.dart';
import 'package:flutterdemo/module/auth/login/login_screen.dart';
import 'package:flutterdemo/module/auth/signup/sign_up_screen.dart';
import 'package:flutterdemo/module/home/home_screen.dart';
import 'package:flutterdemo/module/intro/intro_screen.dart';
import 'package:flutterdemo/module/product/product_detail_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "login":
        return MaterialPageRoute<void>(
          builder: (context) => const LoginScreen(),
        );
      case "signup":
        return MaterialPageRoute<void>(
          builder: (context) {
            return const SignUpScreen();
          },
        );
      case "forgot":
        return MaterialPageRoute<void>(
          builder: (context) {
            return LoginScreen();
          },
        );
      case "home":
        return MaterialPageRoute<void>(
          builder: (context) {
            return HomeScreen();
          },
        );
      case 'productDetail':
        return MaterialPageRoute<void>(
          builder: (context) {
            return ProductDetailScreen();
          },
        );
      case "intro":
        return MaterialPageRoute<void>(builder: (context) {
          return IntroScreen();
        });
      default:
        return MaterialPageRoute<void>(builder: (_) => const LoginScreen());
    }
  }
}
