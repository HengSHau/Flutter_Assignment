import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: BackButton(
          color: Theme.of(context).colorScheme.surface,
        ),
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
                  child: Image.asset('assets/images/Codementor.png')
                ),
                const SizedBox(height: 20),

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
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      labelText: 'Gmail',
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
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      labelText: 'Contact No.',
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
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
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
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
                const SizedBox(height: 30),

                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(                      
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
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