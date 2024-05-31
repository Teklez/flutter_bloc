import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/application/auth/auth_bloc.dart';
import 'package:frontend/presentation/events/auth_event.dart';
import 'package:frontend/presentation/screens/register.dart';
import 'package:frontend/presentation/states/auth_state.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  testWidgets('Form validation works correctly', (WidgetTester tester) async {
    whenListen(
      mockAuthBloc,
      Stream.fromIterable([AuthInitial()]),
      initialState: AuthInitial(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>(
          create: (context) => mockAuthBloc,
          child: RegistrationPage(),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField).at(0), 'username');
    await tester.enterText(find.byType(TextFormField).at(1), 'password');
    await tester.enterText(find.byType(TextFormField).at(2), 'password');

    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter your username'), findsNothing);
    expect(find.text('Please enter your password'), findsNothing);
    expect(find.text('Password must be at least 6 characters'), findsNothing);
    expect(find.text('Please confirm your password'), findsNothing);
    expect(find.text('Passwords do not match'), findsNothing);
  });
}
