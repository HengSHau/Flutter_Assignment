import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import '../models/RegisterPage_models.dart';

class RegisterViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  RegisterPageModel registerForm = RegisterPageModel();

  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void updateUsername(String value) { registerForm.username = value; notifyListeners(); }
  void updateEmail(String value) { registerForm.email = value; notifyListeners(); }
  void updateContactNo(String value) { registerForm.contactNo = value; notifyListeners(); }
  void updateGender(String value) { registerForm.gender = value; notifyListeners(); }
  void updatePassword(String value) { registerForm.password = value; notifyListeners(); }
  Future<bool> register() async {
    if (!registerForm.isValid) {
      _errorMessage = 'Please fill all fields correctly (Password min 6 chars).';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _errorMessage = '';

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: registerForm.email.trim(),
        password: registerForm.password.trim(),
      );

      if (credential.user != null) {
        await credential.user!.updateDisplayName(registerForm.username.trim());

        await _firestore.collection('users').doc(credential.user!.uid).set({
          'uid':credential.user!.uid,
          'username':registerForm.username.trim(),
          'email':registerForm.email.trim(),
          'contactNo':registerForm.contactNo.trim(),
          'gender':registerForm.gender,
          'role':"Learner",
          'createdAt':FieldValue.serverTimestamp(),
        });
      }

      _setLoading(false);
      return true;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        _errorMessage = 'An account already exists for that email.';
      } else {
        _errorMessage = e.message ?? 'Registration failed.';
      }
    } catch (e) {
      _errorMessage = 'An unexpected error occurred.';
    }

    _setLoading(false);
    return false;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}