import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppStarted extends AuthEvent {
  @override
  List<Object> get props => [];
}

class UserLoggedIn extends AuthEvent {
  final String username;
  final String password;

  const UserLoggedIn({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class UserLoggedOut extends AuthEvent {
  final Map<String, dynamic> message;
  const UserLoggedOut({required this.message});
  @override
  List<Object> get props => [message];
}

class UserRegistered extends AuthEvent {
  final String username;
  final String password;

  const UserRegistered({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class UserDeleted extends AuthEvent {
  final String id;

  const UserDeleted({required this.id});

  @override
  List<Object> get props => [id];
}

class CurrentUser extends AuthEvent {
  @override
  List<Object> get props => [];
}

class UserUpdated extends AuthEvent {
  final String id;
  final String username;
  final String newPassword;
  final String oldPassword;

  const UserUpdated(
      {required this.username,
      required this.newPassword,
      required this.oldPassword,
      required this.id});

  @override
  List<Object> get props => [id, username, newPassword, oldPassword];
}
