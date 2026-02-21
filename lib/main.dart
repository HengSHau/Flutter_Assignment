import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/auth/views/LoginPage_view.dart';
import 'package:flutter_assignment/core/theme/theme.dart';

void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      final themes = Themes(ThemeData.light().textTheme);
        return MaterialApp(
            title: 'Flutter Assignment',
            theme: themes.light(),
            darkTheme: themes.dark(),
            themeMode: ThemeMode.system,
            home: const LoginPage(),
            debugShowCheckedModeBanner: false,
        );
    }
}