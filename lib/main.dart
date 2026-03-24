import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_assignment/features/auth/viewmodel/RegisterPage_viewmodels.dart';
import 'package:flutter_assignment/features/chat/viewmodels/chatPage_viewmodel.dart';
import 'package:flutter_assignment/features/customer/viewmodels/customer_create_course_viewmodel.dart';
import 'package:flutter_assignment/features/customer/viewmodels/customer_discover_viewmodel.dart';
import 'package:flutter_assignment/features/homepage/viewmodels/homePage_viewmodel.dart';
import 'package:flutter_assignment/features/profile/viewmodels/editProfile_viewmodel.dart'; 
import 'package:provider/provider.dart'; 
import 'firebase_options.dart';
import 'package:flutter_assignment/features/auth/viewmodel/LoginPage_viewmodels.dart'; 
import 'package:flutter_assignment/features/auth/views/loginPage_view.dart';
import 'package:flutter_assignment/features/chat/viewmodels/chat_home_viewmodel.dart';
import 'package:flutter_assignment/core/theme/theme.dart';
import 'package:flutter_assignment/features/customer/viewmodels/customer_learning_viewmodel.dart';
import 'package:flutter_assignment/features/customer/viewmodels/customer_teaching_viewmodel.dart';
import 'package:flutter_assignment/features/auth/viewmodel/change_password_viewmodel.dart';
import 'package:flutter_assignment/features/settings/viewmodels/feedback_viewmodel.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_)=>RegisterViewModel()),
        ChangeNotifierProvider(create: (_)=>CustomerDiscoverViewModel()),
        ChangeNotifierProvider(create: (_)=>ChatHomeViewModel()),
        ChangeNotifierProvider(create: (_) => ChatPageViewModel()),
        ChangeNotifierProvider(create: (_) => HomepageViewmodel()),
        ChangeNotifierProvider(create: (_) => EditprofileViewmodel()),
        ChangeNotifierProvider(create: (_) => CustomerCreateCourseViewmodel()),
        ChangeNotifierProvider(create: (_) => CustomerLearningViewModel()),
        ChangeNotifierProvider(create: (_) => CustomerTeachingViewmodel()),
        ChangeNotifierProvider(create: (_) => ChangePasswordViewModel()),
        ChangeNotifierProvider(create: (_) => FeedbackViewmodel()),
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
          home: LoginPage(themeNotifier: themeNotifier), 
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}