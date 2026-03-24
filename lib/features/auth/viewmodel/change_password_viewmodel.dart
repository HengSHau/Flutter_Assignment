import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<String> changePassword(String oldPassword, String newPassword, String confirmPassword) async {
    if (oldPassword.isEmpty || newPassword.isEmpty) return "Please fill in all fields.";
    if (newPassword != confirmPassword) return "New passwords do not match.";
    if (newPassword.length < 6) return "New password must be at least 6 characters.";

    _isLoading = true;
    notifyListeners();

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _isLoading = false;
        notifyListeners();
        return "Error: No user logged in.";
      }

      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(newPassword);

      _isLoading = false;
      notifyListeners();
      return "Success";

    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        return "The old password you entered is incorrect.";
      }
      return e.message ?? "Failed to update password.";
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return "An unexpected error occurred.";
    }
  }
}