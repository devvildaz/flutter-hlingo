import 'dart:convert';
import 'package:hlingo/models/user.dart';
import 'package:hlingo/utils/constant.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  Future<String> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    final res = await http.post(Uri.parse('$baseUrl/register/email'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password': password,
        }));
    if (res.statusCode == 200 || res.statusCode == 201) {
      return "OK";
    } else {
      throw Exception('Error Signing up');
    }
  }

  Future<User> loginUser(
      {required String email, required String password}) async {
    final res = await http.post(
      Uri.parse('$baseUrl/login/email'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (res.statusCode == 200) {
      return User.fromJson(json.decode(res.body));
    } else {
      throw Exception('Error Signing in');
    }
  }
}
