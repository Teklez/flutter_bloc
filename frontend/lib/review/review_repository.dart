import 'package:frontend/review/review_model.dart';
import 'package:frontend/review/review_service.dart';

class ReviewRepository {
  final ReviewService reviewService;
  ReviewRepository(this.reviewService);

  Future<List<Review>> getReviews(gameId) async {
    return reviewService.getReviews(gameId);
  }

  Future<Review> getReview(String id) async {
    return reviewService.getReview(id);
  }

  Future<Review> createReview(Review review, gameId) async {
    return reviewService.createReview(review, gameId);
  }

  Future<Review> updateReview(String id, Review review) async {
    return reviewService.updateReview(id, review);
  }

  Future<void> deleteReview(String id, String gameId) async {
    return reviewService.deleteReview(id, gameId);
  }
}
