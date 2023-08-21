import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvmapp/app/app_prefs.dart';
import 'package:mvvmapp/presentation/resources/assets_manager.dart';
import 'package:mvvmapp/presentation/resources/color_manager.dart';
import 'package:mvvmapp/presentation/resources/constants_manager.dart';
import 'package:mvvmapp/presentation/resources/routes_manager.dart';

import '../../app/dependency_injection.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppPreferences _appPreferences = getItInstance<AppPreferences>();
  Timer? _timer;
  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashTime), _goNext);
  }

  _goNext() async {
    _appPreferences.getIsLoggedIn().then((isLoggedIn) {
      if (isLoggedIn) {
        if (kDebugMode) {
          print("SplashView: Going to main");
        }
        Navigator.pushReplacementNamed(context, Routes.main);
      } else {
        _appPreferences.getShowOnboarding().then((showOnboarding) {
          if (showOnboarding) {
            if (kDebugMode) {
              print("SplashView: Going to onboarding");
            }
            Navigator.pushReplacementNamed(context, Routes.onBoarding);
          } else {
            if (kDebugMode) {
              print("SplashView: Going to login");
            }
            Navigator.pushReplacementNamed(context, Routes.login);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(
          image: AssetImage(ImageAssets.splashLogo),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
