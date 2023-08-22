import 'package:flutter/material.dart';
import 'package:mvvmapp/presentation/main/pages/home_page.dart';
import 'package:mvvmapp/presentation/main/pages/notification_page.dart';
import 'package:mvvmapp/presentation/main/pages/search_page.dart';
import 'package:mvvmapp/presentation/main/pages/settings_page.dart';
import 'package:mvvmapp/presentation/resources/color_manager.dart';
import 'package:mvvmapp/presentation/resources/strings_manager.dart';
import 'package:mvvmapp/presentation/resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = const <Widget>[
    HomePage(),
    SearchPage(),
    NotificationPage(),
    SettingsPage(),
  ];
  List<String> titles = const <String>[
    AppStrings.home,
    AppStrings.search,
    AppStrings.notification,
    AppStrings.settings,
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_currentIndex],
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorManager.lightGrey,
              spreadRadius: AppSize.s1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: (newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: AppStrings.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: AppStrings.search,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: AppStrings.notification,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: AppStrings.settings,
            ),
          ],
        ),
      ),
    );
  }
}
