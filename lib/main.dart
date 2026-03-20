import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_assignment/features/auth/viewmodel/RegisterPage_viewmodels.dart';
import 'package:flutter_assignment/features/chat/viewmodels/chatPage_viewmodel.dart';
import 'package:flutter_assignment/features/customer/viewmodels/customer_discover_viewmodel.dart'; 
import 'package:provider/provider.dart'; 
import 'firebase_options.dart';
import 'package:flutter_assignment/features/auth/viewmodel/LoginPage_viewmodels.dart'; 
import 'package:flutter_assignment/features/auth/views/loginPage_view.dart';
import 'package:flutter_assignment/features/chat/viewmodels/chat_home_viewmodel.dart';
import 'package:flutter_assignment/core/theme/theme.dart';

// 1. MUST BE ASYNC for Firebase
void main() async { 
  // 2. Ensure Flutter bindings are ready
  WidgetsFlutterBinding.ensureInitialized();

  // 3. Initialize Firebase using your auto-generated file
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    // 4. Wrap MyApp with MultiProvider so the whole app can access the ViewModel
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_)=>RegisterViewModel()),
        ChangeNotifierProvider(create: (_)=>CustomerDiscoverViewModel()),
        ChangeNotifierProvider(create: (_)=>ChatHomeViewModel()),
        ChangeNotifierProvider(create: (_) => ChatPageViewModel()),

      ],
      child: MyApp(),
    ),
  );
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
          // Your LoginPage will now successfully find the LoginViewModel!
          home: LoginPage(themeNotifier: themeNotifier), 
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}