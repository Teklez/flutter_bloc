import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/rating_Progress_Indicator.dart';
import 'package:frontend/presentation/widgets/user_review_card.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(context),
    );
  }

  Widget content(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: const Icon(
              Icons.home,
            ),
          )),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Ratings and reviews are verified and are from people who use the same type of device that you use.",
                style: TextStyle(color: Colors.grey[200]),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "4.8",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[350],
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        RatingProgressIndicator(
                          text: "5",
                          value: 1.0,
                        ),
                        RatingProgressIndicator(
                          text: "4",
                          value: 0.8,
                        ),
                        RatingProgressIndicator(
                          text: "3",
                          value: 0.6,
                        ),
                        RatingProgressIndicator(
                          text: "2",
                          value: 0.4,
                        ),
                        RatingProgressIndicator(
                          text: "1",
                          value: 0.8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const RatingStar(
                rating: 4.5,
                //later use backend
              ),
              Text(
                "12,345",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Rate this app',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Share you experience with us',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/review-page');
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade500,
                                  offset: const Offset(2.0, 2.0),
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0),
                              const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-1.0, -1.0),
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0)
                            ],
                            color: const Color.fromARGB(255, 76, 71, 71)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "What do you think of this Game?",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 110,
                                  ),
                                  RatingStar(
                                    rating: 0,
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        height: 90,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 20),
              UserReview(),
              UserReview(),
              UserReview(),
            ],
          ),
        ),
      ),
    );
  }
}

class RatingStar extends StatelessWidget {
  final double rating;
  final TextStyle? style;

  const RatingStar({
    Key? key,
    required this.rating,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          Icons.star,
          color: index < rating.round() ? Colors.amber : Colors.grey,
          size: style?.fontSize ?? 16,
        ),
      ),
    );
  }
}
