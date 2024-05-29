import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/auth/auth_event.dart';
import 'package:frontend/auth/auth_repository.dart';
import 'package:frontend/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    // Register event handlers
    on<AppStarted>(_handleAppStarted);
    on<UserLoggedIn>(_handleUserLoggedIn);
    on<UserLoggedOut>(_handleUserLoggedOut);
    on<UserRegistered>(_handleUserRegistered);
    on<UserDeleted>(_handleUserDeleted);
    on<UserUpdated>(_handleUserUpdated);
    on<CurrentUser>(_handleCurrentUser);
  }

  // Event handlers
  // CurrentUser event handler

  void _handleCurrentUser(CurrentUser event, Emitter<AuthState> emit) async {
    try {
      final user = await authRepository.getCurrentUser();
      emit(AuthSuccess(message: user));
    } catch (e) {
      emit(const AuthFailure(message: 'Not authenticated'));
    }
  }

  // AppStarted event handler

  void _handleAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    try {
      final user = await authRepository.getCurrentUser();
      if (user != null) {
        emit(AuthSuccess(message: user));
      } else {
        emit(const AuthFailure(message: 'Not authenticated'));
      }
    } catch (e) {
      emit(const AuthFailure(message: 'Not authenticated'));
    }
  }

  // UserLoggedIn event handler

  void _handleUserLoggedIn(UserLoggedIn event, Emitter<AuthState> emit) async {
    try {
      final token = await authRepository.login(event.username, event.password);
      if (token != null) {
        emit(AuthSuccess(message: token));
      } else {
        emit(const AuthFailure(message: 'Not authenticated'));
      }
    } catch (e) {
      if (e.toString().contains('IncorrectPassword')) {
        emit(const AuthFailure(message: 'Incorrect password'));
      } else {
        emit(const AuthFailure(message: 'User name or password is incorrect'));
      }
    }
  }

// UserLoggedOut event handler

  void _handleUserLoggedOut(
      UserLoggedOut event, Emitter<AuthState> emit) async {
    try {
      await authRepository.logout(event.message);
      emit(AuthFailure(message: 'Logged out successfully'));
    } catch (e) {
      emit(AuthFailure(message: 'Failed to logout'));
    }
  }

// UserRegistered event handler

  void _handleUserRegistered(
      UserRegistered event, Emitter<AuthState> emit) async {
    try {
      final user =
          await authRepository.register(event.username, event.password);
      if (user != null) {
        emit(AuthSuccess(message: user));
      } else {
        emit(const AuthFailure(message: 'null returned from register user'));
      }
    } catch (e) {
      if (e.toString().contains('userAlreadyExists')) {
        emit(const AuthFailure(message: 'User Name is already taken'));
      } else {
        emit(const AuthFailure(message: 'Failed to register user'));
      }
    }
  }

// UserDeleted event handler

  void _handleUserDeleted(UserDeleted event, Emitter<AuthState> emit) async {
    try {
      await authRepository.delete(event.id);
    } catch (e) {
      emit(const AuthFailure(message: "Failed to delete user"));
    }
  }

  void _handleUserUpdated(UserUpdated event, Emitter<AuthState> emit) async {
    try {
      final data = await authRepository.update(
          event.id, event.username, event.newPassword, event.oldPassword);

      if (data != null) {
        emit(const UpdateSuccess(message: "Profile updated"));
      } else {
        emit(const AuthFailure(message: 'update failed'));
      }
    } catch (e) {
      emit(const AuthFailure(message: ''));
    }
  }
}
