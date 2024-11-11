import 'dart:convert';

AuthResponse authResponseFromJson(String str) => AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  int id;
  String email;
  String tokenType;
  String accessToken;

  AuthResponse({
    required this.id,
    required this.email,
    required this.tokenType,
    required this.accessToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        id: json["id"] is String ? int.parse(json["id"]) : json["id"] ?? 0,
        email: json["email"] ?? '',
        tokenType: json["token_type"] ?? '',
        accessToken: json["access_token"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "token_type": tokenType,
        "access_token": accessToken,
      };
}
