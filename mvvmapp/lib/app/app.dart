import 'package:flutter/material.dart';
import 'package:mvvmapp/presentation/resources/routes_manager.dart';
import '../presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp.internal({super.key});
  static const MyApp _instance = MyApp.internal();
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.splashScreen,
      onGenerateRoute: RoutesGenerator.getRoute,
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
