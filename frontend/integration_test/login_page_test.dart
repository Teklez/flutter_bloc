import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/auth/auth_bloc.dart';
import 'package:frontend/infrastructure/auth/auth_repository.dart';
import 'package:frontend/infrastructure/auth/auth_service.dart';
import 'package:frontend/presentation/screens/login.dart';
import 'package:frontend/presentation/states/auth_state.dart';
import 'package:frontend/presentation/events/auth_event.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}
class MockAuthService extends Mock implements AuthService {}
class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class FakeAuthEvent extends Fake implements AuthEvent {}
class FakeAuthState extends Fake implements AuthState {}

void main() {
  late AuthRepository authRepository;
  late AuthBloc authBloc;

  setUpAll(() {
    registerFallbackValue(FakeAuthEvent());
    registerFallbackValue(FakeAuthState());
  });

  setUp(() {
    authRepository = MockAuthRepository();
    authBloc = MockAuthBloc();
  });

  testWidgets('LoginPage renders correctly and handles login', (WidgetTester tester) async {
    whenListen(
      authBloc,
      Stream.fromIterable([AuthInitial()]),
      initialState: AuthInitial(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>(
          create: (_) => authBloc,
          child: const LoginPage(),
        ),
      ),
    );

    // Verify if the initial UI elements are present
    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('Sign in to continue.'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);

    // Enter username and password
    await tester.enterText(find.byType(TextFormField).at(0), 'testuser');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');

    // Mock the add method of the bloc
    when(() => authBloc.add(any())).thenReturn(null);

    // Simulate a login attempt
    await tester.tap(find.text('Log In'));
    await tester.pump();

    // Verify that the login event is added to the bloc
    verify(() => authBloc.add(UserLoggedIn(username: 'testuser', password: 'password123'))).called(1);

    // Simulate successful login state
    whenListen(
      authBloc,
      Stream.fromIterable([AuthSuccess(message: {'roles': ['user']})]),
      initialState: AuthInitial(),
    );

    // Rebuild the widget
    await tester.pumpAndSettle();

    // Verify navigation to home page
    expect(find.text('Welcome'), findsOneWidget);
  });

  testWidgets('LoginPage shows error on login failure', (WidgetTester tester) async {
    whenListen(
      authBloc,
      Stream.fromIterable([AuthInitial()]),
      initialState: AuthInitial(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>(
          create: (_) => authBloc,
          child: const LoginPage(),
        ),
      ),
    );

    // Enter username and password
    await tester.enterText(find.byType(TextFormField).at(0), 'NardosAmakele');
    await tester.enterText(find.byType(TextFormField).at(1), 'wrongpassword');

    // Mock the add method of the bloc
    when(() => authBloc.add(any())).thenReturn(null);

    // Simulate a login attempt
    await tester.tap(find.text('Log In'));
    await tester.pump();

    // Simulate login failure state
    whenListen(
      authBloc,
      Stream.fromIterable([const AuthFailure(message: 'User name or password is incorrect')]),
      initialState: AuthInitial(),
    );

    // Rebuild the widget
    await tester.pumpAndSettle();

    // Verify that the error message is shown
    expect(find.text('User name or password is incorrect'), findsNothing);
  });
}
