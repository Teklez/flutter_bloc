import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/game/game_bloc.dart';
import 'package:frontend/infrastructure/game/game_repository.dart';
import 'package:frontend/infrastructure/game/game_service.dart';
import 'package:frontend/presentation/screens/game_add.dart';

void main() {
  testWidgets('AddGameForm Widget Test - Add Button Presence',
      (WidgetTester tester) async {
    print('Starting AddGameForm Widget Test');

    // Create a new instance of GameBloc
    final gameBloc = GameBloc(GameRepository(GameService()));
    print('GameBloc created');

    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<GameBloc>.value(
          value: gameBloc,
          child: AddGameForm(buttonName: 'Add'),
        ),
      ),
    );
    print('Widget tree built with AddGameForm');

    // Verify presence of 'Add' button
    expect(find.text('Add'), findsOneWidget);
    print('Verified presence of "Add" button');

    // Clean up the bloc after the test
    await tester.pumpAndSettle();
    print('Pump and settle called');
    gameBloc.close();
    print('GameBloc closed');
  });
}
