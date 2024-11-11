import 'dart:convert';


class Client {
  int? id;
  String firstname;
  String? lastname;
  String? password;
  String? email;
  String? address;
  String? photo;
  String? caption;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;

  Client({
    this.id,
    required this.firstname,
    this.lastname,
    this.password,
    this.email,
    this.address,
    this.photo,
    this.caption,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  // Método copyWith
  Client copyWith({
    int? id,
    String? firstname,
    String? lastname,
    String? password,
    String? email,
    String? address,
    String? photo,
    String? caption,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? userId,
  }) {
    return Client(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      password: password ?? this.password,
      email: email ?? this.email,
      address: address ?? this.address,
      photo: photo ?? this.photo,
      caption: caption ?? this.caption,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }


  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"] != null ? int.tryParse(json["id"].toString()) : null,
        firstname: json["firstname"] ?? '',
        lastname: json["lastname"] ?? '',
        password: json["password"] ?? '',
        email: json["email"],
        address: json["address"],
        photo: json["photo"],
        caption: json["caption"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "password": password,
        "email": email,
        "address": address,
        "photo": photo,
        "caption": caption,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_id": userId,
      };

  static List<Client> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Client.fromJson(json)).toList();
  }
}
