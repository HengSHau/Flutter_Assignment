import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. ADDED PROVIDER IMPORT
import 'package:flutter_assignment/core/widgets/commonAppbar.dart';
import 'package:flutter_assignment/features/auth/viewmodel/LoginPage_viewmodels.dart';
import 'package:flutter_assignment/features/homepage/viewmodels/homePage_viewmodel.dart';
import 'package:flutter_assignment/features/auth/views/RegisterPage_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.themeNotifier});
  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  Widget build(BuildContext context) {
    // 2. GET THE VIEWMODEL INSTANCE HERE
    final loginViewModel = context.watch<LoginViewModel>();

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
                    // 3. CAPTURE EMAIL INPUT
                    onChanged: (value) => loginViewModel.updateEmail(value),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: TextField(
                    obscureText: true,
                    // 4. CAPTURE PASSWORD INPUT
                    onChanged: (value) => loginViewModel.updatePassword(value),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),

                // Display Error Message if login fails
                if (loginViewModel.errorMessage.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(
                    loginViewModel.errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ],

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
                    // 5. USE THE INSTANCE FOR ISLOADING
                    onPressed: loginViewModel.isLoading
                    ? null
                    : () async {
                      bool success = await context.read<LoginViewModel>().login();

                      // 6. FIX MOUNTED CHECK
                      if(success && context.mounted){
                        Navigator.pushReplacement(
                          context,
                          // 7. FIX THEMENOTIFIER VARIABLE
                          MaterialPageRoute(builder: (_) => Home(themeNotifier: themeNotifier,)),
                        );
                      }
                    },
                    // Show a loading circle or text
                    child: loginViewModel.isLoading 
                      ? const SizedBox(width: 15, height: 15, child: CircularProgressIndicator(strokeWidth: 2)) 
                      : const Text('Login'),
                  )   
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}