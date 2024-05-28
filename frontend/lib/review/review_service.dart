import 'package:frontend/review/review_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReviewService {
  static const String baseUrl = 'http://localhost:5500/reviews';

  Future<List<Review>> getReviews(String gameId) async {
    print("Fetching reviews for gameId: $gameId");
    try {
      final response = await http.get(Uri.parse('$baseUrl/game/$gameId'));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<Review> reviews =
            body.map((item) => Review.fromJson(item)).toList();

        return reviews;
      } else {
        print("Error: ${response.statusCode}");
        throw "Failed to load reviews";
      }
    } catch (e) {
      print("Error fetching reviews: $e");
      throw "Failed to load reviews";
    }
  }

  Future<Review> getReview(String id) async {
    final response = await http.get(Uri.parse(baseUrl + 'reviews/' + id));
    if (response.statusCode == 200) {
      return Review.fromJson(jsonDecode(response.body));
    } else {
      throw "Failed to load review";
    }
  }

  Future<Review> createReview(Review review, gameId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/game/$gameId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(review.toJson()),
    );
    if (response.statusCode == 201) {
      return Review.fromJson(jsonDecode(response.body));
    } else {
      throw "Failed to create review";
    }
  }

  Future<Review> updateReview(String id, Review review) async {
    final response = await http.put(
      Uri.parse(baseUrl + 'reviews/' + id),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(review.toJson()),
    );
    if (response.statusCode == 200) {
      return Review.fromJson(jsonDecode(response.body));
    } else {
      throw "Failed to update review";
    }
  }

  Future<void> deleteReview(String id) async {
    final response = await http.delete(Uri.parse(baseUrl + 'reviews/' + id));
    if (response.statusCode != 204) {
      throw "Failed to delete review";
    }
  }
}
