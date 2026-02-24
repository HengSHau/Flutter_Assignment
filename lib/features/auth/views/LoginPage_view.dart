import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/widgets/commonAppbar.dart';
import 'package:flutter_assignment/features/homepage/viewmodels/homePage_viewmodel.dart';
import 'package:flutter_assignment/features/auth/views/RegisterPage_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key,required this.themeNotifier,});
  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Login',
        showProfile: false,
        themeNotifier: themeNotifier,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 250,
                  child: Image.asset(
                    Theme.of(context).brightness == Brightness.light
                    ? 'assets/images/Codementor.png'
                    : 'assets/images/Codementor_dark.png',
                  ),
                ),

                const SizedBox(height: 40),
                
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      labelText: 'Username',
                      labelStyle: TextStyle(
                      )
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                      )
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign Up here',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 12
                      ),
                    ),
                  )
                ),

                const SizedBox(height: 30),

                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Home(themeNotifier: themeNotifier,),
                        )
                      );
                    },
                    style: ElevatedButton.styleFrom(                      
                        minimumSize: const Size(100, 40)
                    ),
                    child: const Text('Login'),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}