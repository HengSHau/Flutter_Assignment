import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. ADDED PROVIDER IMPORT
import 'package:flutter_assignment/core/widgets/commonAppbar.dart';
import 'package:flutter_assignment/features/auth/viewmodel/LoginPage_viewmodels.dart';
import 'package:flutter_assignment/features/homepage/views/main_layout_view.dart';
import 'package:flutter_assignment/features/auth/views/RegisterPage_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.themeNotifier});
  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  Widget build(BuildContext context) {
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
                    onChanged: (value) => loginViewModel.updatePassword(value),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),

                if (loginViewModel.errorMessage.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(
                    loginViewModel.errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ],
                
                Align(
                  alignment: Alignment.centerRight,
                  child:TextButton(
                    onPressed: (){
                      TextEditingController resetEmailController=TextEditingController();

                      showDialog(
                        context:context,
                        builder: (context) {
                          return AlertDialog(
                            title:const Text('Reset Password'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Enter Your Email address to reset password'),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: resetEmailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    hintText: 'Email Address',
                                    border:OutlineInputBorder(),
                                  ),
                                )
                              ],
                            ),
                            actions:[
                              TextButton(
                                onPressed: ()=>Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                style:ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white
                                ),
                                onPressed: ()async{
                                  FocusScope.of(context).unfocus();

                                  String result=await loginViewModel.sendPasswordReset(resetEmailController.text); 
                                  if(context.mounted){
                                    Navigator.pop(context);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:Text(result=="Success"?'Reset link to your email!':result),
                                        backgroundColor: result=="Success"?Colors.green:Colors.red,
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Send Link'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child:const Text(
                      'Forgot Password',
                      style: TextStyle(
                        color:Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),


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
                    onPressed: loginViewModel.isLoading
                    ? null
                    : () async {
                      bool success = await context.read<LoginViewModel>().login();

                      // 6. FIX MOUNTED CHECK
                      if(success && context.mounted){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => Home(themeNotifier: themeNotifier,)),
                        );
                      }
                    },
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