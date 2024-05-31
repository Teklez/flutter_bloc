import 'package:frontend/infrastructure/auth/auth_service.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository({required this.authService});

  Future login(String username, String password) async {
    return await authService.login(username, password);
  }

  Future<void> logout(message) async {
    return await authService.logout(message);
  }

  Future register(String username, String password) async {
    return await authService.register(username, password);
  }

  Future update(String id, String username, String newPassword,
      String oldPassword) async {
    try {
      return await authService.update(id, username, newPassword, oldPassword);
    } catch (e) {
      print(
          'Error updating user============================================> from repository: $e');
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    return await authService.delete(id);
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    return await authService.getCurrentUserFromStoredToken();
  }
}
