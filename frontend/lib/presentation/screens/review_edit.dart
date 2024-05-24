import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/presentation/widgets/clickableStar.dart';

import 'package:frontend/presentation/widgets/rating.dart';

import 'package:readmore/readmore.dart';
import 'package:flutter/material.dart';

class ReviewEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit your review'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, "/review");
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage("assets/profile2.jpg"),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Hanna A. ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[350],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  RatingStar(rating: 3),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "1 April 2024",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[350],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const ReadMoreText(
                'The user interface of the app is quite intuitive, I was able to navigate and play seamlessly. Great job!',
                trimLines: 1,
                style: const TextStyle(color: Colors.white),
                trimMode: TrimMode.Line,
                trimExpandedText: "show less",
                trimCollapsedText: "show more",
                moreStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                lessStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ClickableStar(
                      rating: 0,
                      onRatingChanged: (newRating) {
                        // backend
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 45.0,
                                horizontal: 20.0,
                              ),
                              labelText: "Write your review here...",
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: const Color.fromARGB(
                                    255,
                                    108,
                                    187,
                                    252,
                                  ),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fillColor: Colors.black,
                              filled: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/review");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
