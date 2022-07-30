import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

UserData userFromJson(String str) => UserData.fromJson(json.decode(str));

String userToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    required this.id,
    required this.name,
    required this.email,
  });

  String id;
  String name;
  String email;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}

class UserStorage {
  static const _storage = FlutterSecureStorage();
  static const _userDataKey = 'userData';

  static Future<UserData?> getUserData() async {
    final userData = await _storage.read(key: _userDataKey);
    if (userData == null) {
      return null;
    }
    return UserData.fromJson(json.decode(userData));
  }

  static Future<void> setUserData(
      {required String id, required String name, required String email}) async {
    final data = UserData(id: id, name: name, email: email);

    await _storage.write(key: _userDataKey, value: json.encode(data));
  }

  static Future<void> deleteUserData() async {
    await _storage.delete(key: _userDataKey);
  }
}
