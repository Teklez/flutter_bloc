class Review {
  final String id;
  final String username;
  final String comment;
  final double rating;
  final String date;

  Review(
      {this.id = '',
      required this.username,
      required this.comment,
      required this.rating,
      required this.date});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      username: json['username'],
      comment: json['comment'],
      rating: json['rating'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'comment': comment,
      'rating': rating,
      'date': date,
    };
  }
}
