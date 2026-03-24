class RegisterPageModel {
  String username;
  String email;
  String contactNo;
  String gender;
  String password;

  RegisterPageModel({
    this.username = '',
    this.email = '',
    this.contactNo = '',
    this.gender = '',
    this.password = '',
  });

  bool get isValid {
    return username.isNotEmpty &&
           email.contains('@') &&
           contactNo.isNotEmpty &&
           gender.isNotEmpty &&
           password.length >= 6;
  }
}