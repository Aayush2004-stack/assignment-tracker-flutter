class UserModel {
  final String fullName;
  final String email;
  final String profileImg;

  UserModel({
    required this.fullName,
    required this.email,
    required this.profileImg,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json["full_name"],
      email: json["email"],
      profileImg: json["profile_image"],
    );
  }
}

class AuthTokens {
  final String userToken;

  AuthTokens({required this.userToken});

  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    return AuthTokens(userToken: json['userData']["user_token"]);
  }
}
