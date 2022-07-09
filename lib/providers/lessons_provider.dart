import 'dart:convert';

import 'package:hlingo/models/lesson.dart';
import 'package:hlingo/utils/constant.dart';
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

  Future <List<Lesson>> findLessons(String term) async{
    Map<String,String> queryParams={
      'term':term
    };
    final endpointWithQuery=Uri.parse('$baseUrl/lessons/search').replace(queryParameters: queryParams);
    final res= await http.get(endpointWithQuery);
    if (res.statusCode==200){
      return json
          .decode(res.body)
          .map<Lesson>((lesson)=>Lesson.fromJson(lesson))
          .toList();
    }else{
      throw Exception('Error getting lessons');
    }
  }
}
