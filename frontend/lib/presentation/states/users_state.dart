import 'package:equatable/equatable.dart';
import 'package:frontend/domain/users_model.dart';

abstract class UsersState extends Equatable {
  const UsersState();
}

class UsersInitial extends UsersState {
  @override
  List<Object?> get props => [];
}

class UsersLoadSuccess extends UsersState {
  final List<User> users;

  const UsersLoadSuccess(this.users);

  @override
  List<Object?> get props => [users];
}

class UsersError extends UsersState {
  @override
  List<Object?> get props => [];
}

class UsersEmpty extends UsersState {
  @override
  List<Object?> get props => [];
}

class UsersLoadInProgress extends UsersState {
  @override
  List<Object?> get props => [];
}
