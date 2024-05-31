import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/dialogues.dart';
import 'package:frontend/presentation/widgets/rating.dart';
import 'package:frontend/domain/review_model.dart';
import 'package:readmore/readmore.dart';

class UserReview extends StatelessWidget {
  final gameId;
  final Review review;
  const UserReview({Key? key, required this.review, this.gameId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[800]!.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_circle,
                      color: Colors.grey[350],
                      size: 30,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      review.username,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[350],
                      ),
                    ),
                  ],
                ),
                EditDeleteDialogue(
                  route: "/review-edit",
                  data: {
                    'data': review,
                    'gameId': gameId
                  }, // Assuming gameName is a relevant data field
                  feature: "review",
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                RatingStar(
                    rating: review.rating), // Assuming rating is a double
                const SizedBox(width: 10),
                Text(
                  review.date, // Assuming date is a String
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[350],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ReadMoreText(
              review.comment,
              trimLines: 5,
              style: TextStyle(color: Colors.grey[200]),
              trimMode: TrimMode.Line,
              trimExpandedText: "show less",
              trimCollapsedText: "show more",
              moreStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
              lessStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
