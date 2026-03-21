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

  // Basic validation to ensure fields aren't empty and password is long enough
  bool get isValid {
    return username.isNotEmpty &&
           email.contains('@') &&
           contactNo.isNotEmpty &&
           gender.isNotEmpty &&
           password.length >= 6; // Firebase requires at least 6 characters
  }
}