class StaffModel {
  final String username;
  final String gmail;
  final String contactNo;
  final String gender;
  final String password;

  StaffModel({
    required this.username,
    required this.gmail,
    required this.contactNo,
    required this.gender,
    required this.password,
  });

  StaffModel copyWith({
    String? username,
    String? gmail,
    String? contactNo,
    String? gender,
    String? password,
  }) {
    return StaffModel(
      username: username ?? this.username,
      gmail: gmail ?? this.gmail,
      contactNo: contactNo ?? this.contactNo,
      gender: gender ?? this.gender,
      password: password ?? this.password,
    );
  }
}