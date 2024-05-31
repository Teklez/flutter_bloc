import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/presentation/events/users_event.dart';
import 'package:frontend/infrastructure/user/users_repository.dart';
import 'package:frontend/presentation/states/users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository usersRepository;
  UsersBloc(this.usersRepository) : super(UsersInitial()) {
    on<FetchUsers>(_handleFetchUsers);
    on<ChangeStatus>(_handleChangeStatus);
  }

  void _handleFetchUsers(FetchUsers event, Emitter<UsersState> emit) async {
    try {
      final users = await usersRepository.fetchUsers();
      if (users.isEmpty) {
        emit(UsersEmpty());
        return;
      } else {
        emit(UsersLoadSuccess(users));
      }
    } catch (e) {
      emit(UsersError());
    }
  }

  void _handleChangeStatus(ChangeStatus event, Emitter<UsersState> emit) async {
    try {
      await usersRepository.changeStatus(event.user);
      final users = await usersRepository.fetchUsers();
      emit(UsersLoadSuccess(users));
    } catch (e) {
      emit(UsersError());
    }
  }
}
