import 'package:flutter/material.dart';
import 'package:mvvmapp/presentation/forgot_password/forgot_password_view.dart';
import 'package:mvvmapp/presentation/login/login_view.dart';
import 'package:mvvmapp/presentation/main/main_view.dart';
import 'package:mvvmapp/presentation/onboarding/view/onboarding_view.dart';
import 'package:mvvmapp/presentation/register/register_view.dart';
import 'package:mvvmapp/presentation/resources/strings_manager.dart';
import 'package:mvvmapp/presentation/splash/splash_view.dart';
import 'package:mvvmapp/presentation/store_details/store_details_view.dart';

class Routes {
  static const String splashScreen = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotPassword';
  static const String main = '/main';
  static const String storeDetails = '/storeDetails';
  static const String onBoarding = '/onBoarding';
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
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      default:
        return undefinedRoute;
    }
  }

  static Route<dynamic> undefinedRoute = MaterialPageRoute(
    builder: (_) => const Scaffold(
      body: Center(
        child: Text(AppStrings.undefinedRoute),
      ),
    ),
  );
}
