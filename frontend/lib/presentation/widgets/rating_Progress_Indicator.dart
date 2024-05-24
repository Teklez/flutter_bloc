import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingProgressIndicator extends StatelessWidget {
  const RatingProgressIndicator(
      {super.key, required this.text, required this.value});

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.normal, color: Colors.grey[200]),
          ),
        ),
        Expanded(
          flex: 11,
          child: SizedBox(
            child: LinearProgressIndicator(
              value: value,
              minHeight: 15,
              backgroundColor: Colors.grey[300],
              borderRadius: BorderRadius.circular(7),
              valueColor:
                  AlwaysStoppedAnimation(Color.fromARGB(255, 177, 63, 63)),
            ),
          ),
        ),
      ],
    );
  }
}
