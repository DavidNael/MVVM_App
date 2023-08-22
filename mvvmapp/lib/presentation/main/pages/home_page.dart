import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvmapp/presentation/resources/strings_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text(AppStrings.home));
  }
}
