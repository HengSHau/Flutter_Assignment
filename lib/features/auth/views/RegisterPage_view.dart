import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assignment/features/auth/viewmodel/RegisterPage_viewmodels.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final registerViewModel=context.watch<RegisterViewModel>();
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
                    onChanged: (value)=>registerViewModel.updateUsername(value),
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
                    onChanged:(value)=>registerViewModel.updateEmail(value),
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
                    onChanged: (value)=>registerViewModel.updateContactNo(value),
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
                    if(value!=null)registerViewModel.updateGender(value);
                   }, 
                  )
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: TextField(
                    obscureText: true,
                    onChanged: (value)=>registerViewModel.updatePassword(value),
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                if(registerViewModel.errorMessage.isNotEmpty)...[
                  const SizedBox(height: 10),
                  Text(
                    registerViewModel.errorMessage,
                    style:const TextStyle(color:Colors.red,fontSize:12))
                ], 

                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: registerViewModel.isLoading
                    ? null
                    :()async{
                      bool success=await context.read<RegisterViewModel>().register();

                      if(success&&context.mounted){
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Registration Successful! Please Login.')),
                        );
                      }
                    },
                  style:ElevatedButton.styleFrom(
                    minimumSize:const Size(100,40)
                  ),
                  child:registerViewModel.isLoading
                    ? const SizedBox(width:15,height:15,child:CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Sign Up'),
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