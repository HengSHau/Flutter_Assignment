class LoginPageModel {
  String email;
  String password;

  LoginPageModel({
    this.email = '',
    this.password = '',
  });

  bool get isValid {
    return email.isNotEmpty && email.contains('@') && password.isNotEmpty;
  }
}