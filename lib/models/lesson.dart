// To parse this JSON data, do
//
//     final Lesson = LessonFromJson(jsonString);

import 'dart:convert';

Lesson lessonFromJson(String str) => Lesson.fromJson(json.decode(str));

String lessonToJson(Lesson data) => json.encode(data.toJson());

class Lesson {
  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.exampleVideo,
    required this.categoryName,
    this.dateCreated,
  });

  Id id;
  String title;
  String description;
  String exampleVideo;
  String categoryName;
  DateCreated? dateCreated;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: Id.fromJson(json["_id"]),
        title: json["title"],
        description: json["description"],
        exampleVideo: json["example"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "title": title,
        "description": description,
        "example": exampleVideo,
        "category_name": categoryName,
        "date_created": dateCreated?.toJson(),
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
    required this.oid,
  });

  String oid;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        oid: json["\u0024oid"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024oid": oid,
      };
}
