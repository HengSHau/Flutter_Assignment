import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/auth/views/loginPage_view.dart';
import 'package:flutter_assignment/core/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    final themes = Themes(ThemeData.light().textTheme);

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, _) {
        return MaterialApp(
          title: 'Flutter Assignment',
          theme: themes.light(),
          darkTheme: themes.dark(),
          themeMode: currentMode,
          home: LoginPage(themeNotifier: themeNotifier),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}