import 'package:flutter/material.dart';

Widget inputForm(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.5, color: Colors.grey),
        ),
        child: const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
    ],
  );
}
