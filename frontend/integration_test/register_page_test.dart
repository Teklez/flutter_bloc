import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/auth/auth_bloc.dart';
import 'package:frontend/presentation/events/auth_event.dart';
import 'package:frontend/presentation/events/auth_event.dart';
import 'package:frontend/presentation/screens/register.dart';
import 'package:frontend/presentation/states/auth_state.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

class FakeAuthEvent extends Fake implements AuthEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAuthEvent());
  });

  group('RegistrationPage', () {
    late AuthBloc authBloc;

    setUp(() {
      authBloc = MockAuthBloc();
    });

    testWidgets('should display error message when registration fails', (WidgetTester tester) async {
      when(() => authBloc.state).thenReturn(const AuthFailure(message: 'Error'));
      when(() => authBloc.stream).thenAnswer((_) => Stream.value(const AuthFailure(message: 'Error')));
      when(() => authBloc.add(any())).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: authBloc,
            child: const RegistrationPage(),
          ),
        ),
      );

      expect(find.text('Error'), findsOneWidget);
    });

    testWidgets('should navigate to home page when registration succeeds', (WidgetTester tester) async {
      when(() => authBloc.state).thenReturn(const AuthSuccess(message: {}));
      when(() => authBloc.stream).thenAnswer((_) => Stream.value(const AuthSuccess(message: {})));
      when(() => authBloc.add(any())).thenAnswer((_) async {});

      final goRouter = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => BlocProvider.value(
              value: authBloc,
              child: const RegistrationPage(),
            ),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Home Page'))),
          ),
        ],
        initialLocation: '/',
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerDelegate: goRouter.routerDelegate,
          routeInformationParser: goRouter.routeInformationParser,
          routeInformationProvider: goRouter.routeInformationProvider,
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'NardosAmakele');
      await tester.enterText(find.byType(TextFormField).at(1), 'testpassword');
      await tester.enterText(find.byType(TextFormField).at(2), 'testpassword');
      
      await tester.tap(find.text('Sign up'));
      

      await tester.pumpAndSettle();

      expect(find.text('Home Page'), findsOneWidget);
    });
  });
}
