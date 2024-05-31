import 'package:equatable/equatable.dart';
import 'package:frontend/domain/review_model.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object?> get props => [];
}

class ReviewLoading extends ReviewState {}

class ReviewsLoadSuccess extends ReviewState {
  final List<Review> reviews;
  ReviewsLoadSuccess(this.reviews);

  @override
  List<Object?> get props => [reviews];
}

class ReviewOperationSuccess extends ReviewState {
  final String message;

  ReviewOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ReviewOperationFailure extends ReviewState {
  final String message;

  ReviewOperationFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ReviewLoadSuccess extends ReviewState {
  final dynamic review;

  ReviewLoadSuccess(this.review);

  @override
  List<Object?> get props => [review];
}

class ReviewIsEmpty extends ReviewState {
  final String message;

  ReviewIsEmpty(this.message);

  @override
  List<Object?> get props => [message];
}

class ReviewUpdateSuccess extends ReviewState {
  final String message;

  ReviewUpdateSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ReviewAdded extends ReviewState {}

class ReveiwEdited extends ReviewState {}
