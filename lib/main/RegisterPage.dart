import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [ 
                SizedBox(
                  width: 200,
                  child: Image.asset(
                    Theme.of(context).brightness == Brightness.light
                    ? 'assets/images/Codementor.png'
                    : 'assets/images/Codementor_dark.png',
                  ),               
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      labelText: 'Gmail',
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      labelText: 'Contact No.',
                      labelStyle: TextStyle(
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(), 
                    ),
                    isExpanded: true,
                    items:[
                      DropdownMenuItem(value: 'Male', child: Text('Male')
                      ),
                      DropdownMenuItem( value: 'Female', child: Text('Female')
                      )
                   ],
                   onChanged: (value) {
                   }, 
                  )
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
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(                      
                        minimumSize: const Size(100, 40)
                    ),
                    child: const Text('Sign Up'),
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