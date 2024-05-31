import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/auth/auth_bloc.dart';
import 'package:frontend/infrastructure/auth/auth_repository.dart';
import 'package:frontend/infrastructure/auth/auth_service.dart';
import 'package:frontend/presentation/screens/profile.dart';
import 'package:frontend/presentation/states/auth_state.dart';

void main() {
  late AuthBloc authBloc;

  setUp(() {
    print('Setting up AuthBloc for the test');
    authBloc =
        AuthBloc(authRepository: AuthRepository(authService: AuthService()));
  });

  tearDown(() {
    print('Tearing down and closing AuthBloc');
    authBloc.close();
  });

  testWidgets('ProfilePage Widget Test - Button and Field Presence',
      (WidgetTester tester) async {
    print('Starting ProfilePage Widget Test');

    // Mock successful authentication state with a username
    print('Emitting AuthSuccess state with mock user data');
    authBloc
        .emit(AuthSuccess(message: {'username': 'testuser', 'sub': '12345'}));

    // Pump the ProfilePage widget wrapped in a BlocProvider
    print('Pumping ProfilePage widget into the widget tree');
    await tester.pumpWidget(
      BlocProvider.value(
        value: authBloc,
        child: MaterialApp(
          home: ProfilePage(),
        ),
      ),
    );

    // Verify the presence of the 'Edit Profile' button
    print('Verifying presence of "Edit Profile" button');
    expect(find.widgetWithText(ElevatedButton, 'Edit Profile'), findsOneWidget);

    print('ProfilePage Widget Test completed');
  });
}
