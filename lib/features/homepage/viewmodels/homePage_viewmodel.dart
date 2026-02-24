import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/widgets/commonAppbar.dart';
import 'package:flutter_assignment/features/homepage/views/homePage_view.dart';
import 'package:flutter_assignment/features/chat/views/chatHomePage_view.dart';
import 'package:flutter_assignment/features/customer/views/customer_functionPage_view.dart';
import 'package:flutter_assignment/features/settings/views/settingsPage_view.dart';

class Home extends StatefulWidget {
  const Home({super.key,required this.themeNotifier,});
  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<String> _titles = const [
    'Home',
    'Chat',
    'Functions',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(),
      ChatHomePage(themeNotifier: widget.themeNotifier),
      const CustomerFunctionPage(),
      SettingsPage(themeNotifier: widget.themeNotifier),
    ];

    return Scaffold(
      appBar: CommonAppBar(
        title: _titles[_currentIndex],
        showBack: false,
        themeNotifier: widget.themeNotifier,
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: buildBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
