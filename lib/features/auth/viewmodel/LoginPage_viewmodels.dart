import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/LoginPage_models.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginPageModel loginForm = LoginPageModel();
  bool _isLoading = false;
  String _errorMessage = '';
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void updateEmail(String email) {
    loginForm.email = email;
    notifyListeners();
  }

  void updatePassword(String password) {
    loginForm.password = password;
    notifyListeners();
  }

  Future<bool> login() async {
    if (!loginForm.isValid) {
      _errorMessage = 'Please enter a valid email and password.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _errorMessage = '';

    try {
      UserCredential userCredential= await _auth.signInWithEmailAndPassword(
        email: loginForm.email.trim(),
        password: loginForm.password.trim(),
      );

      String uid=userCredential.user!.uid;
      DocumentSnapshot userDoc=await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if(!userDoc.exists){
        await _auth.signOut();
        _errorMessage="This account has been deleted";
        _setLoading(false);
        return false;
      }

      _setLoading(false);
      return true;

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
    return false;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String> sendPasswordReset(String resetEmail)async{
    if(resetEmail.trim().isEmpty){
      return 'Please Enter an email address';
    }
    _setLoading(true);
    try{
      await _auth.sendPasswordResetEmail(email: resetEmail.trim());
      _setLoading(false);
      return 'Success';
    }catch(e){
      _setLoading(false);
      return e.toString();
    }
  }
}