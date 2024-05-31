import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/auth/auth_bloc.dart';
import 'package:frontend/infrastructure/auth/auth_repository.dart';
import 'package:frontend/infrastructure/auth/auth_service.dart';
import 'package:frontend/presentation/events/auth_event.dart';
import 'package:frontend/presentation/states/auth_state.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Import the generated mocks
import 'auth_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository, AuthService])
void main() {
  late AuthBloc authBloc;
  late AuthRepository authRepository;
  late AuthService authService;

  setUp(() {
    authRepository = MockAuthRepository();
    authService = MockAuthService();
    authBloc = AuthBloc(authRepository: authRepository);
  });

  tearDown(() {
    authBloc.close();
  });

  test('initial state is AuthInitial', () {
    expect(authBloc.state, AuthInitial());
  });

  test('AppStarted event emits AuthFailure on failure', () {
    when(authService.getCurrentUserFromStoredToken())
        .thenThrow(Exception('Failed to get user'));

    final expectedStates = [
      const AuthFailure(message: 'Not authenticated'),
    ];

    expectLater(authBloc.stream, emitsInOrder(expectedStates));

    authBloc.add(AppStarted());
    print('AppStarted event added, expecting AuthFailure');
  });

  test('UserLoggedIn event emits AuthFailure on generic error', () async {
    when(authService.login('testUser', 'password'))
        .thenThrow(Exception('Some generic error'));

    final expectedStates = [
      const AuthFailure(message: 'User name or password is incorrect'),
    ];

    expectLater(authBloc.stream, emitsInOrder(expectedStates));

    authBloc.add(UserLoggedIn(username: 'testUser', password: 'password'));
    print('UserLoggedIn event added, expecting AuthFailure');
  });

  test('UserLoggedOut event emits AuthFailure on success', () async {
    final message = {'status': 'loggedOut'};

    when(authService.logout(message)).thenAnswer((_) => Future.value());

    final expectedStates = [
      AuthFailure(message: 'Logged out successfully'),
    ];

    expectLater(authBloc.stream, emitsInOrder(expectedStates));

    authBloc.add(UserLoggedOut(message: message));
    print('UserLoggedOut event added, expecting AuthFailure');
  });

  test('UserRegistered event emits AuthFailure on generic error', () async {
    when(authService.register('newUser', 'password'))
        .thenThrow(Exception('Some generic error'));

    final expectedStates = [
      const AuthFailure(message: 'Failed to register user'),
    ];

    expectLater(authBloc.stream, emitsInOrder(expectedStates));

    authBloc.add(UserRegistered(username: 'newUser', password: 'password'));
    print('UserRegistered event added, expecting AuthFailure');
  });

  test('UserUpdated event emits AuthFailure on failure', () async {
    when(authService.update(
            'userId', 'updatedUser', 'newPassword', 'oldPassword'))
        .thenThrow(Exception('Failed to update user'));

    final expectedStates = [
      const AuthFailure(message: 'update failed'),
    ];

    expectLater(authBloc.stream, emitsInOrder(expectedStates));

    authBloc.add(UserUpdated(
        id: 'userId',
        username: 'updatedUser',
        newPassword: 'newPassword',
        oldPassword: 'oldPassword'));
    print('UserUpdated event added, expecting AuthFailure');
  });

  test('UserUpdated event emits AuthFailure on generic error', () async {
    when(authService.update(
            'userId', 'updatedUser', 'newPassword', 'oldPassword'))
        .thenThrow(Exception('Some generic error'));

    final expectedStates = [
      const AuthFailure(message: 'update failed'),
    ];

    expectLater(authBloc.stream, emitsInOrder(expectedStates));

    authBloc.add(UserUpdated(
        id: 'userId',
        username: 'updatedUser',
        newPassword: 'newPassword',
        oldPassword: 'oldPassword'));
    print('UserUpdated event added, expecting AuthFailure');
  });

  test('CurrentUser event emits AuthFailure on failure', () async {
    when(authService.getCurrentUserFromStoredToken())
        .thenThrow(Exception('Not authenticated'));

    final expectedStates = [
      const AuthFailure(message: 'Not authenticated'),
    ];

    expectLater(authBloc.stream, emitsInOrder(expectedStates));

    authBloc.add(CurrentUser());
    print('CurrentUser event added, expecting AuthFailure');
  });
}
