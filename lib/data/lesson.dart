// To parse this JSON data, do
//
//     final lessonModel = lessonModelFromJson(jsonString);

import 'dart:convert';

LessonModel lessonModelFromJson(String str) => LessonModel.fromJson(json.decode(str));

String lessonModelToJson(LessonModel data) => json.encode(data.toJson());

class LessonModel {
  LessonModel({
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

  factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
    id: Id.fromJson(json["_id"]),
    title: json["title"],
    description: json["description"],
    exampleVideo: json["example_video"],
    categoryName: json["category_name"],
    dateCreated: DateCreated.fromJson(json["dateCreated"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id.toJson(),
    "title": title,
    "description": description,
    "example_video": exampleVideo,
    "category_name": categoryName,
    "dateCreated": dateCreated?.toJson(),
  };
}

class DateCreated {
  DateCreated({
    this.date,
  });

  int? date;

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
