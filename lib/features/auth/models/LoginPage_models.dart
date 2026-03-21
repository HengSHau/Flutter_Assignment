class LoginPageModel {
  String email;
  String password;

  LoginPageModel({
    this.email = '',
    this.password = '',
  });

  // You can even put page-specific validation logic here!
  bool get isValid {
    return email.isNotEmpty && email.contains('@') && password.isNotEmpty;
  }
}