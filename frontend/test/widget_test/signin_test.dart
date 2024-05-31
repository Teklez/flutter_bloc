import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/review/review_bloc.dart';
import 'package:frontend/infrastructure/review/review_repository.dart';
import 'package:frontend/infrastructure/review/review_service.dart';
import 'package:frontend/presentation/screens/rating_page.dart';

void main() {
  testWidgets('RatingForm Widget Test - Submit Button Presence',
      (WidgetTester tester) async {
    print('Starting RatingForm Widget Test');

    // Create a new instance of ReviewBloc
    final reviewBloc = ReviewBloc(ReviewRepository(ReviewService()));
    print('Created ReviewBloc instance');

    // Build our widget and trigger a frame
    print('Pumping RatingForm widget into the widget tree');
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ReviewBloc>.value(
          value: reviewBloc,
          child: RatingForm(gameId: 'game123'),
        ),
      ),
    );

    // Verify presence of 'Submit' button
    print('Verifying presence of "Submit" button');
    expect(find.text('Submit'), findsOneWidget);

    // Clean up the bloc after the test
    print('Cleaning up and closing ReviewBloc');
    await tester.pumpAndSettle();
    reviewBloc.close();

    print('RatingForm Widget Test completed');
  });
}
