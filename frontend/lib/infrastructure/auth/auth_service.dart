import 'dart:convert';
import 'dart:io';
import 'package:frontend/domain/storage/storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const baseUrl = 'http://127.0.0.1:5500';

  // login user
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'username': username, 'password': password}),
      );
      if (response.statusCode == 201) {
        final access_token = json.decode(response.body)['access_token'];

        UserPreferences.saveAccessToken(access_token);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', access_token);

        return await getCurrentUserFromStoredToken();
      } else if (response.statusCode == HttpStatus.unauthorized) {
        throw Exception('IncorrectPassword');
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<String?> getStoredToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Map<String, dynamic> getCurrentUser(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken;
  }

  Future<Map<String, dynamic>> getCurrentUserFromStoredToken() async {
    String? token = await getStoredToken();
    if (token != null) {
      return getCurrentUser(token);
    }
    return {};
  }

  // register user

  Future<Map<String, dynamic>> register(
      String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'username': username, 'password': password}),
      );
      if (response.statusCode == 201) {
        return login(username, password);
      } else if (response.statusCode == 400) {
        throw Exception('userAlreadyExists');
      } else {
        throw Exception('Failed to register: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  // delete user

  Future<void> delete(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/auth/delete/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }

  // update user

  Future update(String id, String username, String newPassword,
      String oldPassword) async {
    try {
      String? accessToken = await UserPreferences.getAccessToken();
      final response = await http.put(
        Uri.parse('$baseUrl/auth/user/update/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
          'username': username,
        }),
      );
      if (response.statusCode == 200) {
        final access_token = response.body;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', access_token);
        return getCurrentUserFromStoredToken();
      } else {
        throw Exception('Failed to update: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update: $e');
    }
  }

  // logout user

  Future<void> logout(message) async {
    String? accessToken = await UserPreferences.getAccessToken();
    final response = await http
        .get(Uri.parse('$baseUrl/auth/logout'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken'
    });

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
    } else {
      throw Exception('Failed to logout');
    }
  }
}
