import 'package:flutter/material.dart';

class RatingForm extends StatefulWidget {
  @override
  _RatingFormState createState() => _RatingFormState();
}

class _RatingFormState extends State<RatingForm> {
  TextEditingController reviewController = TextEditingController();
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add review'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'If you enjoy this app, take a moment to rate it?',
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 5; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        rating = i;
                      });
                    },
                    child: Icon(
                      Icons.star,
                      size: 40.0,
                      color: i <= rating ? Colors.yellow : Colors.grey,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white)),
              ),
              child: Container(
                constraints: BoxConstraints(maxHeight: 100.0),
                child: TextField(
                  controller: reviewController,
                  maxLines: null,
                  minLines: 2,
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter your review here...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                onPressed: () {
                  //String review = reviewController.text;
                  // backend
                  //print('Rating: $rating');
                  //print('Review: $review');
                  Navigator.pop(context);
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
