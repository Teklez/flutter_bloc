import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:frontend/domain/review_model.dart';
import 'package:frontend/presentation/widgets/user_review_card.dart';

void main() {
  testWidgets('UserReview displays correct review data', (WidgetTester tester) async {
    // Define input
    final review = Review(
      username: 'TestUser',
      rating: 4.0,
      date: '2024-06-16',
      comment: 'This is a test comment.',
      // Add other fields as necessary
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: UserReview(review: review),
      ),
    ));

    // Check the result
    expect(find.text('TestUser'), findsOneWidget);
    expect(find.text('This is a test comment.'), findsOneWidget);
    expect(find.text('2024-06-16'), findsOneWidget);
    // Add other checks as necessary
  });
}
