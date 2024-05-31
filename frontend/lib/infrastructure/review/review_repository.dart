import 'package:frontend/domain/review_model.dart';
import 'package:frontend/domain/storage/storage.dart';
import 'package:frontend/infrastructure/review/review_service.dart';

class ReviewRepository {
  final ReviewService reviewService;
  ReviewRepository(this.reviewService);

  Future<List<Review>> getReviews(gameId) async {
    try {
      return await reviewService.getReviews(gameId);
    } catch (e) {
      throw Exception('Error fetching reviews from repository: $e');
    }
  }

  Future<Review> getReview(String id) async {
    return await reviewService.getReview(id);
  }

  Future<Review> createReview(Review review, gameId) async {
    final username = await UserPreferences.getCurrentUser();
    return await reviewService.createReview(review, gameId, username);
  }

  Future<Review> updateReview(String id, Review review) async {
    return await reviewService.updateReview(id, review);
  }

  Future<void> deleteReview(String id, String gameId) async {
    try {
      return await reviewService.deleteReview(id, gameId);
    } catch (e) {
      throw Exception('Error deleting review from repository: $e');
    }
  }
}
