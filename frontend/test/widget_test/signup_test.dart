import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/auth/auth_bloc.dart';
import 'package:frontend/infrastructure/auth/auth_repository.dart';
import 'package:frontend/infrastructure/auth/auth_service.dart';
import 'package:frontend/presentation/screens/register.dart';
import 'package:go_router/go_router.dart';

void main() {
  late AuthBloc authBloc;

  setUp(() {
    authBloc =
        AuthBloc(authRepository: AuthRepository(authService: AuthService()));
  });

  tearDown(() {
    authBloc.close();
  });

  testWidgets('RegistrationPage Widget Test - Button Presence',
      (WidgetTester tester) async {
    // Set up the GoRouter
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const RegistrationPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const Scaffold(body: Text('Login')),
        ),
      ],
    );

    // Build our widget and trigger a frame
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        builder: (context, child) {
          return BlocProvider.value(
            value: authBloc,
            child: child!,
          );
        },
      ),
    );

    // Verify the presence of the 'Sign up' button
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Sign up'), findsOneWidget);

    // Ensure the 'Login' link is visible
    final loginLink = find.text('Login');
    await tester.ensureVisible(loginLink);
    expect(loginLink, findsOneWidget);

    // Tap the 'Login' link and verify navigation to the login page
    await tester.tap(loginLink);
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsOneWidget);
  });
}
