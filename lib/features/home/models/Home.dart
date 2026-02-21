import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/widgets/Appbar.dart';
import 'package:flutter_assignment/features/home/views/HomePage.dart';
import 'package:flutter_assignment/features/chat/views/ChatHomePage.dart';
import 'package:flutter_assignment/features/settings/views/SettingsPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ChatHomePage(),
    SettingsPage(),
    SettingsPage(),
  ];

  final List<String> _titles = const [
    'Home',
    'Chat',
    'Functions',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: _titles[_currentIndex],
        showBack: false,
      ),
      body: _pages[_currentIndex],
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
