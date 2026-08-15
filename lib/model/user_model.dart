class UserModel {
  final String fullName;

  UserModel({required this.fullName});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(fullName: json["full_name"]);
  }
}

class AuthTokens {
  final String userToken;

  AuthTokens({required this.userToken});

  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    return AuthTokens(userToken: json['userData']["user_token"]);
  }
}
