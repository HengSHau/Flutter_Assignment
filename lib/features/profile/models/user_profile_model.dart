class UserProfileModel {
  final String username;
  final String email;
  final String contactNo;
  final String gender;

  UserProfileModel({
    required this.username,
    required this.email,
    required this.contactNo,
    required this.gender,
  });

  factory UserProfileModel.fromMap(Map<String,dynamic> map){
    return UserProfileModel(
      username:map['username']??'',
      email:map['email']??'',
      contactNo: map['contactNo']??'',
      gender:map['gender']??'',
    );
  }

  Map<String,dynamic>toMap(){
    return{
      'username':username,
      'email':email,
      'contactNo':contactNo,
      'gender':gender,
    };
  }
}