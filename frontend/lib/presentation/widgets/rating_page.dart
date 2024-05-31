import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/review/review_bloc.dart';
import 'package:frontend/review/review_event.dart';
import 'package:frontend/review/review_model.dart';

class RatingForm extends StatefulWidget {
  @override
  _RatingFormState createState() => _RatingFormState();
}

class _RatingFormState extends State<RatingForm> {
  final TextEditingController reviewController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String gameId = arguments['gameId'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Review'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
              TextFormField(
                controller: reviewController,
                maxLines: null,
                minLines: 2,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white), // Text color set to white
                decoration: InputDecoration(
                  hintText: 'Enter your review here...',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  // Background color of the text field
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a review';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    if (rating == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select a rating')),
                      );
                      return;
                    }
                    if (_formKey.currentState!.validate()) {
                      // Form is valid
                      double ratingValue = rating.toDouble();
                      String review = reviewController.text;

                      final curReview = Review(
                        comment: review,
                        rating: ratingValue,
                        date: DateTime.now().toString(),
                      );

                      BlocProvider.of<ReviewBloc>(context).add(
                        AddReview(curReview, gameId),
                      );

                      Navigator.pushReplacementNamed(context, '/review',
                          arguments: {'gameId': gameId});
                    }
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
      ),
    );
  }
}
