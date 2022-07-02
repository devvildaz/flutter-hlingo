import 'dart:convert';

import 'package:hlinog/models/lesson.dart';
import 'package:hlinog/utils/constant.dart';
import 'package:http/http.dart' as http;

class LessonsProvider {
  Future<List<Lesson>> getLessons() async {
    final res = await http.get(Uri.parse('$baseUrl/lessons'));

    if (res.statusCode == 200) {
      return json
          .decode(res.body)
          .map<Lesson>((lesson) => Lesson.fromJson(lesson))
          .toList();
    } else {
      throw Exception('Error getting lessons');
    }
  }
}
