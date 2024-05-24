import 'package:flutter/material.dart';

class ClickableStar extends StatefulWidget {
  final int rating;
  final ValueChanged<int> onRatingChanged;

  ClickableStar({this.rating = 0, required this.onRatingChanged});

  @override
  _ClickableStarState createState() => _ClickableStarState();
}

class _ClickableStarState extends State<ClickableStar> {
  late int _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.rating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final isSelected = index < _rating;
        final starColor = isSelected ? Colors.yellow : Colors.grey;

        return GestureDetector(
          onTap: () {
            setState(() {
              _rating = index + 1;
            });
            widget.onRatingChanged(_rating);
          },
          child: Icon(
            isSelected ? Icons.star : Icons.star_border,
            color: starColor,
          ),
        );
      }),
    );
  }
}
