import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingStar extends StatelessWidget {
  final double rating;

  const RatingStar({
    required this.rating,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemCount: 5,
      itemSize: 20,
      unratedColor: Colors.grey,
      itemBuilder: (context, index) {
        return Icon(
          Icons.star,
          // for backend
          color: index < rating.floor() ? Colors.yellow : Colors.grey,
          size: 10,
        );
      },
    );
  }
}
