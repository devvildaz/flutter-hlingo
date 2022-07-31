import 'dart:convert';
import 'dart:io';

import 'package:hlingo/models/user.dart';
import 'package:hlingo/utils/constant.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  Future <List<User>> updateUser(String id, String name, String email) async{
    Map<String,String> body={
      'id': id,
      'name': name,
      'email': email
    };
    final endpoint = Uri.parse('$baseUrl/user/edit');
    final bodyJson = json.encode(body);
    final res= await http.post(endpoint, body: bodyJson);
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
