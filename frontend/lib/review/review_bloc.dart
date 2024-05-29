import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/review/review_event.dart';
import 'package:frontend/review/review_model.dart';
import 'package:frontend/review/review_repository.dart';
import 'package:frontend/review/review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository reviewRepository;

  ReviewBloc(this.reviewRepository) : super(ReviewLoading()) {
    // Register event handlers
    on<FetchReviews>(_handleFetchReviews);
    on<AddReview>(_handleAddReview);
    on<EditReview>(_handleEditReview);
    on<DeleteReview>(_handleDeleteReview);
    on<FetchReview>(_handleFetchReview);
  }

  void _handleFetchReviews(
      FetchReviews event, Emitter<ReviewState> emit) async {
    // emit(ReviewLoading());
    try {
      final List<Review> reviews =
          await reviewRepository.getReviews(event.gameId);
      if (reviews.isEmpty) {
        emit(ReviewIsEmpty("No reviews found"));
        return;
      } else {
        emit(ReviewsLoadSuccess(reviews));
      }
    } catch (e) {
      emit(ReviewOperationFailure("Failed to load reviews"));
    }
  }

  void _handleAddReview(AddReview event, Emitter<ReviewState> emit) async {
    try {
      await reviewRepository.createReview(event.review, event.gameId);
      emit(ReviewOperationSuccess("Review added successfully"));
    } catch (e) {
      emit(ReviewOperationFailure("Failed to add review"));
    }
  }

  void _handleEditReview(EditReview event, Emitter<ReviewState> emit) async {
    try {
      await reviewRepository.updateReview(event.review.id, event.review);
      emit(ReviewUpdateSuccess("Review updated successfully"));
    } catch (e) {
      emit(ReviewOperationFailure("Failed to update review"));
    }
  }

  void _handleDeleteReview(
      DeleteReview event, Emitter<ReviewState> emit) async {
    try {
      await reviewRepository.deleteReview(event.reviewId, event.gameId);
      emit(ReviewOperationSuccess("Review deleted successfully"));
    } catch (e) {
      emit(ReviewOperationFailure("Failed to delete review"));
    }
  }

  void _handleFetchReview(FetchReview event, Emitter<ReviewState> emit) async {
    try {
      final dynamic review = await reviewRepository.getReview(event.reviewId);
      emit(ReviewLoadSuccess(review));
    } catch (e) {
      emit(ReviewOperationFailure("Failed to load review"));
    }
  }
}
