import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _keyAccessToken = "accessToken";
  static const String _keyUser = "currentUser";

  // Save access token
  static Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAccessToken, token);
  }

  // Get access token
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAccessToken);
  }

  // Save current user information
  static Future<void> saveCurrentUser(String user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUser, user);
  }

  // Get current user information
  static Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUser);
  }

  // Remove all saved information (logout)
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAccessToken);
    await prefs.remove(_keyUser);
  }
}
