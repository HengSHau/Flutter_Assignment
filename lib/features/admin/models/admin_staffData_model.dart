class StaffModel {
  final String username;
  final String email;
  final String contactNo;
  final String gender;
  final String password;

  StaffModel({
    required this.username,
    required this.email,
    required this.contactNo,
    required this.gender,
    required this.password,
  });

  StaffModel copyWith({
    String? username,
    String? email,
    String? contactNo,
    String? gender,
    String? password,
  }) {
    return StaffModel(
      username: username ?? this.username,
      email: email ?? this.email,
      contactNo: contactNo ?? this.contactNo,
      gender: gender ?? this.gender,
      password: password ?? this.password,
    );
  }
}