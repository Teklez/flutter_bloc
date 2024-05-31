import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/application/review/review_bloc.dart';
import 'package:frontend/domain/storage/storage.dart';
import 'package:frontend/presentation/events/review_event.dart';
import 'package:frontend/domain/review_model.dart';
import 'package:go_router/go_router.dart';

class RatingForm extends StatefulWidget {
  final String gameId;
  const RatingForm({Key? key, required this.gameId}) : super(key: key);

  @override
  _RatingFormState createState() => _RatingFormState();
}

class _RatingFormState extends State<RatingForm> {
  final TextEditingController reviewController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int rating = 0;
  var _currentUser;
  @override
  void initState() {
    super.initState();
    getuser();
  }

  Future<void> getuser() async {
    final user = await UserPreferences.getCurrentUser();
    setState(() {
      _currentUser = user;
    });
  }

  String formatCurrentDate() {
    DateTime now = DateTime.now();
    List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    String month = months[now.month - 1];
    String day = now.day.toString();
    String year = now.year.toString();

    return "$month $day, $year";
  }

  @override
  Widget build(BuildContext context) {
    final String gameId = widget.gameId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Review'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'If you enjoy this app, take a moment to rate it?',
                  style: TextStyle(fontSize: 14.0),
                ),
                const SizedBox(height: 50.0),
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
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: reviewController,
                  maxLines: null,
                  minLines: 2,
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white), // Text color set to white
                  decoration: InputDecoration(
                    hintText: 'Enter your review here...',
                    hintStyle: const TextStyle(color: Colors.grey),
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
                const SizedBox(height: 24.0),
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
                          username: _currentUser,
                          comment: review,
                          rating: ratingValue,
                          date: formatCurrentDate(),
                        );

                        BlocProvider.of<ReviewBloc>(context).add(
                          AddReview(curReview, gameId),
                        );

                        context.pop();
                        context.pushReplacement('/review',
                            extra: {"gameId": gameId});
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
