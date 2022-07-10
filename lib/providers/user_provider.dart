import 'dart:convert';

import 'package:hlingo/models/user.dart';
import 'package:hlingo/utils/constant.dart';
import 'package:http/http.dart' as http;

class LessonsProvider {
  Future <List<User>> updateUser(String name, String lastName) async{
    Map<String,String> queryParams={
      'name': name,
      'lastName': lastName
    };
    final endpointWithQuery=Uri.parse('$baseUrl/user/edit').replace(queryParameters: queryParams);
    final res= await http.get(endpointWithQuery);
    if (res.statusCode==200){
      return json
          .decode(res.body)
          .map<User>((user)=>User.fromJson(user))
          .toList();
    }else{
      throw Exception('Error updating user');
    }
  }
}
