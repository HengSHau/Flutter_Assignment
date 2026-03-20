import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/LoginPage_models.dart'; // Import your new page model

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create an instance of your page model
  LoginPageModel loginForm = LoginPageModel();

  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Update methods called when the user types in the text fields
  void updateEmail(String email) {
    loginForm.email = email;
    notifyListeners();
  }

  void updatePassword(String password) {
    loginForm.password = password;
    notifyListeners();
  }

  // The login function now uses the data from your Page Model
  Future<bool> login() async {
    // Check the validation logic inside your model first
    if (!loginForm.isValid) {
      _errorMessage = 'Please enter a valid email and password.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _errorMessage = '';

    try {
      await _auth.signInWithEmailAndPassword(
        email: loginForm.email.trim(),
        password: loginForm.password.trim(),
      );
      _setLoading(false);
      return true; // Success!

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        _errorMessage = 'Wrong password provided.';
      } else {
        _errorMessage = e.message ?? 'Login failed.';
      }
    } catch (e) {
      _errorMessage = 'An unexpected error occurred.';
    }

    _setLoading(false);
    return false; // Failed
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}