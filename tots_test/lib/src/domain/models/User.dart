import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String? email;
    String? firstName;
    String? password;
    String? tokenType;
    String? accessToken;

    User({
      required this.firstName,
      required this.email,
      required this.password,
      this.tokenType,
      this.accessToken,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["firstname"],
        password: json["password"],
        email: json["email"],
        tokenType: json["token_type"],
        accessToken: json["access_token"],
    );

    Map<String, dynamic> toJson() => {
        "firstname": firstName,
        "password": password,
        "email": email,
        "token_type": tokenType,
        "access_token": accessToken,
    };
}
