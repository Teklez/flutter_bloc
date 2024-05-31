import 'package:equatable/equatable.dart';
import 'package:frontend/domain/review_model.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object?> get props => [];
}

class FetchReviews extends ReviewEvent {
  final String gameId;
  const FetchReviews(this.gameId);
  @override
  List<Object?> get props => [gameId];
}

class AddReview extends ReviewEvent {
  final Review review;
  final String gameId;

  const AddReview(this.review, this.gameId);

  @override
  List<Object?> get props => [review];
}

class EditReview extends ReviewEvent {
  final Review review;

  const EditReview(this.review);

  @override
  List<Object?> get props => [review];
}

class DeleteReview extends ReviewEvent {
  final String gameId;
  final String reviewId;
  const DeleteReview(this.reviewId, this.gameId);

  @override
  List<Object?> get props => [reviewId];
}

class FetchReview extends ReviewEvent {
  final String reviewId;

  const FetchReview(this.reviewId);

  @override
  List<Object?> get props => [reviewId];
}
