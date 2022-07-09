// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.name,
    required this.email,
    this.password,
    this.issuer,
  });

  String name;
  String email;
  String? password = "";
  String? issuer = "";

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        issuer: json["issuer"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
      };

  User copyWith({
    String? name,
    String? email,
  }) =>
      User(name: name ?? this.name, email: email ?? this.email);
}
