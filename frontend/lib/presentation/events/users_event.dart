import 'package:equatable/equatable.dart';
import 'package:frontend/domain/users_model.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object?> get props => [];
}

class FetchUsers extends UsersEvent {
  const FetchUsers();
}

class ChangeStatus extends UsersEvent {
  final User user;
  const ChangeStatus(this.user);

  @override
  List<Object?> get props => [user];
}
