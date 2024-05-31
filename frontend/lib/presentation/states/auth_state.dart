import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSuccess extends AuthState {
  final Map<String, dynamic> message;

  const AuthSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLogout extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthRegister extends AuthState {
  final String message;

  const AuthRegister({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthDelete extends AuthState {
  final String message;

  const AuthDelete({required this.message});

  @override
  List<Object> get props => [message];
}

class UsernameAlreadyTaken extends AuthState {
  final String message;

  const UsernameAlreadyTaken({required this.message});

  @override
  List<Object> get props => [message];
}


class UpdateSuccess extends AuthState {
  final String message;

  const UpdateSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class UpdateFailure extends AuthState {
  final String message;

  const UpdateFailure({required this.message});

  @override
  List<Object> get props => [message];
}