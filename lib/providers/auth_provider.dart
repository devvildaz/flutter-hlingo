import 'dart:convert';

import 'package:hlinog/models/user.dart';
import 'package:hlinog/utils/constant.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  Future<String> registerUser(User newUser) async {
    final res = await http.post(Uri.parse('$baseUrl/register/email'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'name': newUser.name!,
          'email': newUser.email,
          'password': newUser.password,
        }));
    if (res.statusCode == 200 || res.statusCode == 201) {
      return "OK";
    } else {
      throw Exception('Error Signing up');
    }
  }

  Future<String> loginUser(User newUser) async {
    print(newUser.toJson());
    final res = await http.post(
      Uri.parse('$baseUrl/login/email'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': newUser.email,
        'password': newUser.password,
      }),
    );

    if (res.statusCode == 200) {
      return "OK";
    } else {
      throw Exception('Error Signing in');
    }
  }
}
