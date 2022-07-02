import 'dart:convert';

import 'package:hlinog/models/lesson.dart';
import 'package:hlinog/utils/constant.dart';
import 'package:http/http.dart' as http;

class LessonsProvider {
  Future<List<Lesson>> getLessons() async {
    final res = await http.get(Uri.parse('$baseUrl/lessons'));
    print(res.body);
    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      throw Exception('Error getting lessons');
    }
  }
}
