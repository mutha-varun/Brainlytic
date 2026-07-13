class UserModel {
  UserModel({
    required String id,
    required String email,
  });

  factory UserModel.fromJson(Map<String, dynamic> map){
    return UserModel(
      id: map['id'] ?? '', 
      email: map['email'] ?? '', 
    );
  }
}