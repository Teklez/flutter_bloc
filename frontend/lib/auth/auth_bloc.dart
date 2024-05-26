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
      emit(AuthFailure(message: 'Not authenticated'));
    }
  }

  // AppStarted event handler

  void _handleAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    try {
      final user = await authRepository.getCurrentUser();
      if (user != null) {
        emit(AuthSuccess(message: user));
      } else {
        emit(AuthFailure(message: 'Not authenticated'));
      }
    } catch (e) {
      emit(AuthFailure(message: 'Not authenticated'));
    }
  }

  // UserLoggedIn event handler

  void _handleUserLoggedIn(UserLoggedIn event, Emitter<AuthState> emit) async {
    try {
      final token = await authRepository.login(event.username, event.password);
      if (token != null) {
        emit(AuthSuccess(message: token));
      } else {
        emit(AuthFailure(message: 'Not authenticated'));
      }
    } catch (e) {
      emit(AuthFailure(message: 'Not authenticated'));
    }
  }

// UserLoggedOut event handler

  void _handleUserLoggedOut(
      UserLoggedOut event, Emitter<AuthState> emit) async {
    try {
      await authRepository.logout(event.id);
      emit(AuthFailure(message: 'Not authenticated'));
    } catch (e) {
      emit(AuthFailure(message: 'Not authenticated'));
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
        emit(AuthFailure(message: 'null returned from register user'));
      }
    } catch (e) {
      print("\n" * 100);
      print(e);
      print("\n" * 100);
      emit(AuthFailure(message: 'Fialed to register user'));
    }
  }

// UserDeleted event handler

  void _handleUserDeleted(UserDeleted event, Emitter<AuthState> emit) async {
    try {
      await authRepository.delete(event.id);
      emit(AuthFailure(message: 'Not authenticated'));
    } catch (e) {
      emit(AuthFailure(message: 'Not authenticated'));
    }
  }

  void _handleUserUpdated(UserUpdated event, Emitter<AuthState> emit) async {
    try {
      final data = await authRepository.update(
          event.id, event.username, event.newPassword, event.oldPassword);

      if (data != null) {
        emit(UpdateSuccess(message: "Profile updated"));
      } else {
        emit(AuthFailure(message: 'update failed'));
      }
    } catch (e) {
      emit(AuthFailure(message: ''));
    }
  }
}
