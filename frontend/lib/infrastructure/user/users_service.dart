import 'dart:convert';

import 'package:frontend/domain/storage/storage.dart';
import 'package:frontend/domain/users_model.dart';
import 'package:http/http.dart' as http;

class UsersService {
  static const baseUrl = 'http://127.0.0.1:5500';

  Future<List<User>> fetchUsers() async {
    final accessToken = await UserPreferences.getAccessToken();
    final response = await http.get(
      Uri.parse('$baseUrl/auth/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $accessToken"
      },
    );
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => User.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }

  Future<void> changeStatus(User user) async {
    final accessToken = await UserPreferences.getAccessToken();
    final response = await http.put(
      Uri.parse('$baseUrl/auth/update/${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $accessToken"
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to change status');
    }
  }
}
