import 'package:frontend/auth/auth_model.dart';
import 'package:frontend/auth/auth_service.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository({required this.authService});

  Future login(String username, String password) async {
    return await authService.login(username, password);
  }

  Future<void> logout(id) async {
    return await authService.logout(id);
  }

  Future register(String username, String password) async {
    return await authService.register(username, password);
  }

  Future<AuthModel> update(String id, String username, String newPassword,
      String oldPassword) async {
    return await authService.update(id, username, newPassword, oldPassword);
  }

  Future<void> delete(String id) async {
    return await authService.delete(id);
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    return await authService.getCurrentUserFromStoredToken();
  }
}
