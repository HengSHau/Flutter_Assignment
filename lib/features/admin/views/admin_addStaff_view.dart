import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_assignment/features/admin/viewmodels/admin_functionPage_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';

class AdminAddStaff extends StatefulWidget {
  const AdminAddStaff({super.key});

  @override
  State<AdminAddStaff> createState() => AdminAddStaffState();
}

class AdminAddStaffState extends State<AdminAddStaff> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? selectedGender;
  String? selectedRole;
  final AdminFunctionViewModel vm = AdminFunctionViewModel();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    contactNoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> addStaff() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final contactNo = contactNoController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty ||
        email.isEmpty ||
        contactNo.isEmpty ||
        password.isEmpty ||
        selectedGender == null ||
        selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
      return;
    }

    try {
      // ✨ 1. Create a temporary secondary Firebase app
      FirebaseApp secondaryApp = await Firebase.initializeApp(
        name: 'AdminAccountCreation',
        options: Firebase.app().options,
      );

      // ✨ 2. Use the secondary app to create the new account (so Admin stays logged in)
      final UserCredential userCredential = await FirebaseAuth.instanceFor(app: secondaryApp)
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      // ✨ 3. Use the MAIN app to save the data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': username,
        'email': email,
        'contactNo': contactNo,
        'gender': selectedGender,
        'role': selectedRole,
        'uid': uid,
        'createdAt': Timestamp.now(),
      });

      // ✨ 4. Delete the temporary app to clean up memory
      await secondaryApp.delete();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Staff account created successfully'),
          ),
        );

        usernameController.clear();
        emailController.clear();
        contactNoController.clear();
        passwordController.clear();

        setState(() {
          selectedGender = null;
          selectedRole = null;
        });
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'Failed to create account'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    controller: usernameController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: emailController,
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
                    controller: contactNoController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: 'Contact No.',
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    value: selectedGender,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: 'Male',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem(
                        value: 'Female',
                        child: Text('Female'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    value: selectedRole,
                    decoration: const InputDecoration(
                      labelText: 'Role',
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: 'admin',
                        child: Text('Admin'),
                      ),
                      DropdownMenuItem(
                        value: 'finance',
                        child: Text('Finance'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 24),

                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: addStaff,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 40),
                    ),
                    child: const Text('Add Staff'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}