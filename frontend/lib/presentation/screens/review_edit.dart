import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/presentation/widgets/clickableStar.dart';
import 'package:frontend/presentation/widgets/rating.dart';
import 'package:frontend/review/review_bloc.dart';
import 'package:frontend/review/review_event.dart';
import 'package:frontend/review/review_model.dart';

class ReviewEdit extends StatefulWidget {
  final review;
  const ReviewEdit({Key? key, this.review}) : super(key: key);

  @override
  _ReviewEditState createState() => _ReviewEditState();
}

class _ReviewEditState extends State<ReviewEdit> {
  final _formKey = GlobalKey<FormState>();
  final _reviewController = TextEditingController();

  double _rating = 0;

  @override
  void initState() {
    super.initState();
    if (widget.review['data'] != null) {
      _reviewController.text = widget.review!['data'].comment;
      _rating = widget.review!['data'].rating;
    }
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _submitForm(constext) {
    if (_formKey.currentState!.validate()) {
      // Update review
      BlocProvider.of<ReviewBloc>(context).add(
        EditReview(
          Review(
            id: widget.review!['data'].id,
            comment: _reviewController.text,
            rating: _rating,
            date: widget.review!['data'].date,
          ),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit your review'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  AssetImage("assets/profile2.jpg"),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Hanna A.",
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
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        RatingStar(rating: _rating),
                        const SizedBox(width: 10),
                        Text(
                          '10/10/2021',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[350],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ClickableStar(
                            rating: _rating.toInt(),
                            onRatingChanged: (newRating) {
                              setState(() {
                                _rating = newRating.toDouble();
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _reviewController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: "Write your review here...",
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 108, 187, 252),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fillColor: Colors.black,
                              filled: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your review';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () => _submitForm(context),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
