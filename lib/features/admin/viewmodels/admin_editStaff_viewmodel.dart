import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminEditStaffViewModel extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? selectedRole;
  String? selectedGender;
  String? selectedDocId;

  void selectStaff(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    selectedDocId = doc.id;
    usernameController.text = data['username'] ?? '';
    emailController.text = data['email'] ?? '';
    contactNoController.text = data['contactNo'] ?? '';
    passwordController.text = data['password'] ?? '';
    selectedGender = data['gender'];

    notifyListeners();
  }

  Future<void> updateSelectedStaff() async {
    if (selectedDocId == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(selectedDocId)
        .update({
      'username': usernameController.text.trim(),
      'email': emailController.text.trim(),
      'contactNo': contactNoController.text.trim(),
      'gender': selectedGender,
      'password': passwordController.text.trim(),
    });

    notifyListeners();
  }

  Future<void> deleteSelectedStaff() async {
    if (selectedDocId == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(selectedDocId)
        .delete();

    usernameController.clear();
    emailController.clear();
    contactNoController.clear();
    passwordController.clear();
    selectedGender = null;
    selectedDocId = null;

    notifyListeners();
  }

  void changeGender(String? value) {
    selectedGender = value;
    notifyListeners();
  }

  void changeRole(String? value){
    selectedRole = value;
    notifyListeners();
  }

  void disposeControllers() {
    usernameController.dispose();
    emailController.dispose();
    contactNoController.dispose();
    passwordController.dispose();
  }
}