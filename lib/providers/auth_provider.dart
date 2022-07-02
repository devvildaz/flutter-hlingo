import 'dart:convert';

import 'package:hlinog/models/user.dart';
import 'package:hlinog/utils/constant.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
    Future<User> registerUser(User newUser) async{
      final res = await http.post(Uri.parse('$baseUrl/register/email'));
      if (res.statusCode == 200) {
        return json
            .decode(res.body)
            .map<User>((user) => User.fromJson(user));
      } else {
        throw Exception('Error Signing up');
      }
    }

    Future<bool> loginUser(User newUser) async{
      final res = await http.post(Uri.parse('$baseUrl/login/email'));
      if (res.statusCode == 200) {
        return true;
      } else {
        throw Exception('Error Signing in');
      }
    }
}