import 'package:flutter/material.dart';
import 'package:mvvmapp/presentation/forgot_password/forgot_password_view.dart';
import 'package:mvvmapp/presentation/login/login_view.dart';
import 'package:mvvmapp/presentation/main/main_view.dart';
import 'package:mvvmapp/presentation/register/register_view.dart';
import 'package:mvvmapp/presentation/splash/splash_view.dart';
import 'package:mvvmapp/presentation/store_details/store_details_view.dart';

class Routes {
  static const String splashScreen = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotPassword';
  static const String main = '/main';
  static const String storeDetails = '/storeDetails';
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.main:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetails:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return undefinedRoute;
    }
  }

  static Route<dynamic> undefinedRoute = MaterialPageRoute(
    builder: (_) => const Scaffold(
      body: Center(
        child: Text('Undefined Route...'),
      ),
    ),
  );
}
