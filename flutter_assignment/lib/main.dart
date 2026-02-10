import 'package:flutter/material.dart';
import 'package:flutter_assignment/pages/LoginPage.dart';
import 'package:flutter_assignment/theme.dart';

void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: Themes.lightTheme(),
            darkTheme: Themes.darkTheme(),
            themeMode: ThemeMode.system,
            home: const LoginPage(),
            debugShowCheckedModeBanner: false,
        );
    }
}