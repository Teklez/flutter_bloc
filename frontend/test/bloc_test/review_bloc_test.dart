import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/review/review_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:frontend/presentation/events/review_event.dart';
import 'package:frontend/presentation/states/review_state.dart';
import 'package:frontend/domain/review_model.dart';
import 'package:frontend/infrastructure/review/review_repository.dart';

import 'review_bloc_test.mocks.dart';

@GenerateMocks([ReviewRepository])
void main() {
  late MockReviewRepository mockReviewRepository;
  late ReviewBloc reviewBloc;

  setUp(() {
    mockReviewRepository = MockReviewRepository();
    reviewBloc = ReviewBloc(mockReviewRepository);
  });

  tearDown(() {
    reviewBloc.close();
  });

  group('ReviewBloc', () {
    final Review review = Review(
      id: '1',
      username: 'user1',
      comment: 'Great game!',
      rating: 5.0,
      date: '2024-06-17',
    );
    final List<Review> reviews = [review];
    final String gameId = 'game1';
    final String reviewId = '1';

    blocTest<ReviewBloc, ReviewState>(
      'emits [ReviewsLoadSuccess] when FetchReviews is successful',
      build: () {
        when(mockReviewRepository.getReviews(gameId)).thenAnswer((_) async {
          print('Mock: getReviews($gameId) called');
          return reviews;
        });
        return reviewBloc;
      },
      act: (bloc) {
        print('Act: FetchReviews event added');
        bloc.add(FetchReviews(gameId));
      },
      expect: () => [ReviewsLoadSuccess(reviews)],
      verify: (_) {
        verify(mockReviewRepository.getReviews(gameId)).called(1);
      },
    );

    blocTest<ReviewBloc, ReviewState>(
      'emits [ReviewOperationFailure] when FetchReviews fails',
      build: () {
        when(mockReviewRepository.getReviews(gameId))
            .thenThrow(Exception('Failed to load reviews'));
        return reviewBloc;
      },
      act: (bloc) {
        print('Act: FetchReviews event added');
        bloc.add(FetchReviews(gameId));
      },
      expect: () => [ReviewOperationFailure('Failed to load reviews')],
    );

    blocTest<ReviewBloc, ReviewState>(
      'emits [ReviewsLoadSuccess] when AddReview is successful',
      build: () {
        when(mockReviewRepository.createReview(review, gameId))
            .thenAnswer((_) async {
          print('Mock: createReview($review, $gameId) called');
          return review;
        });
        when(mockReviewRepository.getReviews(gameId)).thenAnswer((_) async {
          print('Mock: getReviews($gameId) called');
          return reviews;
        });
        return reviewBloc;
      },
      act: (bloc) {
        print('Act: AddReview event added');
        bloc.add(AddReview(review, gameId));
      },
      expect: () => [ReviewsLoadSuccess(reviews)],
      verify: (_) {
        verify(mockReviewRepository.createReview(review, gameId)).called(1);
        verify(mockReviewRepository.getReviews(gameId)).called(1);
      },
    );

    blocTest<ReviewBloc, ReviewState>(
      'emits [ReviewOperationFailure] when AddReview fails',
      build: () {
        when(mockReviewRepository.createReview(review, gameId))
            .thenThrow(Exception('Failed to add review'));
        return reviewBloc;
      },
      act: (bloc) {
        print('Act: AddReview event added');
        bloc.add(AddReview(review, gameId));
      },
      expect: () => [isA<ReviewOperationFailure>()],
      verify: (_) {
        verify(mockReviewRepository.createReview(review, gameId)).called(1);
      },
    );

    blocTest<ReviewBloc, ReviewState>(
      'emits [ReviewsLoadSuccess] when EditReview is successful',
      build: () {
        when(mockReviewRepository.updateReview(reviewId, review))
            .thenAnswer((_) async {
          print('Mock: updateReview($reviewId, $review) called');
          return review;
        });
        when(mockReviewRepository.getReviews(gameId)).thenAnswer((_) async {
          print('Mock: getReviews($gameId) called');
          return reviews;
        });
        return reviewBloc;
      },
      act: (bloc) {
        print('Act: EditReview event added');
        bloc.add(EditReview(review, gameId));
      },
      expect: () => [ReviewsLoadSuccess(reviews)],
      verify: (_) {
        verify(mockReviewRepository.updateReview(review.id, review)).called(1);
        verify(mockReviewRepository.getReviews(gameId)).called(1);
      },
    );

    blocTest<ReviewBloc, ReviewState>(
      'emits [ReviewOperationFailure] when EditReview fails',
      build: () {
        when(mockReviewRepository.updateReview(reviewId, review))
            .thenThrow(Exception('Failed to update review'));
        return reviewBloc;
      },
      act: (bloc) {
        print('Act: EditReview event added');
        bloc.add(EditReview(review, gameId));
      },
      expect: () => [ReviewOperationFailure('Failed to update review')],
    );

    blocTest<ReviewBloc, ReviewState>(
      'emits [ReviewsLoadSuccess] when DeleteReview is successful',
      build: () {
        when(mockReviewRepository.deleteReview(reviewId, gameId))
            .thenAnswer((_) async {
          print('Mock: deleteReview($reviewId, $gameId) called');
        });
        when(mockReviewRepository.getReviews(gameId)).thenAnswer((_) async {
          print('Mock: getReviews($gameId) called');
          return reviews;
        });
        return reviewBloc;
      },
      act: (bloc) {
        print('Act: DeleteReview event added');
        bloc.add(DeleteReview(reviewId, gameId));
      },
      expect: () => [ReviewsLoadSuccess(reviews)],
      verify: (_) {
        verify(mockReviewRepository.deleteReview(reviewId, gameId)).called(1);
        verify(mockReviewRepository.getReviews(gameId)).called(1);
      },
    );

    blocTest<ReviewBloc, ReviewState>(
      'emits [ReviewOperationFailure] when DeleteReview fails',
      build: () {
        when(mockReviewRepository.deleteReview(reviewId, gameId))
            .thenThrow(Exception('Failed to delete review'));
        return reviewBloc;
      },
      act: (bloc) {
        print('Act: DeleteReview event added');
        bloc.add(DeleteReview(reviewId, gameId));
      },
      expect: () => [ReviewOperationFailure('Failed to delete review')],
    );

    blocTest<ReviewBloc, ReviewState>(
      'emits [ReviewLoadSuccess] when FetchReview is successful',
      build: () {
        when(mockReviewRepository.getReview(reviewId)).thenAnswer((_) async {
          print('Mock: getReview($reviewId) called');
          return review;
        });
        return reviewBloc;
      },
      act: (bloc) {
        print('Act: FetchReview event added');
        bloc.add(FetchReview(reviewId));
      },
      expect: () => [ReviewLoadSuccess(review)],
      verify: (_) {
        verify(mockReviewRepository.getReview(reviewId)).called(1);
      },
    );

    blocTest<ReviewBloc, ReviewState>(
      'emits [ReviewOperationFailure] when FetchReview fails',
      build: () {
        when(mockReviewRepository.getReview(reviewId))
            .thenThrow(Exception('Failed to load review'));
        return reviewBloc;
      },
      act: (bloc) {
        print('Act: FetchReview event added');
        bloc.add(FetchReview(reviewId));
      },
      expect: () => [ReviewOperationFailure('Failed to load review')],
    );
  });
}
