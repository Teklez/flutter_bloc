import 'package:frontend/review/review_model.dart';
import 'package:frontend/review/review_service.dart';

class ReviewRepository {
  final ReviewService reviewService;
  ReviewRepository(this.reviewService);

  Future<List<Review>> getReviews(gameId) async {
    return await reviewService.getReviews(gameId);
  }

  Future<Review> getReview(String id) async {
    return await reviewService.getReview(id);
  }

  Future<Review> createReview(Review review, gameId) async {
    return await reviewService.createReview(review, gameId);
  }

  Future<Review> updateReview(String id, Review review) async {
    return await reviewService.updateReview(id, review);
  }

  Future<void> deleteReview(String id, String gameId) async {
    return await reviewService.deleteReview(id, gameId);
  }
}
