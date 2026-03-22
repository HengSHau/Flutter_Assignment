import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/admin/models/admin_staffData_model.dart';

class AdminEditStaffViewModel extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController gmailController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? selectedRole;
  String? selectedGender;
  int? selectedIndex;

  final List<StaffModel> staffList = [
    StaffModel(
      username: 'Alice',
      gmail: 'alice@gmail.com',
      role: 'Finance',
      contactNo: '0123456789',
      gender: 'Female',
      password: '123456',
    ),
    StaffModel(
      username: 'Ben',
      gmail: 'ben@gmail.com',
      role: 'Admin',
      contactNo: '0112233445',
      gender: 'Male',
      password: 'abcdef',
    ),
    StaffModel(
      username: 'Chris',
      gmail: 'chris@gmail.com',
      role: 'Finance',
      contactNo: '0199988877',
      gender: 'Male',
      password: 'qwerty',
    ),
  ];

  void selectStaff(int index) {
    final staff = staffList[index];
    selectedIndex = index;

    usernameController.text = staff.username;
    gmailController.text = staff.gmail;
    selectedRole = staff.role;
    contactNoController.text = staff.contactNo;
    passwordController.text = staff.password;
    selectedGender = staff.gender;

    notifyListeners();
  }

  void updateSelectedStaff() {
    if (selectedIndex == null) return;

    staffList[selectedIndex!] = staffList[selectedIndex!].copyWith(
      username: usernameController.text,
      gmail: gmailController.text,
      role: selectedRole,
      contactNo: contactNoController.text,
      gender: selectedGender,
      password: passwordController.text,
    );

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
    gmailController.dispose();
    contactNoController.dispose();
    passwordController.dispose();
  }
}