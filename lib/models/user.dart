// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name,
    required this.email,
    required this.password,
    this.issuer,
    this.dateCreated,
  });

  Id? id = Id(
    oid: '',
  );

  String? name = "";
  String email = "";
  String password = "";
  String? issuer = "";
  DateCreated? dateCreated = DateCreated(date: 0);

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        issuer: json["issuer"],
        dateCreated: DateCreated.fromJson(json["date_created"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? "" : id!.toJson(),
        "name": name,
        "email": email,
        "password": password,
        "issuer": issuer,
        "date_created": dateCreated == null ? 0 : dateCreated!.toJson(),
      };
}

class DateCreated {
  DateCreated({
    required this.date,
  });

  int date;

  factory DateCreated.fromJson(Map<String, dynamic> json) => DateCreated(
        date: json["\u0024date"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024date": date,
      };
}

class Id {
  Id({
    this.oid,
  });

  String? oid;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        oid: json["\u0024oid"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024oid": oid,
      };
}
