import 'package:flutter/material.dart';
import 'package:flutter_assignment/main/RegisterPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Theme.of(context).colorScheme.primary
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
                  child: Image.asset('assets/images/Codementor.png')
                ),

                const SizedBox(height: 40),
                
                SizedBox(
                  width: 300,
                  child: TextField(
                    cursorColor: Theme.of(context).colorScheme.onPrimary,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      )
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: TextField(
                    cursorColor: Theme.of(context).colorScheme.onPrimary,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
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
                        color: Colors.blue,
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
                    },
                    style: ElevatedButton.styleFrom(                      
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        foregroundColor: Theme.of(context).colorScheme.onSecondary,
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