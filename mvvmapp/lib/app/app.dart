import 'package:flutter/material.dart';
import 'package:mvvmapp/presentation/theme_manager.dart';

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
      theme: getApplicationTheme(),
    );
  }
}

class Person {
  late final name;
  late final age;

  Person({this.name, this.age});
}
