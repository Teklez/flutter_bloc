class Review {
  final String id;
  final String comment;
  final double rating;
  final String date;

  Review(
      {this.id = '',
      required this.comment,
      required this.rating,
      required this.date});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      comment: json['comment'],
      rating: json['rating'].toDouble(),
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'comment': comment,
      'rating': rating,
      'date': date,
    };
  }
}
