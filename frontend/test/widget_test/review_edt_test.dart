import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/review/review_bloc.dart';
import 'package:frontend/domain/review_model.dart';
import 'package:frontend/infrastructure/review/review_repository.dart';
import 'package:frontend/infrastructure/review/review_service.dart';
import 'package:frontend/presentation/screens/review_edit.dart';

void main() {
  testWidgets('ReviewEdit Widget Test - Edit Button Presence',
      (WidgetTester tester) async {
    print('Starting ReviewEdit Widget Test');

    // Create a new instance of ReviewBloc
    final reviewBloc = ReviewBloc(ReviewRepository(ReviewService()));

    // Build our widget and trigger a frame.
    print('Pumping ReviewEdit widget into the widget tree');
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ReviewBloc>.value(
          value: reviewBloc,
          child: ReviewEdit(
            review: {
              'data': Review(
                id: 'review123',
                username: 'testUser',
                comment: 'Test comment',
                rating: 4.5,
                date: '2021-10-10',
              ),
              'gameId': 'game123',
            },
          ),
        ),
      ),
    );

    // Verify presence of 'Edit' button
    print('Verifying presence of "Edit" button');
    expect(find.text('Edit'), findsOneWidget);

    // Clean up the bloc after the test
    print('Cleaning up and closing ReviewBloc');
    await tester.pumpAndSettle();
    reviewBloc.close();

    print('ReviewEdit Widget Test completed');
  });
}
