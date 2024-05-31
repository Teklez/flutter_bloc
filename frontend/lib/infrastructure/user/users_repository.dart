import 'package:frontend/domain/users_model.dart';
import 'package:frontend/infrastructure/user/users_service.dart';

class UsersRepository {
  final UsersService userService;

  UsersRepository({required this.userService});

  Future<List<User>> fetchUsers() async {
    try {
      return await userService.fetchUsers();
    } catch (e) {
      print('Error fetching users: $e');
      rethrow;
    }
  }

  Future<void> changeStatus(user ) async {
    try {
      await userService.changeStatus(user);
    } catch (e) {
      print('Error changing status: $e');
      rethrow;
    }
  }
}
