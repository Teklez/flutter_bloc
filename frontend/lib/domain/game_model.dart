import 'package:equatable/equatable.dart';

class Game extends Equatable {
  final String id;
  final String name;
  final String description;
  final double rating;
  final String image;
  final String publisher;
  final String releaseDate;

  Game({
    this.id = "",
    required this.name,
    this.rating = 0.0,
    required this.image,
    this.description = "",
    this.publisher = "",
    this.releaseDate = "",
  });

  @override
  List<Object?> get props =>
      [id, name, description, rating, image, publisher, releaseDate];

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['_id'] ??
          "", // Ensure to provide a default value if '_id' is null
      name: json['name'] ??
          "", // Ensure to provide a default value if 'name' is null
      description: json['description'] ?? "",
      rating: json['rating'] != null
          ? double.parse(json['rating'].toString())
          : 0.0, // Parse rating to double
      image: json['image'] ?? "",
      publisher: json['publisher'] ?? "",
      releaseDate: json['releaseDate'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'rating': rating,
      'image': image,
      'publisher': publisher,
      'releaseDate': releaseDate,
    };
  }
}
